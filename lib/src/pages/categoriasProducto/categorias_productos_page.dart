import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/carrtito_model.dart';
import 'package:tayta_restaurant/src/models/familias_model.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/models/productos_model.dart';
import 'package:tayta_restaurant/src/pages/agregar_al_carrito.dart';
import 'package:tayta_restaurant/src/pages/categoriasProducto/categorias_bloc.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';

const _panelTransition = Duration(milliseconds: 500);

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
    final bloc = CategoriasProductosBloc();
    final familiasBloc = ProviderBloc.familias(context);
 

    final productosBloc = ProviderBloc.prod(context);
    final responsive = Responsive.of(context);

    var cartBarheight = responsive.hp(17);

    void _onVerticalGesture(DragUpdateDetails details) {
      if (details.primaryDelta < -7) {
        bloc.changeToCarrito();
      } else if (details.primaryDelta > 12) {
        bloc.changeToNormal();
      }
    }

    double _getTopForWhitePanel(CategoryProductState state, Size size) {
      if (state == CategoryProductState.normal) {
        return -cartBarheight;
      } else if (state == CategoryProductState.carrito) {
        return -(size.height - kToolbarHeight - cartBarheight / 2);
      }

      return 0;
    }

    double _getTopForBlackPanel(CategoryProductState state, Size size) {
      if (state == CategoryProductState.normal) {
        return size.height - kToolbarHeight - cartBarheight;
      } else if (state == CategoryProductState.carrito) {
        return cartBarheight / 2;
      }
      return 0;
    }

    final size = MediaQuery.of(context).size;

    final carritoBloc = ProviderBloc.carrito(context);
    carritoBloc.obtenercarrito(widget.mesa.idMesa, widget.mesa.locacionId);

    return AnimatedBuilder(
      animation: bloc,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.black,
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
          body: Stack(
            children: [
              AnimatedPositioned(
                duration: _panelTransition,
                curve: Curves.decelerate,
                left: 0,
                right: 0,
                top: _getTopForWhitePanel(bloc.categoryProductState, size),
                height: responsive.hp(100) - kToolbarHeight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: StreamBuilder(
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
                                        itemCount: snapshot.data.length + 1,
                                        itemBuilder: (context, index) {
                                          if (index == 0) {
                                            return Container(
                                              height: cartBarheight,
                                            );
                                          }
                                          index = index - 1;
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
                                                return InkWell(
                                                  onTap: () {
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
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: _panelTransition,
                curve: Curves.decelerate,
                child: GestureDetector(
                  onVerticalDragUpdate: _onVerticalGesture,
                  child: Container(
                    color: Colors.black,
                    child: StreamBuilder(
                      stream: carritoBloc.carritoStream,
                      builder: (context, AsyncSnapshot<List<CarritoModel>> carrito) {
                        if (carrito.hasData && carrito.data != null) {
                          double total = 0;
                          double precio = 0;

                          for (var i = 0; i < carrito.data.length; i++) {
                            int cantidad = int.parse(carrito.data[i].cantidad);
                            precio =  double.parse(carrito.data[i].precioVenta);
                            total = total + (cantidad * precio);
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: responsive.wp(3),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: responsive.hp(1),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    (bloc.categoryProductState == CategoryProductState.normal)
                                        ? Icon(
                                            Icons.arrow_upward,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.arrow_downward_rounded,
                                            color: Colors.white,
                                          )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      (carrito.data.length > 1) ? '${carrito.data.length} Productos' : '${carrito.data.length} Producto',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: responsive.ip(2.5),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'S/. ${total.toString()}',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: responsive.ip(3),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: responsive.hp(6),
                                    ),
                                    child: ListView.builder(
                                      itemCount: carrito.data.length,
                                      itemBuilder: (context, i) {
                                        double totelx = 0;
                                        int cantidad = int.parse(carrito.data[i].cantidad);
                                        precio = double.parse(carrito.data[i].precioVenta);

                                        totelx = cantidad * precio;

                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: responsive.hp(1),
                                            horizontal: responsive.wp(2),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${carrito.data[i].nombreProducto} x ${carrito.data[i].cantidad}',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: responsive.wp(8),
                                                  ),
                                                  Text(
                                                    'S/. $totelx',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Observación :',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    width: responsive.wp(8),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      ' ${carrito.data[i].observacion}',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              SizedBox(
                                height: responsive.hp(3),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (bloc.categoryProductState == CategoryProductState.normal)
                                      ? Icon(
                                          Icons.arrow_upward,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.arrow_downward_rounded,
                                          color: Colors.white,
                                        )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '0 Productos',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsive.ip(3),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'S/. 30.00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsive.ip(3),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
                height: responsive.hp(100),
                top: _getTopForBlackPanel(bloc.categoryProductState, size),
                left: 0,
                right: 0,
              )
            ],
          ),
        );
      },
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
