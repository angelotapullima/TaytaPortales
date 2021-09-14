import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tayta_restaurant/src/models/productos_model.dart';
import 'package:tayta_restaurant/src/utils/circle.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class AgregarProductTablet extends StatefulWidget {
  const AgregarProductTablet({
    Key key,
    @required this.productos,
  }) : super(key: key);

  final ProductosModel productos;

  @override
  _AgregarProductTabletState createState() => _AgregarProductTabletState();
}

class _AgregarProductTabletState extends State<AgregarProductTablet> {
  int _counter = 1;

  void _increase() {
    setState(() {
      _counter++;
    });
  }

  void _decrease() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
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
            margin: EdgeInsets.symmetric(
              vertical: responsive.hp(15),
              horizontal: responsive.wp(10),
            ),
            height: responsive.hp(50),
            width: responsive.wp(50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(10),
                      topStart: Radius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: responsive.hp(2),
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Producto',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: ScreenUtil().setWidth(80),
                        height: ScreenUtil().setWidth(80),
                        color: Color(0xffe5e5e5),
                        child: SvgPicture.asset(
                          'assets/platos.svg',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.productos.nombreProducto}',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'S/.${dosDecimales(
                            double.parse(widget.productos.precioVenta),
                          )}',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w600,
                            color: Color(0xff808080),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(40),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(133),
                      height: ScreenUtil().setHeight(40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                if (_counter != 1) {
                                  _decrease();
                                }
                              },
                              child: CircleContainer(
                                radius: ScreenUtil().setHeight(20),
                                widget: CircleContainer(
                                  color: Colors.white,
                                  radius: ScreenUtil().setHeight(17),
                                  widget: Text(
                                    '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(22),
                                    ),
                                  ),
                                ),
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(20),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              transform: Matrix4.translationValues(0, 0, 0),
                              height: ScreenUtil().setHeight(40),
                              child: Text(
                                _counter.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(22),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(20),
                          ),
                          Flexible(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {_increase();
                                
                              },
                              child: CircleContainer(
                                radius: ScreenUtil().setHeight(20),
                                color: Colors.blue,
                                widget: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
