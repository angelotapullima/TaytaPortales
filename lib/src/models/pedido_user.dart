

class PedidosUserModel {
  PedidosUserModel({
    this.idPedido,
    this.mesaId,
    this.cantidadPersonas,
    this.horaIngreso,
    this.dia,
    this.mesa,
    this.total,
    this.estado,
    this.paraLlevar,
    this.idUsuario,
    this.codigoUsuario,
  });

  String idPedido;
  String mesaId;
  String cantidadPersonas;
  String horaIngreso;
  String dia;
  String mesa;
  String total;
  String estado;
  String paraLlevar;
  String idUsuario;
  String codigoUsuario; 
 

  factory PedidosUserModel.fromJson(Map<String, dynamic> json) => PedidosUserModel(
        idPedido: json["idPedido"],
        mesaId: json["mesaId"],
        cantidadPersonas: json["cantidadPersonas"],
        horaIngreso: json["horaIngreso"],
        dia: json["dia"],
        mesa: json["mesa"],
        total: json["total"],
        estado: json["estado"],
        paraLlevar: json["paraLlevar"],
        idUsuario: json["idUsuario"],
        codigoUsuario: json["codigoUsuario"], 
      );
}
