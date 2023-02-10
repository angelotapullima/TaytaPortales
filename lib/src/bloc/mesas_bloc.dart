
import 'package:rxdart/rxdart.dart';
import 'package:tayta_restaurant/src/api/mesas_api.dart';
import 'package:tayta_restaurant/src/database/carrito_database.dart';

import 'package:tayta_restaurant/src/database/mesas_database.dart';
import 'package:tayta_restaurant/src/database/productos_database.dart';
import 'package:tayta_restaurant/src/models/api_model.dart';
import 'package:tayta_restaurant/src/models/carrtito_model.dart';
import 'package:tayta_restaurant/src/models/cuenta_model.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';

class MesasBloc {
  final mesasDatabase = MesasDatabase();
  final mesasApi = MesasApi();
  final productoDatabase = ProductosDatabase();

  final carritoDatabase = CarritoDatabase();

  final _mesasLocacionController = BehaviorSubject<List<MesasModel>>();
  final _error401Controller = BehaviorSubject<bool>();
  final _mesaPorIDAgregar = BehaviorSubject<List<MesasModel>>();
  final _mesaPorIDDisgregar = BehaviorSubject<List<MesasModel>>();
  final _mesasConPedidos = BehaviorSubject<List<MesasModel>>();

  final _errorControllerMesasApi = BehaviorSubject<ApiModel>();

  Stream<List<MesasModel>> get mesasStream => _mesasLocacionController.stream;
  Stream<bool> get error401Stream => _error401Controller.stream;
  Stream<List<MesasModel>> get mesaIdAgregarStream => _mesaPorIDAgregar.stream;
  Stream<List<MesasModel>> get mesaIdDisgregarStream => _mesaPorIDDisgregar.stream;
  Stream<List<MesasModel>> get mesasConPedidosStream => _mesasConPedidos.stream;

  Stream<ApiModel> get errorMesaStream => _errorControllerMesasApi.stream;

  dispose() {
    _mesaPorIDAgregar?.close();
    _error401Controller?.close();
    _mesaPorIDDisgregar?.close();
    _mesasLocacionController?.close();
    _mesasConPedidos?.close();
    _errorControllerMesasApi?.close();
  }

  void obtenerMesasPorLocacion(String idLocacion) async {
    print('obtenerMesasPorLocacion');
    _mesasLocacionController.sink.add([]);
    final res = await mesasApi.obtenerMesasPorLocacion(idLocacion);
    _error401Controller.sink.add(res.error);

    _errorControllerMesasApi.sink.add(res);

    _mesasLocacionController.sink.add(await mesasDatabase.obtenerMesasPorLocacion(idLocacion));
  }

  void obtenerMesasPorLocacionSinApi(String idLocacion) async {
    print('obtenerMesasPorLocacionSinApi');

    _mesasLocacionController.sink.add(await mesasDatabase.obtenerMesasPorLocacion(idLocacion));
  }

