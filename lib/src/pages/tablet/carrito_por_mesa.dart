import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tayta_restaurant/src/api/comanda_api.dart';
import 'package:tayta_restaurant/src/api/mesas_api.dart';
import 'package:tayta_restaurant/src/bloc/index_bloc.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/database/carrito_database.dart';
import 'package:tayta_restaurant/src/models/carrtito_model.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/pages/tablet/agregar_personas.dart';
import 'package:tayta_restaurant/src/pages/tablet/disgregar_producto.dart';
import 'package:tayta_restaurant/src/pages/tablet/editar_pedido.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class CarritoTabletDisgregar extends StatelessWidget {
  const CarritoTabletDisgregar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final mesasBloc = ProviderBloc.mesas(context);

    final provider = Provider.of<IndexBlocListener>(context, listen: false);

    //carritoBloc.obtenercarrito(widget.mesa.idMesa, widget.mesa.locacionId);
    return Container(
      child: StreamBuilder(
        stream: mesasBloc.mesaIdDisgregarStream,
        builder: (context, AsyncSnapshot<List<MesasModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              double total = 0;
              double precio = 0;

              for (var i = 0; i < snapshot.data[0].carrito.length; i++) {
                int cantidad = double.parse(snapshot.data[0].carrito[i].cantidad).toInt();
                precio = double.parse(snapshot.data[0].carrito[i].precioVenta);
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
                                  int cantidad = double.parse(snapshot.data[0].carrito[i].cantidad).toInt();
                                  precio = double.parse(snapshot.data[0].carrito[i].precioVenta);

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
                                                        fontSize: ScreenUtil().setSp(22),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: ScreenUtil().setHeight(20)),
                                                SizedBox(
                                                  height: ScreenUtil().setHeight(40),
                                                  width: ScreenUtil().setWidth(250),
                                                  child: MaterialButton(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    color: Colors.blue,
                                                    textColor: Colors.white,
                                                    child: Text(
                                                      'Agregar más productos',
                                                      style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                    ),
                                                    onPressed: () {
                                                      provider.changeToFamiliaMesa();
                                                    },
                                                  ),
                                                ),
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
                                                  fontSize: ScreenUtil().setSp(22),
                                                ),
                                              ),
                                              SizedBox(
                                                height: ScreenUtil().setHeight(50),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(10),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(40),
                                            width: ScreenUtil().setWidth(250),
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              color: Colors.blue,
                                              textColor: Colors.white,
                                              child: Text(
                                                'Agregar más productos',
                                                style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                              ),
                                              onPressed: () {
                                                provider.changeToFamiliaMesa();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }

                                return LayoutBuilder(builder: (context, constraints) {
                                  print(constraints.maxWidth);
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          opaque: false,
                                          pageBuilder: (context, animation, secondaryAnimation) {
                                            return DisgregarProductoTablet(
                                              mesas: snapshot.data[0],
                                              carrito: snapshot.data[0].carrito[i],
                                            );
                                          },
                                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                            var begin = Offset(0.0, 1.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;

                                            var tween = Tween(begin: begin, end: end).chain(
                                              CurveTween(curve: curve),
                                            );

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.25,
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Container(
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
                                                        (snapshot.data[0].carrito[i].paraLLevar == '1')
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
                                        ),
                                      ),
                                      actions: <Widget>[
                                        IconSlideAction(
                                          caption: 'Editar',
                                          color: Colors.blue,
                                          icon: Icons.edit,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                opaque: false,
                                                pageBuilder: (context, animation, secondaryAnimation) {
                                                  return EditarProductoTablet(
                                                    carrito: snapshot.data[0].carrito[i],
                                                    mesas: snapshot.data[0],
                                                  );
                                                },
                                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                  var begin = Offset(0.0, 1.0);
                                                  var end = Offset.zero;
                                                  var curve = Curves.ease;

                                                  var tween = Tween(begin: begin, end: end).chain(
                                                    CurveTween(curve: curve),
                                                  );

                                                  return SlideTransition(
                                                    position: animation.drive(tween),
                                                    child: child,
                                                  );
                                                },
                                              ),
                                            );
                                            //EditarProductoTablet
                                          },
                                        ),
                                      ],
                                      /* secondaryActions: <Widget>[
                                        IconSlideAction(
                                          caption: 'More',
                                          color: Colors.black45,
                                          icon: Icons.more_horiz,
                                          onTap: () {
                                            print('IconSlideAction archive');
                                          },
                                        ),
                                        IconSlideAction(
                                          caption: 'Delete',
                                          color: Colors.red,
                                          icon: Icons.delete,
                                          onTap: () {
                                            print('IconSlideAction archive');
                                          },
                                        ),
                                      ], */
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
                                InkWell(
                                  onTap: () {
                                    provider.changeToFamiliaMesa();
                                  },
                                  child: Container(
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
                  'Presionar una mesa para obtener sus detalles',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.ip(2),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

class CarritoTabletAgregar extends StatelessWidget {
  const CarritoTabletAgregar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final mesasBloc = ProviderBloc.mesas(context);

    final provider = Provider.of<IndexBlocListener>(context, listen: false);

    //carritoBloc.obtenercarrito(widget.mesa.idMesa, widget.mesa.locacionId);
    return Container(
      child: StreamBuilder(
          stream: mesasBloc.mesaIdAgregarStream,
          builder: (context, AsyncSnapshot<List<MesasModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                double total = 0;
                double precio = 0;

                for (var i = 0; i < snapshot.data[0].carrito.length; i++) {
                  int cantidad = double.parse(snapshot.data[0].carrito[i].cantidad).toInt();
                  precio = double.parse(snapshot.data[0].carrito[i].precioVenta);
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
                          Spacer(), Text(
                            'S/. ${snapshot.data[0].total}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: responsive.hp(4),
                      ),
                      (snapshot.data[0].carrito.length > 0)
                          ? Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: snapshot.data[0].carrito.length + 1,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  double totelx = 0;

                                  if (i != snapshot.data[0].carrito.length) {
                                    int cantidad = double.parse(snapshot.data[0].carrito[i].cantidad).toInt();
                                    precio = double.parse(snapshot.data[0].carrito[i].precioVenta);

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
                                                          fontSize: ScreenUtil().setSp(22),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: ScreenUtil().setHeight(20)),
                                                  SizedBox(
                                                    height: ScreenUtil().setHeight(40),
                                                    width: ScreenUtil().setWidth(200),
                                                    child: MaterialButton(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      color: Colors.blue,
                                                      textColor: Colors.white,
                                                      child: Text('enviar pedido'),
                                                      onPressed: () async {
                                                        Navigator.push(
                                                          context,
                                                          PageRouteBuilder(
                                                            opaque: false,
                                                            pageBuilder: (context, animation, secondaryAnimation) {
                                                              return AgregarPersonasTablet(mesa: snapshot.data[0]);
                                                            },
                                                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                              var begin = Offset(0.0, 1.0);
                                                              var end = Offset.zero;
                                                              var curve = Curves.ease;

                                                              var tween = Tween(begin: begin, end: end).chain(
                                                                CurveTween(curve: curve),
                                                              );

                                                              return SlideTransition(
                                                                position: animation.drive(tween),
                                                                child: child,
                                                              );
                                                            },
                                                          ),
                                                        );

                                                        /*  final comandaApi = ComandaApi();
                                                        provider.changeCargandoTrue();
                                                        final res = await comandaApi.enviarComanda(snapshot.data[0].idMesa);
                                                        if (res.resultadoPeticion) {
                                                          showToast2('Pedido enviado correctamente', Colors.green);
                                                          provider.changeCargandoFalse();
                                                          provider.changeToMesa();
                                                        } else {
                                                          showToast2('Ocurrio un error, intentelo nuevamente', Colors.red);
                                                          provider.changeCargandoFalse();
                                                        } */
                                                      },
                                                    ),
                                                  ),
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
                                                    fontSize: ScreenUtil().setSp(22),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: ScreenUtil().setHeight(50),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: ScreenUtil().setHeight(40),
                                              width: ScreenUtil().setWidth(200),
                                              child: MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                color: Colors.blue,
                                                textColor: Colors.white,
                                                child: Text('Enviar pedidos'),
                                                onPressed: () async {
                                                  Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      opaque: false,
                                                      pageBuilder: (context, animation, secondaryAnimation) {
                                                        return AgregarPersonasTablet(mesa: snapshot.data[0]);
                                                      },
                                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                        var begin = Offset(0.0, 1.0);
                                                        var end = Offset.zero;
                                                        var curve = Curves.ease;

                                                        var tween = Tween(begin: begin, end: end).chain(
                                                          CurveTween(curve: curve),
                                                        );

                                                        return SlideTransition(
                                                          position: animation.drive(tween),
                                                          child: child,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                  /*  final comandaApi = ComandaApi();
                                                  provider.changeCargandoTrue();
                                                  final res = await comandaApi.enviarComanda(snapshot.data[0].idMesa);
                                                  if (res.resultadoPeticion) {
                                                    showToast2('Pedido enviado correctamente', Colors.green);
                                                    provider.changeCargandoFalse();
                                                    provider.changeToMesa();
                                                  } else {
                                                    showToast2('Ocurrio un error, intentelo nuevamente', Colors.red);
                                                    provider.changeCargandoFalse();
                                                  } */
                                                },
                                              ),
                                            ),
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
                                    return Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.25,
                                      actions: <Widget>[
                                        IconSlideAction(
                                          caption: 'Eliminar',
                                          color: Colors.red,
                                          icon: Icons.archive,
                                          onTap: () async {
                                            if ('${snapshot.data[0].carrito[i].idComandaDetalle}' == '0') {
                                              final mesasApi = MesasApi();
                                              final carritoDatabase = CarritoDatabase();
                                              await carritoDatabase.eliminarProductoPorIdCarrito('${snapshot.data[0].carrito[i].idCarrito}');

                                              await mesasApi.obtenerMesasPorLocacion('${snapshot.data[0].carrito[i].idLocacion}');
                                              mesasBloc.obtenerMesasPorIdAgregar('${snapshot.data[0].carrito[i].idMesa}');
                                              mesasBloc.obtenerMesasPorIdDisgregar('${snapshot.data[0].carrito[i].idMesa}');
                                              print('IconSlideAction archive');
                                            } else {
                                              showToast2('El producto no se puede eliminar ', Colors.red);
                                            }
                                          },
                                        ),
                                      ],
                                      child: Container(
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
                                                      (snapshot.data[0].carrito[i].paraLLevar == '1')
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
                                    padding: EdgeInsets.all(
                                      ScreenUtil().setWidth(8),
                                    ),
                                    height: ScreenUtil().setWidth(100),
                                    width: ScreenUtil().setWidth(100),
                                    child: SvgPicture.asset(
                                      'assets/noProduct.svg',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      provider.changeToFamiliaMesa();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: responsive.wp(1),
                                        vertical: responsive.hp(1),
                                      ),
                                      child: Text(
                                        'No tiene pedidos',
                                        style: TextStyle(color: Colors.white),
                                      ),
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
