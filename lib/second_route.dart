import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller2;

  Animation _animation;
  Animation<Color> _bgbackground;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    _controller2 =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    _bgbackground =
        ColorTween(begin: Colors.red, end: Colors.blue).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.ease,
    ))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) _controller2.reverse();
            if (status == AnimationStatus.dismissed) _controller2.forward();
          });

    init();
  }

  void handler(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(handler);
      _controller.reset();
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ))
        ..addStatusListener(handler2);
      _controller.forward();
    }
  }

  void handler2(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(handler2);
      _controller.reset();
      init();
    }
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void init() {
    _animation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn))
      ..addStatusListener(handler);
  }

  @override
  Widget build(BuildContext context) {
    int i = 1;
    String boxText = "start";
    final double width = MediaQuery.of(context).size.width;
    _controller.forward();

    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
              body: Container(
            color: _bgbackground.value,
            child: Transform(
              transform:
                  Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
              child: new Center(
                  child: GestureDetector(
                      child: Container(
                          alignment: Alignment.center,
                          width: 200.0,
                          height: 200.0,
                          color: Colors.green,
                          child: Text(
                            boxText,
                            style: TextStyle(fontSize: 24),
                          )),
                      onTap: () {
                        i++;
                        if (i % 2 == 0) {
                          _controller2.forward();
                          boxText = "stop";
                        } else {
                          _controller2.stop();
                          boxText = "start";
                        }
                      })),
            ),
          ));
        });
  }
}
