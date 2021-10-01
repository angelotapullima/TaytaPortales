import 'package:flutter/material.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';

enum EnumIndex { mesas, productos, pedidos, familiaMesa, config }

class IndexBlocListener with ChangeNotifier {
  int index = 0;
  final preferences = Preferences();

  void changeIndex(int i) {
    print('index $i');
    index = i;
    notifyListeners();
  }

  ValueNotifier<EnumIndex> _page = ValueNotifier(EnumIndex.mesas);
  ValueNotifier<EnumIndex> get page => this._page;

  ValueNotifier<bool> _cargandoEnvio = ValueNotifier(false);
  ValueNotifier<bool> get cargandoEnvio => this._cargandoEnvio;

  ValueNotifier<bool> _cargandoDisgregacion = ValueNotifier(false);
  ValueNotifier<bool> get cargandoDisgregacion => this._cargandoDisgregacion;

  IndexBlocListener() {
    _init();
  }
  void _init() {}

  void changeToMesa(BuildContext context) {
    final mesabloc = ProviderBloc.mesas(context);

    mesabloc.obtenerMesasPorLocacion(preferences.locacionId);

    _page.value = EnumIndex.mesas;
    notifyListeners();
  }

  void changeToMesa2(BuildContext context) {
    _page.value = EnumIndex.mesas;
    notifyListeners();
  }

  void changeToProductos() {
    _page.value = EnumIndex.productos;
    notifyListeners();
  }

  void changeToPedidos() {
    _page.value = EnumIndex.pedidos;
    notifyListeners();
  }

  void changeToFamiliaMesa() {
    _page.value = EnumIndex.familiaMesa;
    notifyListeners();
  }

  void changeToConfig() {
    _page.value = EnumIndex.config;
    notifyListeners();
  }

  void changeCargandoTrue() {
    _cargandoEnvio.value = true;
    notifyListeners();
  }

  void changeCargandoFalse() {
    _cargandoEnvio.value = false;
    notifyListeners();
  }

  void changeCargandoTrueDisgregacion() {
    _cargandoDisgregacion.value = true;
    notifyListeners();
  }

  void changeCargandoFalseDisgregacion() {
    _cargandoDisgregacion.value = false;
    notifyListeners();
  }
}
