import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class CarritoTablet extends StatelessWidget {
  const CarritoTablet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final mesasBloc = ProviderBloc.mesas(context);
    //carritoBloc.obtenercarrito(widget.mesa.idMesa, widget.mesa.locacionId);
    return Container(
      child: StreamBuilder(
          stream: mesasBloc.mesaIdStream,
          builder: (context, AsyncSnapshot<List<MesasModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                double total = 0;
                double precio = 0;

                for (var i = 0; i < snapshot.data[0].carrito.length; i++) {
                  int cantidad = int.parse(snapshot.data[0].carrito[i].cantidad);
                  precio = (snapshot.data[0].carrito[i].paraLLevar == '0')
                      ? double.parse(snapshot.data[0].carrito[i].precioVenta)
                      : double.parse(snapshot.data[0].carrito[i].precioLlevar);
                  total = total + (cantidad * precio);
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.wp(1),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: responsive.hp(2),
                      ),
                      Row(
                        children: [
                          Text(
                            'Mesa ${snapshot.data[0].mesa}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'S/.${dosDecimales(
                              total,
                            )}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: responsive.hp(4)),
                      (snapshot.data[0].carrito.length > 0)
                          ? Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: snapshot.data[0].carrito.length + 1,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  double totelx = 0;

                                  if (i != snapshot.data[0].carrito.length) {
                                    int cantidad = int.parse(snapshot.data[0].carrito[i].cantidad);
                                    precio = (snapshot.data[0].carrito[i].paraLLevar == '0')
                                        ? double.parse(snapshot.data[0].carrito[i].precioVenta)
                                        : double.parse(snapshot.data[0].carrito[i].precioLlevar);

                                    totelx = cantidad * precio;
                                  }

                                  if (i == snapshot.data[0].carrito.length) {
                                    if (snapshot.data[0].cuentas.length > 1) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: snapshot.data[0].cuentas.length + 2,
                                        itemBuilder: (_, index2) {
                                          if (index2 == snapshot.data[0].cuentas.length + 1) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: responsive.wp(2),
                                              ),
                                              child: Column(
                                                children: [
                                                  Divider(),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Total',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: ScreenUtil().setSp(18),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        'S/. ${dosDecimales(total)}',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: ScreenUtil().setSp(18),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          if (index2 == 0) {
                                            return Container(
                                              child: Text(
                                                'Cuentas',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ScreenUtil().setSp(18),
                                                ),
                                              ),
                                            );
                                          }
                                          index2 = index2 - 1;

                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: responsive.wp(2),
                                            ),
                                            child: Row(
                                              children: [
                                                Text('Cuenta ${snapshot.data[0].cuentas[index2].cuenta}'),
                                                Spacer(),
                                                Text(
                                                  'S/. ${snapshot.data[0].cuentas[index2].monto}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: ScreenUtil().setSp(18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: responsive.wp(2),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Total',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: ScreenUtil().setSp(18),
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  'S/. ${dosDecimales(total)}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: ScreenUtil().setSp(18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }

                                  return LayoutBuilder(builder: (context, constraints) {
                                    print(constraints.maxWidth);
                                    return Container(
                                      margin: EdgeInsets.only(
                                        bottom: responsive.hp(1.5),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            //mainAxisAlignment:MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: constraints.maxWidth * .15,
                                                width: constraints.maxWidth * .15,
                                                child: SvgPicture.asset(
                                                  'assets/platos.svg',
                                                ),
                                              ),
                                              Container(
                                                width: constraints.maxWidth * .52,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${snapshot.data[0].carrito[i].nombreProducto} ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: ScreenUtil().setSp(13),
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    (snapshot.data[0].carrito[i].observacion.length > 0)
                                                        ? Text(
                                                            '${snapshot.data[0].carrito[i].observacion}',
                                                            style: TextStyle(
                                                              color: Colors.grey[600],
                                                              fontSize: ScreenUtil().setSp(13),
                                                            ),
                                                          )
                                                        : Container(),
                                                    (snapshot.data[0].carrito[i].paraLLevar == '0')
                                                        ? Container(
                                                            padding: EdgeInsets.symmetric(horizontal: responsive.wp(.5)),
                                                            decoration: BoxDecoration(
                                                              color: Colors.green,
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Text(
                                                              'Para llevar',
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: ScreenUtil().setSp(12),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                    SizedBox(
                                                      height: ScreenUtil().setHeight(5),
                                                    ),
                                                    (snapshot.data[0].cuentas.length > 1)
                                                        ? Container(
                                                            padding: EdgeInsets.symmetric(horizontal: responsive.wp(.5)),
                                                            decoration: BoxDecoration(
                                                              color: Colors.blue,
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Text(
                                                              'Cuenta : ${snapshot.data[0].carrito[i].nroCuenta}',
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: ScreenUtil().setSp(12),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: constraints.maxWidth * .1,
                                                child: Center(
                                                  child: Text(
                                                    'x ${snapshot.data[0].carrito[i].cantidad}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: ScreenUtil().setSp(13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: constraints.maxWidth * .22,
                                                child: Center(
                                                  child: Text(
                                                    'S/. ${dosDecimales(totelx)}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: ScreenUtil().setSp(13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    );
                                  });
                                },
                              ),
                            )
                          : Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: responsive.wp(1),
                                      vertical: responsive.hp(1),
                                    ),
                                    color: Colors.red,
                                    child: Text(
                                      'Agregar productos a la mesa',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container()
                                ],
                              ),
                            )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            } else {
              return Column(
                children: [
                  Icon(
                    Icons.people_alt_sharp,
                    size: responsive.ip(20),
                  ),
                  Text(
                    'Presionar una mesa para ontener sus detalles',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: responsive.ip(2),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}