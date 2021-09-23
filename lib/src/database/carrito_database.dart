import 'package:tayta_restaurant/src/models/carrtito_model.dart';

import 'database_provider.dart';

class CarritoDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarCarito(CarritoModel carrito) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO CarritoMesa (idProducto,idComandaDetalle,nombreProducto,"
          "precioVenta,cantidad,observacion,paraLLevar,nroCuenta,idMesa,nombreMesa,idLocacion,estado) "
          "VALUES ('${carrito.idProducto}','${carrito.idComandaDetalle}','${carrito.nombreProducto}',"
          "'${carrito.precioVenta}','${carrito.cantidad}','${carrito.observacion}',"
          "'${carrito.paraLLevar}','${carrito.nroCuenta}','${carrito.idMesa}','${carrito.nombreMesa}','${carrito.idLocacion}',"
          "'${carrito.estado}')");
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<CarritoModel>> obtenerCarritoPorIdCarritoAgregar(String idMesa, String idLocacion) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM CarritoMesa where idMesa = '$idMesa' and idLocacion= '$idLocacion'");

    List<CarritoModel> list = res.isNotEmpty ? res.map((c) => CarritoModel.fromJson(c)).toList() : [];

    return list;
  }


  Future<List<CarritoModel>> obtenerCarritoPorIdCarritoAgregarNuevo(String idMesa, String idLocacion) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM CarritoMesa where idMesa = '$idMesa' and idLocacion= '$idLocacion' and idComandaDetalle = '0'");

    List<CarritoModel> list = res.isNotEmpty ? res.map((c) => CarritoModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<CarritoModel>> obtenerCarritoPorIdCarritoDisgregar(String idMesa, String idLocacion) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM CarritoMesa where idMesa = '$idMesa' and idLocacion= '$idLocacion' and idComandaDetalle<>0 group by idComandaDetalle");

    List<CarritoModel> list = res.isNotEmpty ? res.map((c) => CarritoModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<CarritoModel>> obtenerCarritoPorAgrupadoPorCuentas(String idMesa, String idLocacion) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM CarritoMesa where idMesa = '$idMesa' and idLocacion= '$idLocacion' group by nroCuenta ");

    List<CarritoModel> list = res.isNotEmpty ? res.map((c) => CarritoModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<CarritoModel>> obtenerCarritoPorIdCuentaAgregar(String idMesa, String idLocacion, String nroCuenta) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM CarritoMesa where idMesa = '$idMesa' and idLocacion= '$idLocacion'  and nroCuenta='$nroCuenta'");

    List<CarritoModel> list = res.isNotEmpty ? res.map((c) => CarritoModel.fromJson(c)).toList() : [];

    return list;
  }


  Future<List<CarritoModel>> obtenerCarritoPorIdCuentaDisgregar(String idMesa, String idLocacion, String nroCuenta) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM CarritoMesa where idMesa = '$idMesa' and idLocacion= '$idLocacion'  and nroCuenta='$nroCuenta'  group by idComandaDetalle ");

    List<CarritoModel> list = res.isNotEmpty ? res.map((c) => CarritoModel.fromJson(c)).toList() : [];

    return list;
  }

  eliminarPedidosPorMesa(String idMesa, String idLocacion) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM CarritoMesa where idMesa = '$idMesa' and idLocacion= '$idLocacion' ");

    return res;
  }

  updateCarritoPorIdComandaDetalle(CarritoModel carrito) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawUpdate("UPDATE CarritoMesa SET idProducto='${carrito.idProducto}',"
      "nombreProducto='${carrito.nombreProducto}',"
      "precioVenta='${carrito.precioVenta}',"
      "cantidad='${carrito.cantidad}',"
      "observacion='${carrito.observacion}',"
      "paraLLevar='${carrito.paraLLevar}',"
      "nroCuenta='${carrito.nroCuenta}',"
      "idMesa='${carrito.idMesa}',"
      "nombreMesa='${carrito.nombreMesa}',"
      "idLocacion='${carrito.idLocacion}',"
      "estado='${carrito.estado}' WHERE idComandaDetalle='${carrito.idComandaDetalle}'");
      return res;
    } catch (exception) {
      print(exception);
    }
  }



  eliminarProductoPorIdComandaDetalle(String idComandaDetalle ) async {
    print('borrando detalle $idComandaDetalle');
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM CarritoMesa where idComandaDetalle = '$idComandaDetalle'   ");

    return res;
  }
  eliminarProductoPorIdCarrito(String idCarrito ) async {
    print('borrando detalle $idCarrito');
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM CarritoMesa where idCarrito = '$idCarrito'   ");

    return res;
  }




  eliminarTablaCarritoMesa() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM CarritoMesa");

    return res;
  }
}
