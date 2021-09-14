import 'package:tayta_restaurant/src/models/carrtito_model.dart';

class CuentaModel {
  String cuenta;
  String monto;
  List<CarritoModel> carrito;

  CuentaModel({
    this.cuenta,
    this.monto,
    this.carrito,
  });
}
