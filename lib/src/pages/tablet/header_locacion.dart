import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/locacion_model.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';

class HeaderLocacion extends StatefulWidget {
  const HeaderLocacion({Key key}) : super(key: key);

  @override
  _WidgetLocacionState createState() => _WidgetLocacionState();
}

class _WidgetLocacionState extends State<HeaderLocacion> {
  final _catController = CategoryController();
  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();

    final locacionBloc = ProviderBloc.locacion(context);
    locacionBloc.obtenerLocacionesPorIdTienda(prefs.tiendaId);

    final mesabloc = ProviderBloc.mesas(context);
    final familiasBloc = ProviderBloc.familias(context);
    final responsive = Responsive.of(context);
    return Container(
      height: ScreenUtil().setHeight(80),
      child: StreamBuilder(
          stream: locacionBloc.locacionStream,
          builder: (context, AsyncSnapshot<List<LocacionModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                mesabloc.obtenerMesasPorLocacion(snapshot.data[0].idLocacion);
                mesabloc.obtenerMesasConPedido(snapshot.data[0].idLocacion);
                print('header aye');
                familiasBloc.obtenerFamilias(snapshot.data[0].idLocacion);
                return Container(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          _catController.changeIndex(i, snapshot.data[i].idLocacion);

                          mesabloc.obtenerMesasPorLocacion(snapshot.data[i].idLocacion);
                          mesabloc.obtenerMesasConPedido(snapshot.data[i].idLocacion);
                          print('header click');
                          familiasBloc.obtenerFamilias(snapshot.data[i].idLocacion);
                        },
                        child: Container(
                          // responsive.wp(100) : responsive.wp(40),

                          margin: EdgeInsets.symmetric(horizontal: responsive.wp(1)),
                          child: AnimatedBuilder(
                            animation: _catController,
                            builder: (_, s) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: responsive.wp(1)),
                                child: AnimatedBuilder(
                                  animation: _catController,
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
                                              color: (_catController.index == i) ? Colors.blue[700] : Colors.grey,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: responsive.ip(.2),
                                            ),
                                          ),
                                          (_catController.index == i)
                                              ? Text(
                                                  snapshot.data[i].nombre,
                                                  style: GoogleFonts.poppins(
                                                      height: responsive.hp(0),
                                                      fontSize: responsive.ip(1.5),
                                                      color: Colors.transparent,
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: responsive.ip(.5),
                                                      decoration: TextDecoration.underline,
                                                      decorationColor: (_catController.index == i) ? Colors.blue[700] : Colors.grey,
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
                return Center(child: CupertinoActivityIndicator());
              }
            } else {
              return Center(child: CupertinoActivityIndicator());
            }
          }),
    );
  }
}

class CategoryController extends ChangeNotifier {
  int index = 0;
  String idCategoria = '0';

  void changeIndex(int i, String idCat) {
    index = i;
    idCategoria = idCat;
    notifyListeners();
  }
}
