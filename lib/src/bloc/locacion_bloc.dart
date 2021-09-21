import 'package:rxdart/rxdart.dart';
import 'package:tayta_restaurant/src/api/locacion_api.dart';
import 'package:tayta_restaurant/src/database/locacion_database.dart';
import 'package:tayta_restaurant/src/models/locacion_model.dart';

class LocacionBloc {
  final locacionDatabase = LocacionDatabase();
  final locacionApi = LocacionApi();
  final _locacionController = BehaviorSubject<List<LocacionModel>>();
  final _errorController = BehaviorSubject<bool>();

  Stream<List<LocacionModel>> get locacionStream => _locacionController.stream;
  Stream<bool> get errorStream => _errorController.stream;

  dispose() {
    _locacionController?.close();
    _errorController?.close();
  }

  void obtenerLocacionesPorIdTienda(String idTienda) async {
    //_locacionController.sink.add(await locacionDatabase.obtenerLocacionPorTienda(idTienda));
    final res = await locacionApi.obtenerLocacionesPorTienda(idTienda);

    _errorController.sink.add(res.error);
    _locacionController.sink.add(await locacionDatabase.obtenerLocacionPorTienda(idTienda));
  }
}
