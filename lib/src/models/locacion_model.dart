class LocacionModel {
  LocacionModel({
    this.idLocacion,
    this.nombre,
    this.idTienda,
  });

  String idLocacion;
  String nombre;
  String idTienda;

  factory LocacionModel.fromJson(Map<String, dynamic> json) => LocacionModel(
        idLocacion: json["idLocacion"],
        nombre: json["nombre"],
        idTienda: json["idTienda"],
      );
}
