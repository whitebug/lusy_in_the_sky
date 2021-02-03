import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteButton extends StatelessWidget {
  final Function() onTap;
  const FavoriteButton({
    Key key, @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: ScreenUtil().setWidth(15),
      bottom: ScreenUtil().setHeight(315),
      child: Container(
        width: ScreenUtil().setWidth(36),
        height: ScreenUtil().setHeight(36),
        child: FlatButton(
          onPressed: onTap,
          padding: EdgeInsets.all(ScreenUtil().setSp(0)),
          child: Image.asset('assets/icons/heart.png'),
        ),
      ),
    );
  }
}