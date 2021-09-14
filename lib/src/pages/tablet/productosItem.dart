import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/productos_model.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class ProductosItem extends StatelessWidget {
  const ProductosItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final productosBloc = ProviderBloc.prod(context);
    Offset offset = const Offset(5, 5);
    return StreamBuilder(
      stream: productosBloc.productoStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductosModel>> productos) {
        if (productos.hasData) {
          if (productos.data.length > 0) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: offset,
                    blurRadius: 10.0,
                    color: Colors.grey,
                  ),
                  BoxShadow(
                    offset: Offset(-offset.dx, -offset.dx),
                    blurRadius: 20.0,
                    color: Colors.grey.withOpacity(.5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(15),
                    ),
                    child: Text(
                      'Productos',
                      style: TextStyle(
                        fontSize: responsive.ip(1.5),
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(2),
                      ),
                      itemCount: productos.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        mainAxisSpacing: responsive.hp(.5),
                        crossAxisSpacing: responsive.wp(.2),
                      ),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int i) {
                        return LayoutBuilder(
                          builder: (_, constraints) {
                            print(constraints.maxWidth);
                            print('hello');
                            print(constraints.maxHeight);
                            return InkWell(
                              onTap: () {
                                //AgregarAlCarrito
                              },
                              child: Container(
                                height: constraints.maxWidth / 3,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: responsive.wp(1),
                                  vertical: responsive.hp(1),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: constraints.maxWidth / 3.5,
                                      height: constraints.maxWidth / 3.5,
                                      color: Color(0xffe5e5e5),
                                      child: Container(
                                        height: constraints.maxWidth / 5,
                                        width: double.infinity,
                                        child: SvgPicture.asset(
                                          'assets/platos.svg',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(10),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${productos.data[i].nombreProducto}',
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(14),
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'S/.${dosDecimales(
                                              double.parse(productos.data[i].precioVenta),
                                            )}',
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(14),
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
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
