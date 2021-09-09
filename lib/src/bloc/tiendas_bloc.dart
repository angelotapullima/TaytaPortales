import 'package:rxdart/rxdart.dart';
import 'package:tayta_restaurant/src/api/tiendas_api.dart';
import 'package:tayta_restaurant/src/database/tienda_database.dart';
import 'package:tayta_restaurant/src/models/tienda_model.dart';

class TiendadBloc {
  final tiendasDatabase = TiendasDatabase();
  final tiendasApi =TiendaApi();
  final _tiendasController = BehaviorSubject<List<TiendaModel>>();

  Stream<List<TiendaModel>> get tiendasStream => _tiendasController.stream;

  dispose() {
    _tiendasController?.close();
  }

  void obtenerTiendas() async {
    _tiendasController.sink.add(await tiendasDatabase.obtenerTiendas());
    await tiendasApi.obtenerTiendas();
    _tiendasController.sink.add(await tiendasDatabase.obtenerTiendas());
  }
}
