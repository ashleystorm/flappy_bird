import 'dart:async';

import 'package:flappy_bird/barrier/barrier.dart';
import 'package:flappy_bird/flappy_bird_image_strings/flappy_bird_image_strings.dart';
import 'package:flutter/material.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 1.5;
  static double birdYAxis = 0; // initialise the y-axis
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool gameHasStarted = false;
  int score = 0;
  int bestScore = 0;
  double barrierSpeed = 0.05;

  // jump method
  void jump() {
    setState(() {
      time = 0; // time is essentially restarted when we want to invoke a new jump (by new tap)
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time; //y = -4.9(t^2) + 2.8t  <-- gravity equation
      setState(() {
        birdYAxis = initialHeight - height;
      });

      // Move barriers
      moveBarriers();

      // Check for game over
      if (birdYAxis > 1 || _isBirdCollidingWithBarrier()) {
        score > bestScore ? bestScore = score: bestScore;
        // if score is greater than bestScore then assign new score as best score, else return bestScore
        timer.cancel();
        gameHasStarted = false;
        _showGameOverDialog();
      }
    });
    
  }

  void moveBarriers() {
    setState(() {
      if (barrierXOne < -2) {
        barrierXOne += 3.5;
        score++;
        if (score > 5 && score % 5 == 0) {
          barrierSpeed += 0.01; // increase speed after every 5 points
        }
      } else {
        barrierXOne -= barrierSpeed;
      }
    });
    setState(() {
      if (barrierXTwo < -2) {
        barrierXTwo += 3.5;
        score++;
        if (score > 5 && score % 5 == 0) {
          barrierSpeed += 0.01; // increase speed after every 5 points
        }
      } else {
        barrierXTwo -= barrierSpeed;
      }
    });

  }

  bool _isBirdCollidingWithBarrier() {
    // Add collision detection logic
    if ((barrierXOne <= 0.15 && barrierXOne >= -0.15) ||
        (barrierXTwo <= 0.15 && barrierXTwo >= -0.15)) {
      if (birdYAxis < -0.6 || birdYAxis > 0.6) {
        return true;
      }
    }
    return false;
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: const Text("You have crashed!"),
          actions: [
            TextButton(
              child: const Text("Play Again"),
              onPressed: () {// Close the dialog
                  resetGame();
              },
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    Navigator.pop(context); // dismisses the alert dialog
    setState(() {
      birdYAxis = 0;
      gameHasStarted = false;
      time = 0;
      score = 0;
      initialHeight = birdYAxis;
      barrierXOne = 2;
      barrierXTwo = barrierXOne + 1.5;
      barrierSpeed = 0.05; // Reset the barrier speed
      moveBarriers();
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          Navigator.of(context).popUntil((route) => route.isFirst); // Ensure all dialogs are closed
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: const FlappyBird(),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.3),
                    child: gameHasStarted
                        ? const Text("")
                        : const Text('T A P  T O  P L A Y',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  // barriers
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 100.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barrier(
                      size: 200.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 15, color: Colors.green), // grass
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('SCORE',
                            style: TextStyle(color: Colors.white, fontSize: 20)),
                        const SizedBox(height: 10),
                        Text('$score',
                            style:
                                const TextStyle(color: Colors.white, fontSize: 30)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('BEST',
                            style: TextStyle(color: Colors.white, fontSize: 20)),
                        const SizedBox(height: 10),
                        Text('$bestScore',
                            style:
                                const TextStyle(color: Colors.white, fontSize: 30)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// flappy bird class
class FlappyBird extends StatelessWidget {
  const FlappyBird({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      child: Image.asset(
        FBImages.fbIFlappyBird
      ),
    );
  }
}
/** 
      // Check for game over
      if (birdYAxis > 1 || _isBirdCollidingWithBarrier()) {
        score > bestScore ? bestScore = score: bestScore;
        // if score is greater than bestScore then assign new score as best score, else return bestScore
        timer.cancel();
        gameHasStarted = false;
        _showGameOverDialog();
      }
*/ 