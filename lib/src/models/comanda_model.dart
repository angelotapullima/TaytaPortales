class ComandaModel {
  int idComanda;
  String idUsuario;
  int cantidadPersonas;
  int mesaId;

  List<DetalleComanda> detalles;

  ComandaModel({
    this.idComanda,
    this.idUsuario,
    this.cantidadPersonas,
    this.mesaId,
  });

  Map<String, dynamic> toJson() => {
        "idComanda": idComanda,
        "idUsuario": idUsuario,
        "cantidadPersonas": cantidadPersonas,
        "mesaId": mesaId,
        "detalles": List<dynamic>.from(detalles.map((x) => x.toJson())),
      };
}

class DetalleComanda {
  int idComandaDetalle;
  int idProducto;
  double precioUnitario;
  int cantidad;
  String observacion;
  int nroCuenta;
  DetalleComanda({
    this.idComandaDetalle,
    this.idProducto,
    this.precioUnitario,
    this.cantidad,
    this.observacion,
    this.nroCuenta,
  });

  Map<String, dynamic> toJson() => {
        "idComandaDetalle": idComandaDetalle,
        "idProducto": idProducto,
        "precioUnitario": precioUnitario,
        "cantidad": cantidad,
        "observacion": observacion,
        "nroCuenta": nroCuenta,
      };
}
