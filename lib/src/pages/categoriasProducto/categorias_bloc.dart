import 'package:flutter/material.dart';

enum CategoryProductState {
  normal,
  carrito,
}

class CategoriasProductosBloc with ChangeNotifier {
  CategoryProductState categoryProductState = CategoryProductState.normal;

  void changeToNormal() {
    categoryProductState = CategoryProductState.normal;
    notifyListeners();
  }

  void changeToCarrito() {
    categoryProductState = CategoryProductState.carrito;
    notifyListeners();
  }
}
