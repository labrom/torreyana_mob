import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Guillotine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Matrix4dPlayground extends StatefulWidget {
  @override
  _Matrix4dPlaygroundState createState() => _Matrix4dPlaygroundState();
}

class _Matrix4dPlaygroundState extends State<Matrix4dPlayground> {
  double x = 0;
  double y = 0;
  double z = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        transform: Matrix4(
          1,
          0,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          1,
        )
          ..rotateX(x)
          ..rotateY(y)
          ..rotateZ(z),
        alignment: FractionalOffset.center,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              y = y - details.delta.dx / 100;
              x = x + details.delta.dy / 100;
            });
          },
          child: Container(
            color: Colors.red,
            height: 200.0,
            width: 200.0,
          ),
        ),
      ),
    );
  }
}
