import 'dart:math';

import 'package:awsomeflutter/page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimRoute extends StatefulWidget {
  @override
  _AnimRouteState createState() => _AnimRouteState();
}

class _AnimRouteState extends State<AnimRoute> with TickerProviderStateMixin {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.red;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("anim"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("fade"),
              onPressed: (){
                setState(() {
                  _visible = !_visible;
                });
              },
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  final random = Random();

                  // Generate a random width and height.
                  _width = random.nextInt(300).toDouble();
                  _height = random.nextInt(300).toDouble();

                  // Generate a random color.
                  _color = Color.fromRGBO(
                    random.nextInt(256),
                    random.nextInt(256),
                    random.nextInt(256),
                    1,
                  );

                  // Generate a random border radius.
                  _borderRadius =
                      BorderRadius.circular(random.nextInt(100).toDouble());
                });
              },
              child: Text("animate cont"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute(this));
              },
              child: Text("transition"),
            ),
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: AnimatedContainer(
                width: _width,
                height: _height,
                decoration:
                    BoxDecoration(color: _color, borderRadius: _borderRadius),
                duration: Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Route _createRoute(TickerProvider c) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionDuration: Duration(seconds: 1),
    barrierColor: Colors.purple,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        child: child,
        position: animation.drive(tween),
      );
    },
  );
}

