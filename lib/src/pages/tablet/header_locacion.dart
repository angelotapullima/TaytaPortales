import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tayta_restaurant/src/bloc/index_bloc.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/locacion_model.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';

class HeaderLocacionMesas extends StatefulWidget {
  const HeaderLocacionMesas({Key key}) : super(key: key);

  @override
  _WidgetLocacionState createState() => _WidgetLocacionState();
}

class _WidgetLocacionState extends State<HeaderLocacionMesas> {
  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();

    final locacionBloc = ProviderBloc.locacion(context);

    final mesabloc = ProviderBloc.mesas(context);
    final responsive = Responsive.of(context);

    final provider = Provider.of<IndexBlocListener>(context, listen: false);

    return Container(
      height: ScreenUtil().setHeight(80),
      child: StreamBuilder(
          stream: locacionBloc.locacionStream,
          builder: (context, AsyncSnapshot<List<LocacionModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                //provider
                                provider.changeIndex(i);
                                prefs.locacionId = snapshot.data[i].idLocacion;

                                mesabloc.obtenerMesasPorLocacion(snapshot.data[i].idLocacion, context);
                                print('locacion Mesas click');
                                //familiasBloc.obtenerFamilias(snapshot.data[i].idLocacion);
                              },
                              child: Container(
                                // responsive.wp(100) : responsive.wp(40),

                                margin: EdgeInsets.symmetric(horizontal: responsive.wp(1)),
                                child: AnimatedBuilder(
                                  animation: provider,
                                  builder: (_, s) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(horizontal: responsive.wp(1)),
                                      child: AnimatedBuilder(
                                        animation: provider,
                                        builder: (_, s) {
                                          return Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot.data[i].nombre,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: responsive.ip(1.5),
                                                    color: (provider.index == i) ? Colors.blue[700] : Colors.grey,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: responsive.ip(.2),
                                                  ),
                                                ),
                                                (provider.index == i)
                                                    ? Text(
                                                        snapshot.data[i].nombre,
                                                        style: GoogleFonts.poppins(
                                                            height: responsive.hp(0),
                                                            fontSize: responsive.ip(1.5),
                                                            color: Colors.transparent,
                                                            fontWeight: FontWeight.w600,
                                                            letterSpacing: responsive.ip(.5),
                                                            decoration: TextDecoration.underline,
                                                            decorationColor: (provider.index == i) ? Colors.blue[700] : Colors.grey,
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
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          ScreenUtil().setWidth(8),
                        ),
                        height: ScreenUtil().setWidth(50),
                        width: ScreenUtil().setWidth(50),
                        child: SvgPicture.asset(
                          'assets/userPicture.svg',
                        ),
                      ),
                      Text('${prefs.nombresCompletos}'),
                      SizedBox(
                        width: ScreenUtil().setWidth(20),
                      )
                    ],
                  ),
                );
              } else {
                return Center(child: CupertinoActivityIndicator());
              }
            } else {
              return Center(child: CupertinoActivityIndicator());
            }
          }),
    );
  }
}

class HeaderLocacionProductos extends StatefulWidget {
  const HeaderLocacionProductos({Key key}) : super(key: key);

  @override
  _HeaderLocacionProductosState createState() => _HeaderLocacionProductosState();
}

class _HeaderLocacionProductosState extends State<HeaderLocacionProductos> {
  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();

    final locacionBloc = ProviderBloc.locacion(context);

    final familiasBloc = ProviderBloc.familias(context);
    final responsive = Responsive.of(context);

    final provider = Provider.of<IndexBlocListener>(context, listen: false);

