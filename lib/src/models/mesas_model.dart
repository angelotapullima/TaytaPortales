


import 'package:tayta_restaurant/src/models/carrtito_model.dart';
import 'package:tayta_restaurant/src/models/cuenta_model.dart';

class MesasModel {
  MesasModel({
    this.idMesa,
    this.idComanda,
    this.cantidadPersonas,
    this.horaIngreso,
    this.mesa,
    this.total,
    this.estado,
    this.paraLlevar,
    this.idUsuario,
    this.codigoUsuario,
    this.nombreCompleto,
    this.locacionId,
    this.carrito,
    this.cuentas,
  });

  String idMesa;
  String idComanda;
  String cantidadPersonas;
  String horaIngreso;
  String mesa;
  String total;
  String estado;
  String paraLlevar;
  String idUsuario;
  String codigoUsuario;
  String nombreCompleto;
  String locacionId; 

  List<CarritoModel> carrito;
  List<CuentaModel> cuentas;

  factory MesasModel.fromJson(Map<String, dynamic> json) => MesasModel(
        idMesa: json["idMesa"],
        idComanda: json["idComanda"],
        cantidadPersonas: json["cantidadPersonas"],
        horaIngreso: json["horaIngreso"],
        mesa: json["mesa"],
        total: json["total"],
        estado: json["estado"],
        paraLlevar: json["paraLlevar"],
        idUsuario: json["idUsuario"],
        codigoUsuario: json["codigoUsuario"],
        nombreCompleto: json["nombreCompleto"],
        locacionId: json["locacionId"],
      );
}
