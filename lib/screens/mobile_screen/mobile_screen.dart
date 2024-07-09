import 'dart:async';

import 'package:flappy_bird/barriers/barriers.dart';
import 'package:flappy_bird/flappy_bird_image_strings/flappy_bird_image_strings.dart';
import 'package:flutter/material.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {

  // we'll use this variable to change the bird's position on the Y-Axis
  static double birdYAxis = 0; 
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  /// when assigning the birdYAxis value to initialHeigh and encounter an error that reads 'the instance member 'birdYAxis'
  /// can't be accessed in an initializer' we assign the static keyword to the initialisation of the variable
  bool gameHasStarted = false;  // initialises the condition where the game starts prior to screen tap
  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 2;


  void startGame(){
    gameHasStarted = true;
    initialHeight = birdYAxis;  // initialise the height
    Timer.periodic(const Duration(milliseconds: 60), (timer) {   // <-- for every x milliseconds, the below code is executed
      time += 0.05;// increment our time 
      /// parabolic equation implementation (see documentation) y = -(9.8(t)^2)/2 + 5t 
      /// --> y = -4.9(t)^2 + 5t
      height = -4.9 * time * time + 2.8 * time;
      /// this implementation calculates the time at each frame, where time
      /// is incremented by 0.1 as seen above the height 
      
      setState(() {
        birdYAxis = initialHeight - height; // this will move the bird up the y-axis when the screen is tapped
        barrierXOne -= 0.05;
        barrierXTwo -= 0.05;
      });
      
      // barrierXOne incrementation
      setState(() {
      // barrierXOne incrementation
      if (barrierXOne < -2){    // if the first barrier is off the edge to the left
        barrierXOne += 3.5;         // we increase its value by 2, making it reappear later on
      }else{
        barrierXOne -= 0.05;
      }

      });

      // barrierXTwo incrementation
      setState(() {
      // barrierXOne incrementation
      if (barrierXTwo < -2){    // if the first barrier is off the edge to the left
        barrierXTwo += 3.5;         // we increase its value by 2, making it reappear later on
      }else{
        barrierXTwo -= 0.05;
      }

      });


      // once the value of Y reaches 1 / "bottom" on the vertical axis, the timer is stopped using timer.cancel() method
      if (birdYAxis > 1){
        timer.cancel();
        gameHasStarted = false; // at this condition, the bird has reached the bottom of the screen, which effectively ends the game
      }
     });
  }
  
  // function to handle jumps
  void jump(){
    // this will move the bird up the y-axis when the screen is tapped
    setState(() {
      time = 0;   // time in this case is where, each time a user executes a new jump, time is t zero
      initialHeight = birdYAxis;  // initialHeight here is wherever the user is on screem
    });
  }
  


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          if (gameHasStarted){
            // if the game has started, we will call the jump() function
            jump();
          }else{
            // invokes game logic
            startGame();
          }
        },     
      child: Scaffold(
        body: Column(
          children: [
            // expanded widgets take up all available space provided 
            Expanded(
              // flex dictates how much more space the expanded widget must occupy
              flex: 3,
              // animatedContainer will animate our flappy bird
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
                    /// x = 0 is horizontal, y = 0 is vertical
                    /// x = -1 will return the child widget to the left-most section of the page on the horizontal axis
                    /// basically mimics the co-ordinates of a cartesian plane
                    alignment: Alignment(0, birdYAxis), // x = 0  places the bird in the middle, birdYAxis changes the bird's position 1/2
                                                        // on the Y-axis, giving us that bouncing effect 2/2
                    color: Colors.blue,
                    child: const MyBird(),
                  ),
                  // tap to play heading
                  Container(
                    alignment: const Alignment(0, -0.5),
                     child: gameHasStarted ? const Text(""): const Text('T A P  T O  P L A Y', style: TextStyle(fontSize: 20, color: Colors.white)),
                     // one line conditional statement: if gameHasStarted (?) then the text will disappear = true; else if false the show text
                  ),
      
                  // barrier(s):
                 AnimatedContainer(
                   duration: const Duration(milliseconds: 0),   // duration is the length of the animation
                   alignment:  Alignment(barrierXOne, 1.1),  // 1.1 places the barrier just beneath the  'grass' container
                   child: const Barrier(
                    size: 200.0
                   ),
                 ),
                 AnimatedContainer(
                   duration: const Duration(milliseconds: 0),   // duration is the length of the animation
                   alignment:  Alignment(barrierXOne, -1.1),  // -1.1 places the barrier above beneath the  edge of the screen
                   child: const Barrier(
                    size: 200.0
                   ),
                 ),
                AnimatedContainer(
                   duration: const Duration(milliseconds: 0),
                   alignment:  Alignment(barrierXTwo, 1.1),  
                   child: const Barrier(
                    size: 150.0
                   ),
                 ),
                 AnimatedContainer(
                   duration: const Duration(milliseconds: 0),
                   alignment:  Alignment(barrierXTwo, -1.1),  
                   child: const Barrier(
                    size: 250.0
                   ),
                 ),
                ],
              ),
            ),
            Container(color: Colors.green, height: 15), // grass
            Expanded(
              child: Container(
                color: Colors.brown,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('SCORE', style: TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(height: 20),
                        Text('0', style: TextStyle(color: Colors.white, fontSize: 35))
                      ],
                    ),
                    SizedBox(width: 50),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('BEST', style: TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(height: 20),
                        Text('10', style: TextStyle(color: Colors.white, fontSize: 35))
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

//TODO: Implement:
/// dynamic scoring that increments as each barrier is avoided
/// a feature that ends the game when a barrier is crashed into
/// a loop that restarts the game from the starting point when crashed (i.e. when hit the bottom or crashed into barrier)
/// implement a feature that increases the speed after x points are reached (dynamic scoring) (i.e. every 20 points, the speed must increase by 2x)
/// ...as well as a feature that increases the height and frquency of the barriers when the speed increases
/// find out + fix why the desktop screen speeds up so much

class MyBird extends StatelessWidget {
  const MyBird({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return  Container(
      height: 80,
      width: 80,
      child: Image.asset(
        FBIMages.fbFlappyBird
      ),
    );
  }
}