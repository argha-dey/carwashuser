import 'package:flutter/cupertino.dart';

class NavigatorAnimation {
  BuildContext context;
  dynamic page;

  NavigatorAnimation(this.context, this.page);

  dynamic navigate() async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => page),
    );

    return result;
  }

  dynamic replaceNavigate() {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => page,
      ),
    );
  }

  dynamic pushAndRemove() {
    Navigator.pushAndRemoveUntil(context,
        CupertinoPageRoute(builder: (context) => page), (route) => false);
  }

  dynamic fadeNavigate() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (BuildContext context) => page),
    );
  }

  dynamic navigateFromLeft() async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => page,
      ),
    );
    return result;
  }

  Future navigateFromRight() async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => page,
      ),
    );
    return result;
  }

  dynamic navigateFromTop() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => page,
      ),
    );
  }

  dynamic navigateFromBottom() {
    Navigator.push(
      context,
      OnDifferentSide(
        builder: (context) => page,
        offset: const Offset(0.0, 1.0),
      ),
    );
  }
}

class OnDifferentSide<T> extends CupertinoPageRoute<T> {
  final dynamic offset;

  OnDifferentSide(
      {WidgetBuilder? builder, RouteSettings? settings, this.offset})
      : super(builder: builder!, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      child: child,
      position: Tween<Offset>(
        begin: offset,
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 650);
}

class FadeNavigation<T> extends CupertinoPageRoute<T> {
  FadeNavigation({WidgetBuilder? builder, RouteSettings? settings})
      : super(builder: builder!, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);
}
