import 'package:tayta_restaurant/src/models/carrtito_model.dart';

import 'database_provider.dart';

class CarritoDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarCarito(CarritoModel carrito) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO CarritoMesa (idProducto,nombreProducto,"
          "precioVenta,precioLlevar,cantidad,observacion,idMesa,idLocacion,llevar,estado) "
          "VALUES ('${carrito.idProducto}','${carrito.nombreProducto}',"
          "'${carrito.precioVenta}','${carrito.precioLlevar}','${carrito.cantidad}','${carrito.observacion}','${carrito.idMesa}','${carrito.idLocacion}',"
          "'${carrito.llevar}','${carrito.estado}')");
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<CarritoModel>> obtenerCarritoPorIdCarrito(String idMesa, String idLocacion) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM CarritoMesa where idMesa = '$idMesa' and idLocacion= '$idLocacion' ");

    List<CarritoModel> list = res.isNotEmpty ? res.map((c) => CarritoModel.fromJson(c)).toList() : [];

    return list;
  }
}
