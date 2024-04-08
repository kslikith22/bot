import 'package:bot/presentation/master_screen/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return PageTransition(
          child: MasterScreen(),
          type: PageTransitionType.rightToLeft,
        );
      default:
        return null;
    }
  }
}
