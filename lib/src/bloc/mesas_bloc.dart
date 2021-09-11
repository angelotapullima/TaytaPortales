import 'package:rxdart/rxdart.dart';
import 'package:tayta_restaurant/src/api/mesas_api.dart';
import 'package:tayta_restaurant/src/database/carrito_database.dart';

import 'package:tayta_restaurant/src/database/mesas_database.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';

class MesasBloc {
  final mesasDatabase = MesasDatabase();
  final mesasApi = MesasApi();

  final carritoDatabase = CarritoDatabase();

  final _locacionController = BehaviorSubject<List<MesasModel>>();
  final _mesaPorID = BehaviorSubject<List<MesasModel>>();

  Stream<List<MesasModel>> get mesasStream => _locacionController.stream;
  Stream<List<MesasModel>> get mesaIdStream => _mesaPorID.stream;

  dispose() {
    _mesaPorID?.close();
    _locacionController?.close();
  }

  void obtenerMesasPorLocacion(String idLocacion) async {
    _locacionController.sink.add(await mesasDatabase.obtenerMesasPorLocacion(idLocacion));
    await mesasApi.obtenerMesasPorLocacion(idLocacion);
    _locacionController.sink.add(await mesasDatabase.obtenerMesasPorLocacion(idLocacion));
  }

  void obtenerMesasPorId(String idMesa) async {
    final List<MesasModel> mesis = [];
    final mesaList = await mesasDatabase.obtenerMesaPorId(idMesa);

    if (mesaList.length > 0) {
     // final List<CarritoModel> carris = [];

      MesasModel mesasModel = MesasModel();

      mesasModel.idMesa = mesaList[0].idMesa;
      mesasModel.idComanda = mesaList[0].idComanda;
      mesasModel.cantidadPersonas = mesaList[0].cantidadPersonas;
      mesasModel.horaIngreso = mesaList[0].horaIngreso;
      mesasModel.mesa = mesaList[0].mesa;
      mesasModel.total = mesaList[0].total;
      mesasModel.estado = mesaList[0].estado;
      mesasModel.paraLlevar = mesaList[0].paraLlevar;
      mesasModel.idUsuario = mesaList[0].idUsuario;
      mesasModel.codigoUsuario = mesaList[0].codigoUsuario;
      mesasModel.nombreCompleto = mesaList[0].nombreCompleto;
      mesasModel.locacionId = mesaList[0].locacionId;

      final carritoList = await carritoDatabase.obtenerCarritoPorIdCarrito(mesaList[0].idMesa, mesaList[0].locacionId);

      mesasModel.carrito = carritoList;
      mesis.add(mesasModel);
    }

    _mesaPorID.sink.add(mesis);
  }
}