  void obtenerMesasPorIdAgregar(String idMesa) async {
    final List<MesasModel> mesis = [];
    final List<CarritoModel> car = [];
    final mesaList = await mesasDatabase.obtenerMesaPorId(idMesa);

    if (mesaList.length > 0) {
      final List<CuentaModel> cuenta = [];

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

      final carritoList = await carritoDatabase.obtenerCarritoPorIdCarritoAgregarNuevo(mesaList[0].idMesa, mesaList[0].locacionId);

      if (carritoList.length > 0) {
        for (var x = 0; x < carritoList.length; x++) {
          if (double.parse(carritoList[x].cantidad) > 0) {
            CarritoModel carritoModel = CarritoModel();
            carritoModel.idCarrito = carritoList[x].idCarrito;
            carritoModel.idProducto = carritoList[x].idProducto;
            carritoModel.nombreProducto = carritoList[x].nombreProducto;
            carritoModel.precioVenta = carritoList[x].precioVenta;
            carritoModel.cantidad = carritoList[x].cantidad;
            carritoModel.observacion = carritoList[x].observacion;
            carritoModel.nroCuenta = carritoList[x].nroCuenta;
            carritoModel.idMesa = carritoList[x].idMesa;
            carritoModel.nombreMesa = carritoList[x].nombreMesa;
            carritoModel.idLocacion = carritoList[x].idLocacion;
            carritoModel.estado = carritoList[x].estado;
            carritoModel.paraLLevar = carritoList[x].paraLLevar;
            carritoModel.idComandaDetalle = carritoList[x].idComandaDetalle;

            car.add(carritoModel);
          }
        }
      }

      final nroCuentas = await carritoDatabase.obtenerCarritoPorAgrupadoPorCuentas(mesaList[0].idMesa, mesaList[0].locacionId);

      if (nroCuentas.length > 0) {
        for (var i = 0; i < nroCuentas.length; i++) {
          double montex = 0.0;

          CuentaModel cuentaModel = CuentaModel();
          cuentaModel.cuenta = nroCuentas[i].nroCuenta;

          final carritoList2 = await carritoDatabase.obtenerCarritoPorIdCuentaAgregar(mesaList[0].idMesa, mesaList[0].locacionId, nroCuentas[i].nroCuenta);

          if (carritoList2.length > 0) {
            for (var x = 0; x < carritoList2.length; x++) {
              if (double.parse(carritoList2[x].cantidad) > 0) {
                CarritoModel carritoModel = CarritoModel();
                carritoModel.idCarrito = carritoList2[x].idCarrito;
                carritoModel.idProducto = carritoList2[x].idProducto;
                carritoModel.nombreProducto = carritoList2[x].nombreProducto;
                carritoModel.precioVenta = carritoList2[x].precioVenta;
                carritoModel.cantidad = carritoList2[x].cantidad;
                carritoModel.observacion = carritoList2[x].observacion;
                carritoModel.nroCuenta = carritoList2[x].nroCuenta;
                carritoModel.idMesa = carritoList2[x].idMesa;
                carritoModel.nombreMesa = carritoList2[x].nombreMesa;
                carritoModel.idLocacion = carritoList2[x].idLocacion;
                carritoModel.estado = carritoList2[x].estado;
                carritoModel.paraLLevar = carritoList2[x].paraLLevar;
                carritoModel.idComandaDetalle = carritoList2[x].idComandaDetalle;

                montex = montex + (double.parse(carritoList2[x].precioVenta) * double.parse(carritoList2[x].cantidad));
              }
            }
          }
          cuentaModel.monto = montex.toString();
          cuentaModel.carrito = carritoList2;
          if (montex > 0) {
            cuenta.add(cuentaModel);
          }
        }
      }

      mesasModel.cuentas = cuenta;
      mesasModel.carrito = car;
      mesis.add(mesasModel);
    }

    _mesaPorIDAgregar.sink.add(mesis);
  }

