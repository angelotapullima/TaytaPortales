import 'package:tayta_restaurant/src/models/locacion_model.dart';

import 'database_provider.dart';

class LocacionDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarLocacion(LocacionModel locacionModel) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Locacion (idLocacion,nombre,idTienda) "
          "VALUES ('${locacionModel.idLocacion}','${locacionModel.nombre}','${locacionModel.idTienda}')");
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<LocacionModel>> obtenerLocacionPorTienda(String idTienda) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Locacion where idTienda = '$idTienda' ");

    List<LocacionModel> list = res.isNotEmpty ? res.map((c) => LocacionModel.fromJson(c)).toList() : [];

    return list;
  }



  eliminarTablaLocacion() async { 
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Locacion");

    return res;
  }
}
