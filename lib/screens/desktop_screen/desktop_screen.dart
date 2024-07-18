
import 'package:flutter/material.dart';

class DeskTopScreen extends StatefulWidget {
  const DeskTopScreen({super.key});

  @override
  State<DeskTopScreen> createState() => _DeskTopScreenState();
}

class _DeskTopScreenState extends State<DeskTopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: InteractiveViewer(
/** 
 In this approach, the LayoutBuilder ensures that the SingleChildScrollView takes the 
 full height of the screen. The ConstrainedBox with minHeight equal to constraints. 
 maxHeight ensures the Center widget centers its child vertically within the available
  space. 
 */
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                    crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
                    children: [
                     Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bolt, color: Colors.black, size: 40),
                          SizedBox(width: 10),
                          Text(
                            'ashleyStorm',
                            style: TextStyle(
                                color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('Desktop version coming soon', style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}