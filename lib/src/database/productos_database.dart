

import 'package:tayta_restaurant/src/models/productos_model.dart';

import 'database_provider.dart';

class ProductosDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarProductos(ProductosModel productosModel) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Productos (idProductoLocal,idProducto,nombreProducto,"
          "precioVenta,precioLlevar,idFamilia,idLocacion,saldo) "
          "VALUES ('${productosModel.idProductoLocal}','${productosModel.idProducto}','${productosModel.nombreProducto}',"
          "'${productosModel.precioVenta}','${productosModel.precioLlevar}','${productosModel.idFamilia}','${productosModel.idLocacion}',"
          "'${productosModel.saldo}')");
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<ProductosModel>> obtenerProductosPorFamiliaLocacion(String idFamilia, String idLocacion) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Productos where idLocacion = '$idLocacion' and idFamilia = '$idFamilia'");

    List<ProductosModel> list = res.isNotEmpty ? res.map((c) => ProductosModel.fromJson(c)).toList() : [];

    return list;
  }


  Future<List<ProductosModel>> obtenerProductosPorId(String idProducto) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Productos where idProducto = '$idProducto' ");

    List<ProductosModel> list = res.isNotEmpty ? res.map((c) => ProductosModel.fromJson(c)).toList() : [];

    return list;
  }
 
}
