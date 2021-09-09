


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
