import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPageCentralButton extends StatelessWidget {
  final String icon;
  final Function() onPressed;
  const MainPageCentralButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(40),
      height: ScreenUtil().setHeight(38),
      child: FlatButton(
        onPressed: onPressed,
        padding: EdgeInsets.all(ScreenUtil().setSp(0)),
        child: Image.asset(icon),
      ),
    );
  }
}
