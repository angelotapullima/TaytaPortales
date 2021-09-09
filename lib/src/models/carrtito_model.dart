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
    this.llevar,
  });

  int idCarrito;
  String idProducto;
  String nombreProducto;
  String precioVenta;
  String precioLlevar;
  String cantidad;
  String observacion;
  String idMesa;
  String idLocacion;
  String estado;
  String llevar;

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
        llevar: json["llevar"],
      );



}