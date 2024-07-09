import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  const Barrier({super.key, this.size});

  final size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration:  BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 10, color: const Color.fromARGB(255, 3, 116, 6)),
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}