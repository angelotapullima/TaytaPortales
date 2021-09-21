import 'package:rxdart/rxdart.dart';
import 'package:tayta_restaurant/src/api/producto_api.dart';
import 'package:tayta_restaurant/src/database/productos_database.dart';
import 'package:tayta_restaurant/src/models/productos_model.dart';


class ProductosBloc {
  final productosDatabase = ProductosDatabase();
  final productoApi = ProductoApi();
  final _productoController = BehaviorSubject<List<ProductosModel>>();

  Stream<List<ProductosModel>> get productoStream => _productoController.stream;

  dispose() {
    _productoController?.close();
  }

  void obtenerProductosPorFamilia(String idFamilia,String idLocacion) async {
    _productoController.sink.add([]);
    await productoApi.obtenerProductosPorFamilia(idFamilia, idLocacion);
    _productoController.sink.add(await productosDatabase.obtenerProductosPorFamiliaLocacion(idFamilia, idLocacion));
  }

}
