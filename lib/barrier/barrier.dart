import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  
  final size;

  const Barrier({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration:  BoxDecoration(
        color: Colors.green,
        border: Border.all(
          width: 10,
          color: const Color.fromARGB(255, 46, 125, 50),
        ),
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}