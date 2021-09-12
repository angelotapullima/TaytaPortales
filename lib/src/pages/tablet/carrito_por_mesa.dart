
import 'package:flutter/material.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class CarritoTablet extends StatelessWidget {
  const CarritoTablet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final mesasBloc = ProviderBloc.mesas(context);
    //carritoBloc.obtenercarrito(widget.mesa.idMesa, widget.mesa.locacionId);
    return SafeArea(
      bottom: false,
      child: StreamBuilder(
          stream: mesasBloc.mesaIdStream,
          builder: (context, AsyncSnapshot<List<MesasModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                double total = 0;
                double precio = 0;

                for (var i = 0; i < snapshot.data[0].carrito.length; i++) {
                  int cantidad = int.parse(snapshot.data[0].carrito[i].cantidad);
                  precio =
                      (snapshot.data[0].carrito[i].llevar == '1') ? double.parse(snapshot.data[0].carrito[i].precioVenta) : double.parse(snapshot.data[0].carrito[i].precioLlevar);
                  total = total + (cantidad * precio);
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.wp(3),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: responsive.hp(2)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                        child: Row(
                          children: [
                            Text(
                              'Mesa ${snapshot.data[0].mesa}',
                              style: TextStyle(fontSize: responsive.ip(1.2), fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: responsive.wp(5),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(height: responsive.hp(4)),
                      (snapshot.data[0].carrito.length > 0)
                          ? Expanded(
                              child: Container(
                                child: ListView.builder(
                                  itemCount: snapshot.data[0].carrito.length + 1,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    double totelx = 0;

                                    if (i != snapshot.data[0].carrito.length) {
                                      int cantidad = int.parse(snapshot.data[0].carrito[i].cantidad);
                                      precio = (snapshot.data[0].carrito[i].llevar == '0')
                                          ? double.parse(snapshot.data[0].carrito[i].precioVenta)
                                          : double.parse(snapshot.data[0].carrito[i].precioLlevar);

                                      totelx = cantidad * precio;
                                    }

                                    if (i == snapshot.data[0].carrito.length) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: responsive.wp(2),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              (snapshot.data[0].carrito.length > 1)
                                                  ? '${snapshot.data[0].carrito.length} Productos'
                                                  : '${snapshot.data[0].carrito.length} Producto',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: responsive.ip(1.2),
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              'S/. ${dosDecimales(total)}',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: responsive.ip(1.2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }

                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: responsive.hp(.5),
                                        horizontal: responsive.wp(2),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${snapshot.data[0].carrito[i].nombreProducto} x ${snapshot.data[0].carrito[i].cantidad}',
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ),
                                              SizedBox(
                                                width: responsive.wp(8),
                                              ),
                                              Text(
                                                'S/. ${dosDecimales(totelx)}',
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          (snapshot.data[0].carrito[i].llevar == '0')
                                              ? Container(
                                                  padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    'Para llevar',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: responsive.ip(1.6),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          Row(
                                            children: [
                                              Text(
                                                'Observación :',
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              SizedBox(
                                                width: responsive.wp(8),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  ' ${snapshot.data[0].carrito[i].observacion}',
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: responsive.wp(1),
                                      vertical: responsive.hp(1),
                                    ),
                                    color: Colors.red,
                                    child: Text(
                                      'Agregar productos a la mesa',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container()
                                ],
                              ),
                            )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            } else {
              return Column(
                children: [
                  Icon(
                    Icons.people_alt_sharp,
                    size: responsive.ip(20),
                  ),
                  Text(
                    'Presionar una mesa para ontener sus detalles',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: responsive.ip(2),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
