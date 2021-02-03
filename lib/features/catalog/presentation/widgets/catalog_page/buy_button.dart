import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyButton extends StatelessWidget {
  final Function() onTap;
  const BuyButton({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: ScreenUtil().setWidth(15),
      bottom: ScreenUtil().setHeight(259),
      child: Container(
        width: ScreenUtil().setWidth(32),
        height: ScreenUtil().setHeight(32),
        child: FlatButton(
          onPressed: onTap,
          padding: EdgeInsets.all(ScreenUtil().setSp(0)),
          child: Image.asset(
            'assets/button_images/main.png',
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
