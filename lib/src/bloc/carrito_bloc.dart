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

  void obtenercarrito(String idMesa,String idLocacion) async {

    
    _carritoController.sink.add(
      await carritoDatabase.obtenerCarritoPorIdCarritoAgregar(idMesa,idLocacion),
    );
  }
}
