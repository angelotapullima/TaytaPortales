import 'package:tayta_restaurant/src/models/pedido_user.dart';

import 'database_provider.dart';

class PedidosUserDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarPedidosPorUsuario(PedidosUserModel pedidosUserModel) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO PedidoUser (idPedido,mesaId,cantidadPersonas,horaIngreso,dia,mesa,total,"
          "estado,paraLlevar,idUsuario,codigoUsuario) "
          "VALUES ('${pedidosUserModel.idPedido}','${pedidosUserModel.mesaId}','${pedidosUserModel.cantidadPersonas}',"
          "'${pedidosUserModel.horaIngreso}','${pedidosUserModel.dia}','${pedidosUserModel.mesa}','${pedidosUserModel.total}','${pedidosUserModel.estado}',"
          "'${pedidosUserModel.paraLlevar}','${pedidosUserModel.idUsuario}','${pedidosUserModel.codigoUsuario}' )");
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<PedidosUserModel>> obtenerPedidosPorDia(String dia) async {
    try {
      final db = await dbprovider.database;
      final res = await db.rawQuery("SELECT * FROM PedidoUser where dia = '$dia'");

      List<PedidosUserModel> list = res.isNotEmpty ? res.map((c) => PedidosUserModel.fromJson(c)).toList() : [];

      return list;
    } catch (exception) {
      print(exception);
      return [];
    }
  }



  eliminarTablaPedidoUser() async { 
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM PedidoUser");

    return res;
  }
}
