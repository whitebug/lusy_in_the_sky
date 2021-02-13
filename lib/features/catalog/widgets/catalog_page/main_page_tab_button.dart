import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPageTabButton extends StatelessWidget {
  final String icon;
  final String text;
  final Function() onPressed;
  final bool current;
  const MainPageTabButton({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onPressed,
    @required this.current,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(55),
      height: ScreenUtil().setHeight(37),
      child: FlatButton(
        onPressed: onPressed,
        padding: EdgeInsets.all(ScreenUtil().setSp(0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: ScreenUtil().setWidth(22),
              height: ScreenUtil().setHeight(21),
              child: Image.asset(icon),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setHeight(4),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: current ? FontWeight.bold : FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
