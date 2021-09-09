import 'package:rxdart/rxdart.dart';
import 'package:tayta_restaurant/src/database/carrito_database.dart';
import 'package:tayta_restaurant/src/models/carrtito_model.dart';

class CarritoBloc {
  final carritoDatabase = CarritoDatabase();

  final _carritoController = BehaviorSubject<List<CarritoModel>>();

  Stream<List<CarritoModel>> get carritoStream => _carritoController.stream;

  dispose() {
    _carritoController?.close();
  }

  void obtenercarrito(String idCarrito) async {
    _carritoController.sink.add(
      await carritoDatabase.obtenerCarritoPorIdCarrito(idCarrito),
    );
  }
}
