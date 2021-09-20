import 'package:tayta_restaurant/src/models/mesas_model.dart';

import 'database_provider.dart';

class MesasDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarMesas(MesasModel mesasModel) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Mesas (idMesa,idComanda,cantidadPersonas,horaIngreso,mesa,total,"
          "estado,paraLlevar,idUsuario,codigoUsuario,nombreCompleto,locacionId) "
          "VALUES ('${mesasModel.idMesa}','${mesasModel.idComanda}','${mesasModel.cantidadPersonas}',"
          "'${mesasModel.horaIngreso}','${mesasModel.mesa}','${mesasModel.total}','${mesasModel.estado}',"
          "'${mesasModel.paraLlevar}','${mesasModel.idUsuario}','${mesasModel.codigoUsuario}','${mesasModel.nombreCompleto}',"
          "'${mesasModel.locacionId}')");
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<MesasModel>> obtenerMesasPorLocacion(String locacionId) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Mesas where locacionId = '$locacionId'");

    List<MesasModel> list = res.isNotEmpty ? res.map((c) => MesasModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<MesasModel>> obtenerMesaPorId(String idMesa) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Mesas where idMesa = '$idMesa'");

    List<MesasModel> list = res.isNotEmpty ? res.map((c) => MesasModel.fromJson(c)).toList() : [];

    return list;
  }





  Future<List<MesasModel>> obtenerMesaPorConPedidosPorLocacion(String locacionId) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Mesas where locacionId = '$locacionId' and idComanda<>0");

    List<MesasModel> list = res.isNotEmpty ? res.map((c) => MesasModel.fromJson(c)).toList() : [];

    return list;
  }


}
