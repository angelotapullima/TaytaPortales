import 'package:flutter/material.dart';

enum EnumIndex { mesas,productos, pedidos,familiaMesa }

class IndexBlocListener with ChangeNotifier { 
  ValueNotifier<EnumIndex> _page = ValueNotifier(EnumIndex.mesas);
  ValueNotifier<EnumIndex> get page => this._page;


  ValueNotifier<bool> _cargandoEnvio = ValueNotifier(false);
  ValueNotifier<bool> get cargandoEnvio => this._cargandoEnvio; 


  ValueNotifier<bool> _cargandoDisgregacion = ValueNotifier(false);
  ValueNotifier<bool> get cargandoDisgregacion  => this._cargandoDisgregacion; 




  BuildContext context;

  IndexBlocListener({this.context}) {
    _init();
  }
  void _init() {}

  void changeToMesa() {
    _page.value =EnumIndex.mesas;
    notifyListeners();
  }

  void changeToProductos() {
    _page.value  = EnumIndex.productos;
    notifyListeners();
  }


  void changeToPedidos() {
    _page.value  = EnumIndex.pedidos;
    notifyListeners();
  }


  void changeToFamiliaMesa() {
    _page.value  = EnumIndex.familiaMesa;
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
