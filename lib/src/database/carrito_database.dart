import 'package:tayta_restaurant/src/models/carrtito_model.dart';

import 'database_provider.dart';

class CarritoDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarCarito(CarritoModel carrito) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO CarritoMesa (idProducto,idComandaDetalle,nombreProducto,"
          "precioVenta,precioLlevar,cantidad,observacion,paraLLevar,nroCuenta,idMesa,nombreMesa,idLocacion,estado) "
          "VALUES ('${carrito.idProducto}','${carrito.idComandaDetalle}','${carrito.nombreProducto}',"
          "'${carrito.precioVenta}','${carrito.precioLlevar}','${carrito.cantidad}','${carrito.observacion}',"
          "'${carrito.paraLLevar}','${carrito.nroCuenta}','${carrito.idMesa}','${carrito.nombreMesa}','${carrito.idLocacion}',"
          "'${carrito.estado}')");
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


  Future<List<CarritoModel>> obtenerCarritoPorAgrupadoPorCuentas(String idMesa, String idLocacion) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM CarritoMesa where idMesa = '$idMesa' and idLocacion= '$idLocacion' group by nroCuenta ");

    List<CarritoModel> list = res.isNotEmpty ? res.map((c) => CarritoModel.fromJson(c)).toList() : [];

    return list;
  }


  Future<List<CarritoModel>> obtenerCarritoPorIdCuenta(String idMesa, String idLocacion, String nroCuenta) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM CarritoMesa where idMesa = '$idMesa' and idLocacion= '$idLocacion'  and nroCuenta='$nroCuenta' ");

    List<CarritoModel> list = res.isNotEmpty ? res.map((c) => CarritoModel.fromJson(c)).toList() : [];

    return list;
  }


  eliminarPedidosPorMesa(String idMesa, String idLocacion) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM CarritoMesa where idMesa = '$idMesa' and idLocacion= '$idLocacion' " );

    return res;
  }
}
