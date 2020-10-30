import 'package:flutter/material.dart';

// This class is being used to animate transition between two pages,
// but for individual pages that you specify.
class CustomRoute<T> extends MaterialPageRoute<T> {
  // <T> represents generic type.
  CustomRoute({
    WidgetBuilder builder,
    RouteSettings settings,
  }) : super(
          builder: builder,
          settings: settings,
        );
  // super is used to send everything recieved,
  // to parent classs i.e. MaterialPageRoute
  // to ensure all kind of animations can be accepted.

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // TODO: implement buildTransitions
    if (settings.name == '/') {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

// This class is being used to animate transition between two pages,
// but for all pages.
class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  // PageRoute<T> having a generic type ensures that this works with
  // different routes that will load different pages and return
  // different values when they are popped off.
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // TODO: implement buildTransitions
    if (route.settings.name == '/') {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
