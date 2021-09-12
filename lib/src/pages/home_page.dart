import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tayta_restaurant/src/bloc/index_bloc.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/locacion_model.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/pages/carrito_page.dart';
import 'package:tayta_restaurant/src/pages/tablet/carrito_por_mesa.dart';
import 'package:tayta_restaurant/src/pages/tablet/familiasItem.dart';
import 'package:tayta_restaurant/src/pages/tablet/header_locacion.dart';
import 'package:tayta_restaurant/src/pages/tablet/mesas.dart';
import 'package:tayta_restaurant/src/pages/tablet/productosItem.dart';
import 'package:tayta_restaurant/src/pages/tablet/side_menu.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';
import 'package:tayta_restaurant/src/utils/responsive_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _catController = CategoryController();
    final prefs = Preferences();
    final locacionBloc = ProviderBloc.locacion(context);
    locacionBloc.obtenerLocacionesPorIdTienda(prefs.tiendaId);

    final mesabloc = ProviderBloc.mesas(context);

    final responsive = Responsive.of(context);

    final provider = Provider.of<IndexBlocListener>(context, listen: false);

    return Scaffold(
      body: ResponsiveBuilder(
        mobile: SafeArea(
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
        ),
        tablet: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(color: Colors.blue, child: SideMenu()),
            ),
            Expanded(
              flex: 10,
              child: Container(color: Colors.red, child: MesasWidget()),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.red,
                child: CarritoTablet(),
              ),
            ),
          ],
        ),
        desktop: SafeArea(
          bottom: false,
          child: ValueListenableBuilder(
            valueListenable: provider.page,
            builder: (BuildContext context, EnumIndex data, Widget child) {
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(color: Color(0xfff3f2f2), child: SideMenu()),
                  ),
                  (data == EnumIndex.mesas)
                      ? Expanded(
                          flex: 15,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 10,
                                child: Container(color: Colors.white, child: MesasWidget()),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  color: Color(0xFFF9F9FA),
                                  child: CarritoTablet(),
                                ),
                              ),
                            ],
                          ),
                        )
                      : (data == EnumIndex.productos)
                          ? Expanded(
                              flex: 15,
                              child: Column(
                                children: [
                                  Container(color: Colors.white, child: HeaderLocacion()),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                            color: Color(0xFFF9F9FA),
                                            child: Familiasitem(),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: Container(
                                            color: Colors.white,
                                            child: ProductosItem(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container()
                ],
              );
            },
          ),
        ),
      ),
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
