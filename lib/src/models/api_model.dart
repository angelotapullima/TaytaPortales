import 'package:tayta_restaurant/src/models/mesas_model.dart';

class ApiModel {
  bool resultadoPeticion;
  bool error;
  String mensaje;

  List<MesasModel>mesas;

  ApiModel({
    this.resultadoPeticion,
    this.error,
    this.mensaje,
    this.mesas,
  });
}
