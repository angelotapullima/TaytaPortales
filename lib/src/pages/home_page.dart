import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tayta_restaurant/src/bloc/index_bloc.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/database/carrito_database.dart';
import 'package:tayta_restaurant/src/database/familias_database.dart';
import 'package:tayta_restaurant/src/database/locacion_database.dart';
import 'package:tayta_restaurant/src/database/mesas_database.dart';
import 'package:tayta_restaurant/src/database/pedido_user_database.dart';
import 'package:tayta_restaurant/src/database/productos_database.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/pages/pedidos_usuario.dart';
import 'package:tayta_restaurant/src/pages/tablet/carrito_por_mesa.dart';
import 'package:tayta_restaurant/src/pages/tablet/config.dart';
import 'package:tayta_restaurant/src/pages/tablet/familiasItem.dart';
import 'package:tayta_restaurant/src/pages/tablet/header_locacion.dart';
import 'package:tayta_restaurant/src/pages/tablet/mesas.dart';
import 'package:tayta_restaurant/src/pages/tablet/pedidos_item.dart';
import 'package:tayta_restaurant/src/pages/tablet/productosItem.dart';
import 'package:tayta_restaurant/src/pages/tablet/side_menu.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';
import 'package:tayta_restaurant/src/utils/responsive_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    final locacionBloc = ProviderBloc.locacion(context);
    locacionBloc.obtenerLocacionesPorIdTienda(prefs.tiendaId, context);

    final mesasBloc = ProviderBloc.mesas(context);

    final preferences = Preferences();

    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      body: Stack(
        children: [
          ResponsiveBuilder(
            mobile: VistaTablet(),
            tablet: VistaTablet(),
            desktop: VistaTablet(),
          ),
          StreamBuilder(
            stream: mesasBloc.error401Stream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Su sesión expiro, por favor vuelva a iniciar sesión'),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          preferences.apellidoMaterno = '';
                          preferences.apellidoPaterno = '';
                          preferences.codigoUsuario = '';
                          preferences.idUsuario = '';
                          preferences.locacionId = '';
                          preferences.nombres = '';
                          preferences.nombresCompletos = '';
                          preferences.tiendaId = '';
                          preferences.llamadaLocacion = '';
                          preferences.token = '';

                          final carritoDatabase = CarritoDatabase();
                          final familiasDatabase = FamiliasDatabase();
                          final locacionDatabase = LocacionDatabase();
                          final mesasDatabase = MesasDatabase();
                          final pedidosUserDatabase = PedidosUserDatabase();
                          final productosDatabase = ProductosDatabase();

                          await carritoDatabase.eliminarTablaCarritoMesa();
                          await familiasDatabase.eliminarTablaFamilias();
                          await locacionDatabase.eliminarTablaLocacion();
                          await mesasDatabase.eliminarTablaMesas();
                          await pedidosUserDatabase.eliminarTablaPedidoUser();
                          await productosDatabase.eliminarTablaProductos();

                          Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => true);
                        },
                        child: Text('Iniciar Sesión'),
                        color: Colors.blue,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          StreamBuilder(
            stream: locacionBloc.errorStream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Su sesión expiro, por favor vuelva a iniciar sesión'),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          preferences.apellidoMaterno = '';
                          preferences.apellidoPaterno = '';
                          preferences.codigoUsuario = '';
                          preferences.idUsuario = '';
                          preferences.locacionId = '';
                          preferences.nombres = '';
                          preferences.llamadaLocacion = '';
                          preferences.nombresCompletos = '';
                          preferences.tiendaId = '';
                          preferences.token = '';

                          final carritoDatabase = CarritoDatabase();
                          final familiasDatabase = FamiliasDatabase();
                          final locacionDatabase = LocacionDatabase();
                          final mesasDatabase = MesasDatabase();
                          final pedidosUserDatabase = PedidosUserDatabase();
                          final productosDatabase = ProductosDatabase();

                          await carritoDatabase.eliminarTablaCarritoMesa();
                          await familiasDatabase.eliminarTablaFamilias();
                          await locacionDatabase.eliminarTablaLocacion();
                          await mesasDatabase.eliminarTablaMesas();
                          await pedidosUserDatabase.eliminarTablaPedidoUser();
                          await productosDatabase.eliminarTablaProductos();

                          Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => true);
                        },
                        child: Text('Iniciar Sesión'),
                        color: Colors.blue,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

class VistaTablet extends StatelessWidget {
  const VistaTablet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final provider = Provider.of<IndexBlocListener>(context, listen: false);

    final mesasBloc = ProviderBloc.mesas(context);

