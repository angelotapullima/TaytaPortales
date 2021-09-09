import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/familias_model.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/models/productos_model.dart';
import 'package:tayta_restaurant/src/pages/agregar_al_carrito.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';

class CategoriasProductopage extends StatefulWidget {
  const CategoriasProductopage({Key key, @required this.mesa}) : super(key: key);

  final MesasModel mesa;

  @override
  _CategoriasProductopageState createState() => _CategoriasProductopageState();
}

class _CategoriasProductopageState extends State<CategoriasProductopage> {
  final _catController = CategoryController();

  @override
  Widget build(BuildContext context) {
    final familiasBloc = ProviderBloc.familias(context);

    familiasBloc.obtenerFamilias();

    final productosBloc = ProviderBloc.prod(context);
    final responsive = Responsive.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Mesa ${widget.mesa.mesa}',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: familiasBloc.familiasStream,
        builder: (BuildContext context, AsyncSnapshot<List<FamiliasModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              productosBloc.obtenerProductosPorFamilia(snapshot.data[0].idFamilia, widget.mesa.locacionId);
              return Container(
                child: Row(
                  children: [
                    Container(
                      width: responsive.wp(30),
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                _catController.changeIndex(index, snapshot.data[index].idFamilia);
                                productosBloc.obtenerProductosPorFamilia(snapshot.data[index].idFamilia, widget.mesa.locacionId);
                              },
                              child: AnimatedBuilder(
                                  animation: _catController,
                                  builder: (_, s) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: (_catController.index == index) ? Colors.red : Colors.transparent,
                                        border: Border.all(
                                          color: (_catController.index == index) ? Colors.red : Colors.grey,
                                        ),
                                      ),
                                      height: responsive.hp(8),
                                      child: Center(
                                        child: Text(
                                          '${snapshot.data[index].nombre}',
                                          style: TextStyle(
                                            color: (_catController.index == index) ? Colors.white : Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }),
                    ),
                    Container(
                      width: responsive.wp(65),
                      child: StreamBuilder(
                        stream: productosBloc.productoStream,
                        builder: (BuildContext context, AsyncSnapshot<List<ProductosModel>> productos) {
                          if (productos.hasData) {
                            if (productos.data.length > 0) {
                              return ListView.builder(
                                itemCount: productos.data.length,
                                itemBuilder: (context, i) {
                                  return InkWell(onTap: (){

                                    Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (context, animation, secondaryAnimation) {
                                      return AgregarAlCarrito(mesas: widget.mesa, productosModel: productos.data[i]);
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


                                    //AgregarAlCarrito
                                  },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: responsive.wp(2),
                                        vertical: responsive.hp(1),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text('${productos.data[i].nombreProducto}'),
                                              ),
                                              SizedBox(
                                                width: responsive.wp(2),
                                              ),
                                              Text('S/.${productos.data[i].precioVenta}'),
                                            ],
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              );
            } else {
              return CupertinoActivityIndicator();
            }
          } else {
            return CupertinoActivityIndicator();
          }
        },
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
