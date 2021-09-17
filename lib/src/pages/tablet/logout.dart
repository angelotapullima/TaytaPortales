import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';

class Logout extends StatelessWidget {
  const Logout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preferences = Preferences();
    return Material(
      color: Colors.black.withOpacity(.5),
      child: Stack(
        fit: StackFit.expand,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(150),
              horizontal: ScreenUtil().setWidth(200),
            ),
            child: Column(
              children: [
                Text('Desea Cerrar Sessión?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: ScreenUtil().setWidth(100),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.red,
                        child: Text('no'),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(100),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(100),
                      child: MaterialButton(
                        onPressed: () {
                          preferences.clearPreferences();

                          Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => true);
                        },
                        color: Colors.green,
                        child: Text('si'),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
