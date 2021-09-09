import 'package:flutter/material.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/carrtito_model.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/pages/categoriasProducto/categorias_productos_page.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({Key key, @required this.mesa}) : super(key: key);

  final MesasModel mesa;

  @override
  _MesaPageState createState() => _MesaPageState();
}

class _MesaPageState extends State<CarritoPage> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final carritoBloc = ProviderBloc.carrito(context);
    carritoBloc.obtenercarrito('${widget.mesa.idMesa}${widget.mesa.locacionId}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(''),
      ),
      body: StreamBuilder(
          stream: carritoBloc.carritoStream,
          builder: (context, AsyncSnapshot<List<CarritoModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return Container();
              } else {
                return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: responsive.wp(5),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.wp(5),
                      vertical: responsive.hp(1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.table_chart),
                        SizedBox(width: responsive.wp(2)),
                        Column(children: [
                          Text(
                            'Mesa',
                            style: TextStyle(fontSize: responsive.ip(3), fontWeight: FontWeight.bold),
                          ),
                          Text(widget.mesa.mesa)
                        ]),
                        Spacer(),
                        Column(children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: responsive.ip(3), fontWeight: FontWeight.bold),
                          ),
                          Text('S/ 25.00')
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(height: responsive.hp(2)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.wp(5),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Productos',
                          style: TextStyle(fontSize: responsive.ip(3), fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: responsive.wp(5),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return CategoriasProductopage(mesa: widget.mesa);
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

                            //CategoriasProductopage
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: responsive.hp(.5),
                              horizontal: responsive.wp(2),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Agregar Productos',
                              style: TextStyle(
                                fontSize: responsive.ip(1.6),
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: responsive.hp(4)),
                  Icon(
                    Icons.pest_control_sharp,
                    size: responsive.ip(20),
                  ),
                  Text('No hay productos en esta mesa')
                ],
              );
            }
            } else {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: responsive.wp(5),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.wp(5),
                      vertical: responsive.hp(1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.table_chart),
                        SizedBox(width: responsive.wp(2)),
                        Column(children: [
                          Text(
                            'Mesa',
                            style: TextStyle(fontSize: responsive.ip(3), fontWeight: FontWeight.bold),
                          ),
                          Text(widget.mesa.mesa)
                        ]),
                        Spacer(),
                        Column(children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: responsive.ip(3), fontWeight: FontWeight.bold),
                          ),
                          Text('S/ 25.00')
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(height: responsive.hp(2)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.wp(5),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Productos',
                          style: TextStyle(fontSize: responsive.ip(3), fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: responsive.wp(5),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return CategoriasProductopage(mesa: widget.mesa);
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

                            //CategoriasProductopage
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: responsive.hp(.5),
                              horizontal: responsive.wp(2),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Agregar Productos',
                              style: TextStyle(
                                fontSize: responsive.ip(1.6),
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: responsive.hp(4)),
                  Icon(
                    Icons.pest_control_sharp,
                    size: responsive.ip(20),
                  ),
                  Text('No hay productos en esta mesa')
                ],
              );
            }
          }),
    );
  }
}
