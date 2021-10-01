import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tayta_restaurant/src/api/locacion_api.dart';
import 'package:tayta_restaurant/src/api/mesas_api.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/database/locacion_database.dart';
import 'package:tayta_restaurant/src/models/locacion_model.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';

class LocacionBloc {
  final preferences = Preferences();
  final locacionDatabase = LocacionDatabase();
  final locacionApi = LocacionApi();
  final mesasApi = MesasApi();
  final _locacionController = BehaviorSubject<List<LocacionModel>>();
  final _errorController = BehaviorSubject<bool>();

  Stream<List<LocacionModel>> get locacionStream => _locacionController.stream;
  Stream<bool> get errorStream => _errorController.stream;

  dispose() {
    _locacionController?.close();
    _errorController?.close();
  }

  void obtenerLocacionesPorIdTienda(String idTienda, BuildContext context) async {
    print('llamar locacion');
    if (preferences.llamadaLocacion == null || preferences.llamadaLocacion == 'false' || preferences.llamadaLocacion == '') {
      final res = await locacionApi.obtenerLocacionesPorTienda(idTienda);

      _errorController.sink.add(res.error);

      final locacionDbv2 = await locacionDatabase.obtenerLocacionPorTienda(idTienda);
      await mesasApi.obtenerMesasPorLocacion(locacionDbv2[0].idLocacion);
    }

    final locacionDbv = await locacionDatabase.obtenerLocacionPorTienda(idTienda);

    final mesasBloc = ProviderBloc.mesas(context);
    mesasBloc.obtenerMesasPorLocacionSinApi(locacionDbv[0].idLocacion);

    preferences.locacionId = locacionDbv[0].idLocacion;
    _locacionController.sink.add(locacionDbv);
  }
}
