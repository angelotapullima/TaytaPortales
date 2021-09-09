import 'package:rxdart/rxdart.dart';
import 'package:tayta_restaurant/src/api/locacion_api.dart';
import 'package:tayta_restaurant/src/database/locacion_database.dart';
import 'package:tayta_restaurant/src/models/locacion_model.dart';

class LocacionBloc {
  final locacionDatabase = LocacionDatabase();
  final locacionApi = LocacionApi();
  final _locacionController = BehaviorSubject<List<LocacionModel>>();

  Stream<List<LocacionModel>> get locacionStream => _locacionController.stream;

  dispose() {
    _locacionController?.close();
  }

  void obtenerLocacionesPorIdTienda(String idTienda) async {
    _locacionController.sink.add(await locacionDatabase.obtenerLocacionPorTienda(idTienda));
    await locacionApi.obtenerLocacionesPorTienda(idTienda);
    _locacionController.sink.add(await locacionDatabase.obtenerLocacionPorTienda(idTienda));
  }
}
