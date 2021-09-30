import 'package:flutter/material.dart';
import 'package:tayta_restaurant/src/bloc/carrito_bloc.dart';
import 'package:tayta_restaurant/src/bloc/error_api_bloc.dart';
import 'package:tayta_restaurant/src/bloc/familias_bloc.dart';
import 'package:tayta_restaurant/src/bloc/locacion_bloc.dart';
import 'package:tayta_restaurant/src/bloc/login_bloc.dart';
import 'package:tayta_restaurant/src/bloc/mesas_bloc.dart';
import 'package:tayta_restaurant/src/bloc/pedidos_por_usuario_bloc.dart';
import 'package:tayta_restaurant/src/bloc/producto_bloc.dart';
import 'package:tayta_restaurant/src/bloc/tiendas_bloc.dart';

//singleton para obtner una unica instancia del Bloc
class ProviderBloc extends InheritedWidget {
  static ProviderBloc _instancia;

  final tiendadBloc = TiendadBloc();
  final loginBloc = LoginBloc();
  final locacionBloc = LocacionBloc();
  final mesasBloc = MesasBloc();
  final carritoBloc = CarritoBloc();
  final familiasBloc = FamiliasBloc();
  final productosBloc = ProductosBloc();
  final pedidosUserBloc = PedidosUserBloc();
  final errorApi = ErrorApi();

  factory ProviderBloc({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderBloc._internal(key: key, child: child);
    }

    return _instancia;
  }

  ProviderBloc._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TiendadBloc tiendas(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).tiendadBloc;
  }

  static LoginBloc login(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).loginBloc;
  }

  static LocacionBloc locacion(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).locacionBloc;
  }

  static MesasBloc mesas(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).mesasBloc;
  }

  static CarritoBloc carrito(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).carritoBloc;
  }

  static FamiliasBloc familias(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).familiasBloc;
  }

  static ProductosBloc prod(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).productosBloc;
  }


  static PedidosUserBloc pedidoUser(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).pedidosUserBloc;
  }

  static ErrorApi erApi(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).errorApi;
  }
}