    return Container(
      height: ScreenUtil().setHeight(80),
      child: StreamBuilder(
          stream: locacionBloc.locacionStream,
          builder: (context, AsyncSnapshot<List<LocacionModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                provider.changeIndex(i);

                                prefs.locacionId = snapshot.data[i].idLocacion;
/* 
                                mesabloc.obtenerMesasPorLocacion(snapshot.data[i].idLocacion);
                                mesabloc.obtenerMesasConPedido(snapshot.data[i].idLocacion); */
                                print('locacionProdcutos click');
                                familiasBloc.obtenerFamilias(snapshot.data[i].idLocacion);
                              },
                              child: Container(
                                // responsive.wp(100) : responsive.wp(40),

                                margin: EdgeInsets.symmetric(horizontal: responsive.wp(1)),
                                child: AnimatedBuilder(
                                  animation: provider,
                                  builder: (_, s) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(horizontal: responsive.wp(1)),
                                      child: AnimatedBuilder(
                                        animation: provider,
                                        builder: (_, s) {
                                          return Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot.data[i].nombre,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: responsive.ip(1.5),
                                                    color: (provider.index == i) ? Colors.blue[700] : Colors.grey,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: responsive.ip(.2),
                                                  ),
                                                ),
                                                (provider.index == i)
                                                    ? Text(
                                                        snapshot.data[i].nombre,
                                                        style: GoogleFonts.poppins(
                                                            height: responsive.hp(0),
                                                            fontSize: responsive.ip(1.5),
                                                            color: Colors.transparent,
                                                            fontWeight: FontWeight.w600,
                                                            letterSpacing: responsive.ip(.5),
                                                            decoration: TextDecoration.underline,
                                                            decorationColor: (provider.index == i) ? Colors.blue[700] : Colors.grey,
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
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          ScreenUtil().setWidth(8),
                        ),
                        height: ScreenUtil().setWidth(50),
                        width: ScreenUtil().setWidth(50),
                        child: SvgPicture.asset(
                          'assets/userPicture.svg',
                        ),
                      ),
                      Text('${prefs.nombresCompletos}'),
                      SizedBox(
                        width: ScreenUtil().setWidth(20),
                      )
                    ],
                  ),
                );
              } else {
                return Center(child: CupertinoActivityIndicator());
              }
            } else {
              return Center(child: CupertinoActivityIndicator());
            }
          }),
    );
  }
}





class HeaderLocacionPedidos extends StatefulWidget {
  const HeaderLocacionPedidos({Key key}) : super(key: key);

  @override
  _HeaderLocacionPedidosState createState() => _HeaderLocacionPedidosState();
}

class _HeaderLocacionPedidosState extends State<HeaderLocacionPedidos> {
  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();

    final locacionBloc = ProviderBloc.locacion(context);

    final mesabloc = ProviderBloc.mesas(context);
    final responsive = Responsive.of(context);

    final provider = Provider.of<IndexBlocListener>(context, listen: false);

    return Container(
      height: ScreenUtil().setHeight(80),
      child: StreamBuilder(
          stream: locacionBloc.locacionStream,
          builder: (context, AsyncSnapshot<List<LocacionModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                provider.changeIndex(i);

                                prefs.locacionId = snapshot.data[i].idLocacion;
/* 
                                mesabloc.obtenerMesasPorLocacion(snapshot.data[i].idLocacion);
                                mesabloc.obtenerMesasConPedido(snapshot.data[i].idLocacion); */
                                print('locacionProdcutos click');
                                
                                mesabloc.obtenerMesasConPedido(snapshot.data[i].idLocacion);
                              },
                              child: Container(
                                // responsive.wp(100) : responsive.wp(40),

                                margin: EdgeInsets.symmetric(horizontal: responsive.wp(1)),
                                child: AnimatedBuilder(
                                  animation: provider,
                                  builder: (_, s) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(horizontal: responsive.wp(1)),
                                      child: AnimatedBuilder(
                                        animation: provider,
                                        builder: (_, s) {
                                          return Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot.data[i].nombre,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: responsive.ip(1.5),
                                                    color: (provider.index == i) ? Colors.blue[700] : Colors.grey,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: responsive.ip(.2),
                                                  ),
                                                ),
                                                (provider.index == i)
                                                    ? Text(
                                                        snapshot.data[i].nombre,
                                                        style: GoogleFonts.poppins(
                                                            height: responsive.hp(0),
                                                            fontSize: responsive.ip(1.5),
                                                            color: Colors.transparent,
                                                            fontWeight: FontWeight.w600,
                                                            letterSpacing: responsive.ip(.5),
                                                            decoration: TextDecoration.underline,
                                                            decorationColor: (provider.index == i) ? Colors.blue[700] : Colors.grey,
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
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          ScreenUtil().setWidth(8),
                        ),
                        height: ScreenUtil().setWidth(50),
                        width: ScreenUtil().setWidth(50),
                        child: SvgPicture.asset(
                          'assets/userPicture.svg',
                        ),
                      ),
                      Text('${prefs.nombresCompletos}'),
                      SizedBox(
                        width: ScreenUtil().setWidth(20),
                      )
                    ],
                  ),
                );
              } else {
                return Center(child: CupertinoActivityIndicator());
              }
            } else {
              return Center(child: CupertinoActivityIndicator());
            }
          }),
    );
  }
}
