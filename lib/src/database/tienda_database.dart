


import 'package:tayta_restaurant/src/models/tienda_model.dart';

import 'database_provider.dart';

class TiendasDatabase{


  final dbprovider = DatabaseProvider.db;

  insertarTienda(TiendaModel tiendaModel)async{
    try{
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Tienda (idTienda,tienda) "
          "VALUES ('${tiendaModel.idTienda}','${tiendaModel.tienda}')");
      return res;

    }catch(exception){
      print(exception);
    }
  }

  Future<List<TiendaModel>> obtenerTiendas() async {
    final db = await dbprovider.database;
    final res =
    await db.rawQuery("SELECT * FROM Tienda");

    List<TiendaModel> list = res.isNotEmpty
        ? res.map((c) => TiendaModel.fromJson(c)).toList()
        : [];

    return list;
  }



}