  void obtenerMesasPorIdDisgregar(String idMesa) async {
    final List<MesasModel> mesis = [];
    final List<CarritoModel> car = [];
    final mesaList = await mesasDatabase.obtenerMesaPorId(idMesa);

    if (mesaList.length > 0) {
      final List<CuentaModel> cuenta = [];

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

      final carritoList = await carritoDatabase.obtenerCarritoPorIdCarritoDisgregar(mesaList[0].idMesa, mesaList[0].locacionId);

      if (carritoList.length > 0) {
        for (var x = 0; x < carritoList.length; x++) {
          if (double.parse(carritoList[x].cantidad) > 0) {
            CarritoModel carritoModel = CarritoModel();
            carritoModel.idCarrito = carritoList[x].idCarrito;
            carritoModel.idProducto = carritoList[x].idProducto;
            carritoModel.nombreProducto = carritoList[x].nombreProducto;
            carritoModel.precioVenta = carritoList[x].precioVenta;
            carritoModel.cantidad = carritoList[x].cantidad;
            carritoModel.observacion = carritoList[x].observacion;
            carritoModel.nroCuenta = carritoList[x].nroCuenta;
            carritoModel.idMesa = carritoList[x].idMesa;
            carritoModel.nombreMesa = carritoList[x].nombreMesa;
            carritoModel.idLocacion = carritoList[x].idLocacion;
            carritoModel.estado = carritoList[x].estado;
            carritoModel.paraLLevar = carritoList[x].paraLLevar;
            carritoModel.idComandaDetalle = carritoList[x].idComandaDetalle;

            car.add(carritoModel);
          }
        }
      }

      final nroCuentas = await carritoDatabase.obtenerCarritoPorAgrupadoPorCuentas(mesaList[0].idMesa, mesaList[0].locacionId);

      if (nroCuentas.length > 0) {
        for (var i = 0; i < nroCuentas.length; i++) {
          double montex = 0.0;

          CuentaModel cuentaModel = CuentaModel();
          cuentaModel.cuenta = nroCuentas[i].nroCuenta;

          final carritoList2 = await carritoDatabase.obtenerCarritoPorIdCuentaDisgregar(mesaList[0].idMesa, mesaList[0].locacionId, nroCuentas[i].nroCuenta);

          if (carritoList2.length > 0) {
            for (var x = 0; x < carritoList2.length; x++) {
              if (double.parse(carritoList2[x].cantidad) > 0) {
                CarritoModel carritoModel = CarritoModel();
                carritoModel.idCarrito = carritoList2[x].idCarrito;
                carritoModel.idProducto = carritoList2[x].idProducto;
                carritoModel.nombreProducto = carritoList2[x].nombreProducto;
                carritoModel.precioVenta = carritoList2[x].precioVenta;
                carritoModel.cantidad = carritoList2[x].cantidad;
                carritoModel.observacion = carritoList2[x].observacion;
                carritoModel.nroCuenta = carritoList2[x].nroCuenta;
                carritoModel.idMesa = carritoList2[x].idMesa;
                carritoModel.nombreMesa = carritoList2[x].nombreMesa;
                carritoModel.idLocacion = carritoList2[x].idLocacion;
                carritoModel.estado = carritoList2[x].estado;
                carritoModel.paraLLevar = carritoList2[x].paraLLevar;
                carritoModel.idComandaDetalle = carritoList2[x].idComandaDetalle;

                montex = montex + (double.parse(carritoList2[x].precioVenta) * double.parse(carritoList2[x].cantidad));
              }
            }
          }
          cuentaModel.monto = montex.toString();
          cuentaModel.carrito = carritoList2;
          if (montex > 0) {
            cuenta.add(cuentaModel);
          }
        }
      }

      mesasModel.cuentas = cuenta;
      mesasModel.carrito = car;
      mesis.add(mesasModel);
    }

    _mesaPorIDDisgregar.sink.add(mesis);
  }

