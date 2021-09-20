import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class PedidosItem extends StatelessWidget {
  const PedidosItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mesasBloc = ProviderBloc.mesas(context);
    Offset offset = const Offset(5, 5);

    final responsive = Responsive.of(context);
    return StreamBuilder(
      stream: mesasBloc.mesasConPedidosStream,
      builder: (BuildContext context, AsyncSnapshot<List<MesasModel>> mesas) {
        if (mesas.hasData) {
          if (mesas.data.length > 0) { 
           
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: offset,
                    blurRadius: 10.0,
                    color: Color(0x26234395),
                  ),
                  BoxShadow(
                    offset: Offset(-offset.dx, -offset.dx),
                    blurRadius: 20.0,
                    color: Colors.grey.withOpacity(.5),
                  ),
                ],
              ),
              child: GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                  vertical: ScreenUtil().setHeight(10),
                ),
                itemCount: mesas.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: .7,
                  mainAxisSpacing: ScreenUtil().setWidth(10),
                  crossAxisSpacing: ScreenUtil().setWidth(10),
                ),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {

                   double precio = 0;

            for (var i = 0; i < mesas.data[index].carrito.length; i++) {
            
              precio = (mesas.data[index].carrito[i].paraLLevar == '0') ? double.parse(mesas.data[index].carrito[i].precioVenta) : double.parse(mesas.data[index].carrito[i].precioLlevar);
              
            }
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        width: constraints.maxWidth,
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: offset,
                              blurRadius: 5.0,
                              color: Color(0x26234395),
                            ),
                            BoxShadow(
                              offset: Offset(-offset.dx, -offset.dx),
                              blurRadius: 1.0,
                              color: Colors.grey.withOpacity(.5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Pedido #${mesas.data[index].idComanda}',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(18),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '${mesas.data[index].mesa}',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(18),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${mesas.data[index].horaIngreso}',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(16),
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffd1d1d1),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: mesas.data[index].carrito.length + 1,
                                    shrinkWrap: true,
                                    itemBuilder: (context, i) {
                                      double totelx = 0;

                                      if (i != mesas.data[index].carrito.length) {
                                        int cantidad = double.parse(mesas.data[index].carrito[i].cantidad).toInt();
                                        precio = (mesas.data[index].carrito[i].paraLLevar == '0')
                                            ? double.parse(mesas.data[index].carrito[i].precioVenta)
                                            : double.parse(mesas.data[index].carrito[i].precioLlevar);

                                        totelx = cantidad * precio;
                                      }

                                      if (i == mesas.data[index].carrito.length) {
                                        if (mesas.data[index].cuentas.length > 1) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            itemCount: mesas.data[index].cuentas.length + 2,
                                            itemBuilder: (_, index2) {
                                              if (index2 == mesas.data[index].cuentas.length + 1) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: responsive.wp(2),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Divider(),
                                                      Container(),
                                                      SizedBox(height: ScreenUtil().setHeight(20)),
                                                      
                                                      SizedBox(
                                                        height: ScreenUtil().setHeight(50),
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
                                                    Text('Cuenta ${mesas.data[index].cuentas[index2].cuenta}'),
                                                    Spacer(),
                                                    Text(
                                                      'S/. ${mesas.data[index].cuentas[index2].monto}',
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
                                                
                                                      Container(),
                                                 
                                                SizedBox(
                                                  height: ScreenUtil().setHeight(100),
                                                )
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
                                                          '${mesas.data[index].carrito[i].nombreProducto} ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: ScreenUtil().setSp(13),
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        (mesas.data[index].carrito[i].observacion.length > 0)
                                                            ? Text(
                                                                '${mesas.data[index].carrito[i].observacion}',
                                                                style: TextStyle(
                                                                  color: Colors.grey[600],
                                                                  fontSize: ScreenUtil().setSp(13),
                                                                ),
                                                              )
                                                            : Container(),
                                                        (mesas.data[index].carrito[i].paraLLevar == '1')
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
                                                        (mesas.data[index].cuentas.length > 1)
                                                            ? Container(
                                                                padding: EdgeInsets.symmetric(horizontal: responsive.wp(.5)),
                                                                decoration: BoxDecoration(
                                                                  color: Colors.blue,
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                child: Text(
                                                                  'Cuenta : ${mesas.data[index].carrito[i].nroCuenta}',
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
                                                        'x ${mesas.data[index].carrito[i].cantidad}',
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
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.white,
                                height: ScreenUtil().setHeight(60),
                                child: Column(
                                  children: [
                                    Divider(),
                                    Row(
                                      children: [
                                        Spacer(),
                                        Text(
                                          'S/.${mesas.data[index].total}',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(18),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        /* SizedBox(
                                          width: constraints.maxWidth / 2,
                                          child: MaterialButton(
                                            onPressed: () {},
                                            color: Colors.green,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            textColor: Colors.white,
                                            child: Text('ver Detalles'),
                                          ),
                                        ) */
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text('No existen pedisos '),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
