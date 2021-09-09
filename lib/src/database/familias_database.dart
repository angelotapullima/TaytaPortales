import 'package:tayta_restaurant/src/models/familias_model.dart';


import 'database_provider.dart';

class FamiliasDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarFamilias(FamiliasModel familiasModel) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Familias (idFamilia,nombre,color) "
          "VALUES ('${familiasModel.idFamilia}','${familiasModel.nombre}','${familiasModel.color}')");
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<FamiliasModel>> obtenerFamilias() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Familias");

    List<FamiliasModel> list = res.isNotEmpty ? res.map((c) => FamiliasModel.fromJson(c)).toList() : [];

    return list;
  }
}
