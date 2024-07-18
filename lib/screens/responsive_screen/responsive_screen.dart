import 'package:flappy_bird/screens/desktop_screen/desktop_screen.dart';
import 'package:flappy_bird/screens/mobile_screen/mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        // Set a threshold for mobile screen width
        const double mobileScreenWidth = 600;
        // Set a threshold for desktop screen width
        const double desktopScreenWidth = 1024;

        if (screenWidth < mobileScreenWidth) {
          // Lock orientation to portrait mode
          _portraitModeOnly();
          return const MobileScreen();
        } else if (screenWidth < desktopScreenWidth) {
          // Lock orientation to landscape mode
          _landscapeModeOnly();
          return const DeskTopScreen();
        } else {
          // Default to desktop screen, lock orientation to landscape mode
          _landscapeModeOnly();
          return const DeskTopScreen();
        }
      },
    );
  }

  /// Locks orientation to portrait mode
  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Locks orientation to landscape mode
  void _landscapeModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
