import 'package:flutter/material.dart';

class RightSlide extends PageRouteBuilder {
  final Widget child;

  RightSlide({
    required this.child,
  }) : super(
          transitionDuration: Duration(milliseconds: 100),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
}


class AscendSlide extends PageRouteBuilder {
  final Widget child;

  AscendSlide({
    required this.child,
  }) : super(
          transitionDuration: Duration(milliseconds: 150),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
}



class LeftSlide extends PageRouteBuilder {
  final Widget child;

  LeftSlide({
    required this.child,
  }) : super(
          transitionDuration: Duration(milliseconds: 100),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
}