    //final errroApiBloc = ProviderBloc.erApi(context);
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: provider.page,
        builder: (BuildContext context, EnumIndex data, Widget child) {
          MesasModel mesas2 = MesasModel();
          return Row(
            children: [
              Container(
                width: ScreenUtil().setWidth(83),
                child: Container(
                  color: Color(0xfff7f7f7),
                  child: SideMenu(),
                ),
              ),
              (data == EnumIndex.mesas)
                  ? Expanded(
                      flex: 15,
                      child: Container(
                        color: Color(0xfff7f7f7),
                        margin: EdgeInsets.only(
                          bottom: responsive.hp(2),
                        ),
                        child: Column(
                          children: [
                            Container(
                              color: Color(0xfff7f7f7),
                              child: HeaderLocacionMesas(),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: ScreenUtil().setWidth(580),
                                        child: Container(),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(340),
                                        decoration: BoxDecoration(
                                          color: Color(0xffCFD7E8),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: ScreenUtil().setWidth(600),
                                        child: Stack(
                                          children: [
                                            MesasWidget(),
                                            /* StreamBuilder(
                                              stream: mesasBloc.errorMesaStream,
                                              builder: (BuildContext context, AsyncSnapshot<ApiModel> errorMesas) {
                                                if (errorMesas.hasData) {
                                                  return (errorMesas.data.resultadoPeticion == false)
                                                      ? Container(
                                                          color: Colors.white,
                                                          child: Center(
                                                            child: Text(errorMesas.data.mensaje),
                                                          ),
                                                        )
                                                      : Container();
                                                } else {
                                                  return Container(
                                                    child: Text(''),
                                                  );
                                                }
                                              },
                                            ),
                                           */],
                                        ),
                                      ),
                                      Container(
                                        //transform: Matrix4.translationValues(-ScreenUtil().setWidth(20), 0, 0),
                                        width: ScreenUtil().setWidth(325),
                                        child: Container(
                                          child: CarritoTabletDisgregar(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : (data == EnumIndex.productos)
                      ? Expanded(
                          flex: 15,
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: responsive.hp(2),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  color: Color(0xfff7f7f7),
                                  child: HeaderLocacionProductos(),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: ScreenUtil().setWidth(280),
                                        color: Color(0xffff7f7f7),
                                        child: Familiasitem(),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(10),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(640),
                                        color: Colors.white,
                                        child: ProductosItem(tipo: '2', mesas: mesas2),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(10),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : (data == EnumIndex.familiaMesa)
                          ? Expanded(
                              flex: 15,
                              child: Stack(
                                children: [
                                  StreamBuilder(
                                      stream: mesasBloc.mesaIdAgregarStream,
                                      builder: (context, AsyncSnapshot<List<MesasModel>> snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.length > 0) {
                                            return SafeArea(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  bottom: responsive.hp(2),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: ScreenUtil().setHeight(10),
                                                      ),
                                                      child: Text(
                                                        'Mesa ${snapshot.data[0].mesa}',
                                                        style: TextStyle(
                                                          fontSize: responsive.ip(1.5),
                                                          color: Color(0xff3783f5),
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Stack(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: ScreenUtil().setWidth(500),
                                                                child: Container(),
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  color: Color(0xffCFD7E8),
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(20),
                                                                    bottomRight: Radius.circular(20),
                                                                  ),
                                                                ),
                                                                width: ScreenUtil().setWidth(420),
                                                                child: Container(),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: ScreenUtil().setWidth(280),
                                                                child: Familiasitem(),
                                                              ),
                                                              SizedBox(
                                                                width: ScreenUtil().setWidth(15),
                                                              ),
                                                              Container(
                                                                width: ScreenUtil().setWidth(320),
                                                                child: ProductosItem(tipo: '1', mesas: snapshot.data[0]),
                                                              ),
                                                              Container(
                                                                width: ScreenUtil().setWidth(300),
                                                                child: CarritoTabletAgregar(),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        } else {
                                          return Container();
                                        }
                                      }),
                                  ValueListenableBuilder(
                                      valueListenable: provider.cargandoEnvio,
                                      builder: (context, data, widget) {
                                        return (data)
                                            ? Center(
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(horizontal: responsive.wp(10)),
                                                  padding: EdgeInsets.symmetric(horizontal: responsive.wp(15)),
                                                  width: double.infinity,
                                                  height: responsive.hp(50),
                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.symmetric(
                                                          horizontal: responsive.wp(10),
                                                        ),
                                                        height: responsive.ip(4),
                                                        width: responsive.ip(4),
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                      SizedBox(
                                                        height: responsive.hp(4),
                                                      ),
                                                      Text(
                                                        'Cargando',
                                                        style: TextStyle(
                                                          fontSize: responsive.ip(2),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container();
                                      })
                                ],
                              ),
                            )
                          : (data == EnumIndex.pedidos)
                              ? Expanded(
                                  flex: 15,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      bottom: responsive.hp(2),
                                      right: ScreenUtil().setWidth(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          color: Color(0xfff7f7f7),
                                          child: HeaderLocacionPedidos(),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Container(
                                                width: ScreenUtil().setWidth(655),
                                                child: PedidosItem(),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: ScreenUtil().setWidth(265),
                                                color: Color(0xffcfd7e8),
                                                child: PedidosUsuario(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : (data == EnumIndex.config)
                                  ? Expanded(
                                      flex: 15,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          bottom: responsive.hp(2),
                                          right: ScreenUtil().setWidth(10),
                                        ),
                                        child: Container(
                                          width: ScreenUtil().setWidth(655),
                                          child: ConfigPage(),
                                        ),
                                      ),
                                    )
                                  : Container()
            ],
          );
        },
      ),
    );
  }
}
/* 
class VistaMovil extends StatelessWidget {
  const VistaMovil({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _catController = CategoryController();
    final prefs = Preferences();
    final locacionBloc = ProviderBloc.locacion(context);
    locacionBloc.obtenerLocacionesPorIdTienda(prefs.tiendaId);
    final mesabloc = ProviderBloc.mesas(context);

    final responsive = Responsive.of(context);
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Container(
            height: responsive.hp(5),
            child: StreamBuilder(
                stream: locacionBloc.locacionStream,
                builder: (context, AsyncSnapshot<List<LocacionModel>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      mesabloc.obtenerMesasPorLocacion(snapshot.data[0].idLocacion);
                      return Container(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                _catController.changeIndex(i, snapshot.data[i].idLocacion);

                                mesabloc.obtenerMesasPorLocacion(snapshot.data[i].idLocacion);
                                //equiposTorneoBloc.obtenerEquiposPorCategoria(snapshot.data[index].idTorneoCategoria);
                                // torneosBloc.obtenerCategoriaXIDCategoria(snapshot.data[0].categoriaTorneo[index].idTorneoCategoria);
                              },
                              child: Container(
                                width: (snapshot.data.length == 1) ? responsive.wp(100) : responsive.wp(40),
                                height: responsive.hp(10),
                                margin: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
                                child: AnimatedBuilder(
                                  animation: _catController,
                                  builder: (_, s) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                                      child: AnimatedBuilder(
                                        animation: _catController,
                                        builder: (_, s) {
                                          return Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  snapshot.data[i].nombre,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: responsive.ip(2.5),
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: responsive.ip(.2),
                                                  ),
                                                ),
                                                (_catController.index == i)
                                                    ? Text(
                                                        snapshot.data[i].nombre,
                                                        style: GoogleFonts.poppins(
                                                            height: responsive.hp(0),
                                                            fontSize: responsive.ip(2.5),
                                                            color: Colors.transparent,
                                                            fontWeight: FontWeight.w500,
                                                            letterSpacing: responsive.ip(.5),
                                                            decoration: TextDecoration.underline,
                                                            decorationColor: Colors.blue,
                                                            decorationThickness: responsive.hp(.5)),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
          StreamBuilder(
            stream: mesabloc.mesasStream,
            builder: (BuildContext context, AsyncSnapshot<List<MesasModel>> mesas) {
              if (mesas.hasData) {
                if (mesas.data.length > 0) {
                  return Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(2),
                      ),
                      itemCount: mesas.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: responsive.hp(0),
                        crossAxisSpacing: responsive.wp(7),
                      ),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return LayoutBuilder(builder: (context, constraints) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return CarritoPage(mesa: mesas.data[index]);
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
                            child: Container(
                              width: constraints.maxWidth,
                              child: Row(
                                children: [
                                  Container(
                                    width: constraints.maxWidth * 0.15,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: (index % 2 == 0) ? Colors.blue : Colors.yellow[800],
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            height: constraints.maxHeight * 0.15,
                                            width: constraints.maxWidth * 0.2,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            height: constraints.maxHeight * 0.15,
                                            width: constraints.maxWidth * 0.2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsive.wp(1),
                                  ),
                                  Container(
                                    height: constraints.maxHeight * 0.6,
                                    width: constraints.maxWidth * 0.6 - responsive.wp(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: (mesas.data[index].idComanda == '0')
                                          ? (index % 2 == 0)
                                              ? Colors.blue
                                              : Colors.yellow[800]
                                          : Colors.green,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: responsive.wp(1),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                '${mesas.data[index].mesa}',
                                                style: TextStyle(
                                                  fontSize: responsive.ip(2),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Icon(Icons.personal_video_outlined),
                                              Expanded(
                                                child: Text(
                                                  '${mesas.data[index].cantidadPersonas}',
                                                  style: TextStyle(
                                                    fontSize: responsive.ip(2),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsive.wp(1),
                                  ),
                                  Container(
                                    width: constraints.maxWidth * 0.15,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: (index % 2 == 0) ? Colors.blue : Colors.yellow[800],
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          height: constraints.maxHeight * 0.15,
                                          width: constraints.maxWidth * 0.2,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          height: constraints.maxHeight * 0.15,
                                          width: constraints.maxWidth * 0.2,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
 */