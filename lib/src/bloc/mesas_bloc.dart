import 'package:rxdart/rxdart.dart';
import 'package:tayta_restaurant/src/api/mesas_api.dart';

import 'package:tayta_restaurant/src/database/mesas_database.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';

class MesasBloc {
  final mesasDatabase = MesasDatabase();
  final mesasApi = MesasApi();
  
  final _locacionController = BehaviorSubject<List<MesasModel>>();

  Stream<List<MesasModel>> get mesasStream => _locacionController.stream;

  dispose() {
    _locacionController?.close();
  }

  void obtenerMesasPorLocacion(String idLocacion) async {
    _locacionController.sink.add(await mesasDatabase.obtenerMesasPorLocacion(idLocacion));
    await mesasApi.obtenerMesasPorLocacion(idLocacion);
    _locacionController.sink.add(await mesasDatabase.obtenerMesasPorLocacion(idLocacion));
  }
}
