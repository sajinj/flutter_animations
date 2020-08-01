import 'package:flutter/material.dart';

class TransformationAnimationWidget extends StatefulWidget {
  @override
  TransformationAnimationWidgetState createState() =>
      TransformationAnimationWidgetState();
}

class TransformationAnimationWidgetState
    extends State<TransformationAnimationWidget> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> transitionTween;
  Animation<BorderRadius> borderRadius;
  Animation<Color> colorTween;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          _controller.reset();
        }
      });

    transitionTween = Tween<double>(
      begin: 50.0,
      end: 200.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(75.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    colorTween = ColorTween(
      begin: Colors.black12,
      end: Colors.green,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      )
    );
     
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
            body: new Center(
          child: InkWell(
            child: Container(
              alignment: Alignment.center,
              width: transitionTween.value,
              height: transitionTween.value,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: borderRadius.value,
              ),
              child: Text("data"),
            ),
            onTap: ()=>{
              _controller.forward()
              },
          ),
        ),
          appBar: AppBar(title: Text("salam"),backgroundColor: colorTween.value,),
        
        );
          
      },
    );
  }
}
