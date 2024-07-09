import 'package:flappy_bird/flappy_bird_image_strings/flappy_bird_image_strings.dart';
import 'package:flutter/material.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({super.key});

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {

  // we'll use this variable to change the bird's position on the Y-Axis
  double birdYAxis = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // expanded widgets take up all available space provided 
          Expanded(
            // flex dictates how much more space the expanded widget must occupy
            flex: 2,
            // animatedContainer will animate our flappy bird
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 0),
              /// x = 0 is horizontal, y = 0 is vertical
              /// x = -1 will return the child widget to the left-most section of the page on the horizontal axis
              /// basically mimics the co-ordinates of a cartesian plane
              alignment: Alignment(0, birdYAxis), // x = 0  places the bird in the middle, birdYAxis changes the bird's position 1/2
                                                // on the Y-axis, giving us that bouncing effect
              color: Colors.blue,
              child: const MyBird(),
            ),
          ),
          Expanded(
            child: Container(color: Colors.green),
          ),
        ],
      ),
    );
  }
}


class MyBird extends StatelessWidget {
  const MyBird({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 60,
      width: 60,
      child: Image.asset(
        FBIMages.fbFlappyBird
      ),
    );
  }
}