  void obtenerMesasConPedido(String idLocacion) async {
    final List<MesasModel> mesitas = [];
    final mesasPedidos = await mesasDatabase.obtenerMesaPorConPedidosPorLocacion(idLocacion);

    if (mesasPedidos.length > 0) {
      for (var i = 0; i < mesasPedidos.length; i++) {
        final List<CarritoModel> car = [];
        final List<CuentaModel> cuenta = [];
        MesasModel mesasModel = MesasModel();

        mesasModel.idMesa = mesasPedidos[i].idMesa;
        mesasModel.idComanda = mesasPedidos[i].idComanda;
        mesasModel.cantidadPersonas = mesasPedidos[i].cantidadPersonas;
        mesasModel.horaIngreso = mesasPedidos[i].horaIngreso;
        mesasModel.mesa = mesasPedidos[i].mesa;
        mesasModel.total = mesasPedidos[i].total;
        mesasModel.estado = mesasPedidos[i].estado;
        mesasModel.paraLlevar = mesasPedidos[i].paraLlevar;
        mesasModel.idUsuario = mesasPedidos[i].idUsuario;
        mesasModel.codigoUsuario = mesasPedidos[i].codigoUsuario;
        mesasModel.nombreCompleto = mesasPedidos[i].nombreCompleto;
        mesasModel.locacionId = mesasPedidos[i].locacionId;

        final carritoList = await carritoDatabase.obtenerCarritoPorIdCarritoDisgregar(mesasModel.idMesa, mesasModel.locacionId);

        if (carritoList.length > 0) {
          for (var x = 0; x < carritoList.length; x++) {
            if (double.parse(carritoList[x].cantidad) > 0) {
              CarritoModel carritoModel = CarritoModel();
              carritoModel.idCarrito = carritoList[x].idCarrito;
              carritoModel.idProducto = carritoList[x].idProducto;
              carritoModel.nombreProducto = carritoList[x].nombreProducto;
              carritoModel.precioVenta = carritoList[x].precioVenta;
              carritoModel.cantidad = carritoList[x].cantidad;
              carritoModel.observacion = carritoList[x].observacion;
              carritoModel.nroCuenta = carritoList[x].nroCuenta;
              carritoModel.idMesa = carritoList[x].idMesa;
              carritoModel.nombreMesa = carritoList[x].nombreMesa;
              carritoModel.idLocacion = carritoList[x].idLocacion;
              carritoModel.estado = carritoList[x].estado;
              carritoModel.paraLLevar = carritoList[x].paraLLevar;
              carritoModel.idComandaDetalle = carritoList[x].idComandaDetalle;

              car.add(carritoModel);
            }
          }
        }

        final nroCuentas = await carritoDatabase.obtenerCarritoPorAgrupadoPorCuentas(mesasModel.idMesa, mesasModel.locacionId);

        if (nroCuentas.length > 0) {
          for (var i = 0; i < nroCuentas.length; i++) {
            double montex = 0.0;

            CuentaModel cuentaModel = CuentaModel();
            cuentaModel.cuenta = nroCuentas[i].nroCuenta;

            final carritoList2 = await carritoDatabase.obtenerCarritoPorIdCuentaDisgregar(mesasModel.idMesa, mesasModel.locacionId, nroCuentas[i].nroCuenta);

            if (carritoList2.length > 0) {
              for (var x = 0; x < carritoList2.length; x++) {
                if (double.parse(carritoList2[x].cantidad) > 0) {
                  CarritoModel carritoModel = CarritoModel();
                  carritoModel.idCarrito = carritoList2[x].idCarrito;
                  carritoModel.idProducto = carritoList2[x].idProducto;
                  carritoModel.nombreProducto = carritoList2[x].nombreProducto;
                  carritoModel.precioVenta = carritoList2[x].precioVenta;
                  carritoModel.cantidad = carritoList2[x].cantidad;
                  carritoModel.observacion = carritoList2[x].observacion;
                  carritoModel.nroCuenta = carritoList2[x].nroCuenta;
                  carritoModel.idMesa = carritoList2[x].idMesa;
                  carritoModel.nombreMesa = carritoList2[x].nombreMesa;
                  carritoModel.idLocacion = carritoList2[x].idLocacion;
                  carritoModel.estado = carritoList2[x].estado;
                  carritoModel.paraLLevar = carritoList2[x].paraLLevar;
                  carritoModel.idComandaDetalle = carritoList2[x].idComandaDetalle;

                  montex = montex + (double.parse(carritoList2[x].precioVenta) * double.parse(carritoList2[x].cantidad));
                }
              }
            }
            cuentaModel.monto = montex.toString();
            cuentaModel.carrito = carritoList2;

            if (montex > 0) {
              cuenta.add(cuentaModel);
            }
          }
        }

        mesasModel.cuentas = cuenta;
        mesasModel.carrito = car;
        mesitas.add(mesasModel);
      }
    }

    _mesasConPedidos.sink.add(mesitas);
  }
}
