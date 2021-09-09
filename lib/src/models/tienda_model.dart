class TiendaModel {
  TiendaModel({
    this.idTienda,
    this.tienda,
  });

  String idTienda;
  String tienda;

  factory TiendaModel.fromJson(Map<String, dynamic> json) => TiendaModel(
        idTienda: json["idTienda"],
        tienda: json["tienda"],
      );
}
