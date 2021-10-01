class CarritoModel{




  CarritoModel({
    this.idCarrito,
    this.idComandaDetalle,
    this.idProducto,
    this.nombreProducto,
    this.precioVenta,
    this.cantidad,
    this.observacion,
    this.nroCuenta,
    this.idMesa,
    this.nombreMesa,
    this.idLocacion,
    this.estado,
    this.paraLLevar,
    this.productoDisgregacion,
  });

  int idCarrito;
  String idComandaDetalle;
  String idProducto;
  String nombreProducto;
  String precioVenta;
  String cantidad;
  String observacion;
  String nroCuenta;
  String idMesa;
  String nombreMesa;
  String idLocacion;
  String estado;
  String paraLLevar;
  String productoDisgregacion;

  factory CarritoModel.fromJson(Map<String, dynamic> json) => CarritoModel(
        idCarrito: json["idCarrito"],
        idComandaDetalle: json["idComandaDetalle"],
        idProducto: json["idProducto"],
        nombreProducto: json["nombreProducto"],
        precioVenta: json["precioVenta"],
        cantidad: json["cantidad"],
        observacion: json["observacion"],
        nroCuenta: json["nroCuenta"],
        idMesa: json["idMesa"],
        nombreMesa: json["nombreMesa"],
        idLocacion: json["idLocacion"],
        estado: json["estado"],
        paraLLevar: json["paraLLevar"],
        productoDisgregacion: json["productoDisgregacion"],
      );



}