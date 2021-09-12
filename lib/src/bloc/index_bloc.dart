import 'package:flutter/material.dart';

enum EnumIndex { mesas,productos, pedidos,familiaMesa }

class IndexBlocListener with ChangeNotifier { 
  ValueNotifier<EnumIndex> _page = ValueNotifier(EnumIndex.mesas);
  ValueNotifier<EnumIndex> get page => this._page;

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
}
