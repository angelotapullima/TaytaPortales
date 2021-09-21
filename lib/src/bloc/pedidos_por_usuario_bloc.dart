import 'package:rxdart/subjects.dart';
import 'package:tayta_restaurant/src/api/pedidos_user_api.dart';
import 'package:tayta_restaurant/src/database/pedido_user_database.dart';
import 'package:tayta_restaurant/src/models/pedido_user.dart';

class PedidosUserBloc {
  final pedidosUserDatabase = PedidosUserDatabase();
  final pedidosUserApi = PedidosUserApi();
  final _pedidosUserController = BehaviorSubject<List<PedidosUserModel>>();

  Stream<List<PedidosUserModel>> get pedidosUserStream => _pedidosUserController.stream;

  dispose() {
    _pedidosUserController?.close();
  }

  void obtenerPedidosPorUsuarioEnElDia(String dia) async {
    _pedidosUserController.sink.add([]);

    await pedidosUserApi.obtenerPedidosPorUsuario();
    _pedidosUserController.sink.add(await pedidosUserDatabase.obtenerPedidosPorDia(dia));
  }
}
