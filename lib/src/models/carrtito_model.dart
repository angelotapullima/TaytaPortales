class CarritoModel{




  CarritoModel({
    this.idCarrito,
    this.idProducto,
    this.nombreProducto,
    this.precioVenta,
    this.precioLlevar,
    this.cantidad,
    this.observacion,
    this.nroCuenta,
    this.idMesa,
    this.nombreMesa,
    this.idLocacion,
    this.estado,
    this.paraLLevar,
  });

  int idCarrito;
  String idProducto;
  String nombreProducto;
  String precioVenta;
  String precioLlevar;
  String cantidad;
  String observacion;
  String nroCuenta;
  String idMesa;
  String nombreMesa;
  String idLocacion;
  String estado;
  String paraLLevar;

  factory CarritoModel.fromJson(Map<String, dynamic> json) => CarritoModel(
        idCarrito: json["idCarrito"],
        idProducto: json["idProducto"],
        nombreProducto: json["nombreProducto"],
        precioVenta: json["precioVenta"],
        precioLlevar: json["precioLlevar"],
        cantidad: json["cantidad"],
        observacion: json["observacion"],
        nroCuenta: json["nroCuenta"],
        idMesa: json["idMesa"],
        nombreMesa: json["nombreMesa"],
        idLocacion: json["idLocacion"],
        estado: json["estado"],
        paraLLevar: json["paraLLevar"],
      );



}