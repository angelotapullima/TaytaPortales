import 'package:flutter/material.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/productos_model.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';

class ProductosItem extends StatelessWidget {
  const ProductosItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final productosBloc = ProviderBloc.prod(context);
    return StreamBuilder(
      stream: productosBloc.productoStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductosModel>> productos) {
        if (productos.hasData) {
          if (productos.data.length > 0) {
            return GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.wp(2),
              ),
              itemCount: productos.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.4,
                mainAxisSpacing: responsive.hp(.5),
                crossAxisSpacing: responsive.wp(.2),
              ),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onTap: () {
                    /*  Navigator.push(
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
                    ); */

                    //AgregarAlCarrito
                  },
                  child: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.wp(1),
                      vertical: responsive.hp(1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${productos.data[i].nombreProducto}'),
                        Spacer(),
                        Text('S/.${productos.data[i].precioVenta}'),
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
    );
  }
}
