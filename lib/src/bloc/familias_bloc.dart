import 'package:rxdart/rxdart.dart';
import 'package:tayta_restaurant/src/api/familias_api.dart';

import 'package:tayta_restaurant/src/database/familias_database.dart';
import 'package:tayta_restaurant/src/models/familias_model.dart';

class FamiliasBloc {
  final familiasDatabase = FamiliasDatabase();
  final familiasApi = FamiliasApi();
  final _familiasController = BehaviorSubject<List<FamiliasModel>>();

  Stream<List<FamiliasModel>> get familiasStream => _familiasController.stream;

  dispose() {
    _familiasController?.close();
  }

  void obtenerFamilias(String idLocacion) async {
    //_familiasController.sink.add(await familiasDatabase.obtenerFamilias(idLocacion));
    await familiasApi.obtenerFamilias(idLocacion);
    _familiasController.sink.add(await familiasDatabase.obtenerFamilias(idLocacion));
  }  
}
