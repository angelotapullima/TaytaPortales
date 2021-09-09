import 'package:rxdart/rxdart.dart';
import 'package:tayta_restaurant/src/api/familias_api.dart';

import 'package:tayta_restaurant/src/database/familias_database.dart';
import 'package:tayta_restaurant/src/models/familias_model.dart';

class FamiliasBloc {
  final familiasDatabase = FamiliasDatabase();
  final familiasApi = FamiliasApi();
  final _locacionController = BehaviorSubject<List<FamiliasModel>>();

  Stream<List<FamiliasModel>> get familiasStream => _locacionController.stream;

  dispose() {
    _locacionController?.close();
  }

  void obtenerFamilias() async {
    _locacionController.sink.add(await familiasDatabase.obtenerFamilias());
    await familiasApi.obtenerFamilias();
    _locacionController.sink.add(await familiasDatabase.obtenerFamilias());
  }
}
