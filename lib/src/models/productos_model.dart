class ProductosModel {
  ProductosModel({
    this.idProductoLocal,
    this.idProducto,
    this.nombreProducto,
    this.precioVenta,
    this.precioLlevar,
    this.idFamilia,
    this.idLocacion,
    this.saldo,
  });

  String idProductoLocal;
  String idProducto;
  String nombreProducto;
  String precioVenta;
  String precioLlevar;
  String idFamilia;
  String idLocacion;
  String saldo;

  factory ProductosModel.fromJson(Map<String, dynamic> json) => ProductosModel(
        idProductoLocal: json["idProductoLocal"],
        idProducto: json["idProducto"],
        nombreProducto: json["nombreProducto"],
        precioVenta: json["precioVenta"],
        precioLlevar: json["precioLlevar"],
        idFamilia: json["idFamilia"],
        idLocacion: json["idLocacion"],
        saldo: json["saldo"],
      );
}
