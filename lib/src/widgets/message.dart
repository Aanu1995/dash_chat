import 'package:dash_chat/src/widgets/message_clipper.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final Widget child;
  final bool isRight;
  final Color color;
  final EdgeInsetsGeometry padding;
  const MessageBox({this.child, this.isRight = true, this.padding, this.color});

  final double size = 30.0;
  final double top = 1.0;
  final double direction = 2.7;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: isRight ? Alignment.topRight : Alignment.topLeft,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: isRight
                ? BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
          ),
          child: child,
        ),
        isRight
            ? Positioned(
                top: top,
                right: direction,
                child: Card(
                  child: SizedBox.expand(
                    child: ClipPath(
                      clipper: MessageClipper(),
                      child: Container(
                        color: color,
                      ),
                    ),
                  ),
                ),
              )
            : Positioned(
                top: top,
                left: direction,
                child: Card(
                  child: SizedBox.expand(
                    child: ClipPath(
                      clipper: MessageClipper2(),
                      child: Container(
                        color: color,
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
