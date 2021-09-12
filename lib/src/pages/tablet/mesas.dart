
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/locacion_model.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/pages/categoriasProducto/categorias_productos_page.dart';
import 'package:tayta_restaurant/src/pages/home_page.dart';
import 'package:tayta_restaurant/src/pages/tablet/header_locacion.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';


class MesasWidget extends StatelessWidget {
  const MesasWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();

    final locacionBloc = ProviderBloc.locacion(context);
    locacionBloc.obtenerLocacionesPorIdTienda(prefs.tiendaId);

    final mesabloc = ProviderBloc.mesas(context);

    final responsive = Responsive.of(context);
    return SafeArea(
      child: Column(
        children: [

          HeaderLocacion(),
         /*  Container(
            height: responsive.hp(8),
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
                                                            fontSize: responsive.ip(1.5),
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
          */ StreamBuilder(
            stream: mesabloc.mesasStream,
            builder: (BuildContext context, AsyncSnapshot<List<MesasModel>> mesas) {
              if (mesas.hasData) {
                if (mesas.data.length > 0) {
                  return Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(1),
                      ),
                      itemCount: mesas.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        mainAxisSpacing: responsive.hp(0),
                        crossAxisSpacing: responsive.wp(2),
                      ),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return LayoutBuilder(builder: (context, constraints) {
                          return InkWell(
                            onTap: () {
                              mesabloc.obtenerMesasPorId(mesas.data[index].idMesa);

                              /*  Navigator.push(
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
                              ); */
                            },
                            child: Container(
                              width: constraints.maxWidth,
                              child: Row(
                                children: [
                                  Container(
                                    width: constraints.maxWidth * 0.12,
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
                                            height: constraints.maxHeight * 0.12,
                                            width: constraints.maxWidth * 0.2,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            height: constraints.maxHeight * 0.12,
                                            width: constraints.maxWidth * 0.2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: responsive.wp(.5),
                                  ),
                                  Container(
                                    height: constraints.maxHeight * 0.6,
                                    width: constraints.maxWidth * 0.75 - responsive.wp(2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.blue[900],
                                            Colors.blue[400],
                                            Colors.blue[200],
                                          ],
                                        )
                                        /*  color: (mesas.data[index].idComanda == '0')
                                            ? (index % 2 == 0)
                                                ? Colors.blue
                                                : Colors.yellow[800]
                                            : Colors.green, */
                                        ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: responsive.wp(1),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${mesas.data[index].mesa}',
                                                style: TextStyle(
                                                  fontSize: responsive.ip(1.7),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Icon(Icons.person),
                                              Expanded(
                                                child: Text(
                                                  '${mesas.data[index].idMesa}',
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
                                    width: responsive.wp(.5),
                                  ),
                                  Container(
                                    width: constraints.maxWidth * 0.12,
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
                                            height: constraints.maxHeight * 0.12,
                                            width: constraints.maxWidth * 0.2,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            height: constraints.maxHeight * 0.12,
                                            width: constraints.maxWidth * 0.2,
                                          )
                                        ],
                                      ),
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

