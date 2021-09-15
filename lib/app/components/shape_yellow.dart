import 'package:flutter/material.dart';
import 'constant.dart';

class ShapeCustomYellow extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  const ShapeCustomYellow(
      {Key? key, this.height, this.width, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: primary,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius!))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Masuk",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Masuk Untuk",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: textGrey),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
