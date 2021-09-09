class CarritoModel{




  CarritoModel({
    this.idCarrito,
    this.idProducto,
    this.nombreProducto,
    this.precioVenta,
    this.precioLlevar,
    this.cantidad,
    this.observacion,
    this.idMesa,
    this.idLocacion,
    this.estado,
  });

  String idCarrito;
  String idProducto;
  String nombreProducto;
  String precioVenta;
  String precioLlevar;
  String cantidad;
  String observacion;
  String idMesa;
  String idLocacion;
  String estado;

  factory CarritoModel.fromJson(Map<String, dynamic> json) => CarritoModel(
        idCarrito: json["idCarrito"],
        idProducto: json["idProducto"],
        nombreProducto: json["nombreProducto"],
        precioVenta: json["precioVenta"],
        precioLlevar: json["precioLlevar"],
        cantidad: json["cantidad"],
        observacion: json["observacion"],
        idMesa: json["idMesa"],
        idLocacion: json["idLocacion"],
        estado: json["estado"],
      );



}