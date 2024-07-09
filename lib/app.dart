import 'package:flappy_bird/screens/mobile_screen/mobile_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      
/** 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black12),
      ),
*/
      home: MobileScreen(),
/** 
      routes: {
        '/ReadMorePage': (context) => const ReadMorePage(),
        '/Home': (context) => const ResponsiveScreen(),
      },
*/
    );
  }
}