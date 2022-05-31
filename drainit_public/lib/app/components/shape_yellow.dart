import 'package:drainit_flutter/app/components/constant.dart';
import 'package:flutter/material.dart';

class ShapeCustomYellow extends StatelessWidget {
  const ShapeCustomYellow(
      {Key? key, this.height, this.width, this.borderRadius,})
      : super(key: key);
  final double? height;
  final double? width;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
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
                    color: textGrey,),
              ),
            ],
          ),
        ],),
      ),
    );
  }
}
