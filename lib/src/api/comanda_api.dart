import 'dart:convert';

import 'package:tayta_restaurant/src/database/carrito_database.dart';
import 'package:tayta_restaurant/src/database/mesas_database.dart';
import 'package:tayta_restaurant/src/database/productos_database.dart';
import 'package:tayta_restaurant/src/models/api_model.dart';
import 'package:tayta_restaurant/src/models/comanda_model.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:http/http.dart' as http;

class ComandaApi {
  final carritoDatabase = CarritoDatabase();
  final mesasDatabase = MesasDatabase();
  final productoDatabase = ProductosDatabase();
  final preferences = Preferences();

  Future<ApiModel> enviarComanda(String idMesa,int cantidad) async {
    try {
      final mesaID = await mesasDatabase.obtenerMesaPorId(idMesa);

      if (mesaID.length > 0) {
        final List<DetalleComanda> detallesList = [];

        ComandaModel comanda = ComandaModel();
        comanda.idComanda = int.parse(mesaID[0].idComanda);
        comanda.idUsuario = preferences.idUsuario;
        comanda.cantidadPersonas = cantidad;
        comanda.mesaId = int.parse(mesaID[0].idMesa);

        final carrito = await carritoDatabase.obtenerCarritoPorIdCarritoDisgregar(mesaID[0].idMesa, mesaID[0].locacionId);

        if (carrito.length > 0) {
          for (var i = 0; i < carrito.length; i++) {
            DetalleComanda detalleComanda = DetalleComanda();
            detalleComanda.idComandaDetalle = int.parse(carrito[i].idComandaDetalle);
            detalleComanda.idProducto = int.parse(carrito[i].idProducto);
            detalleComanda.cantidad = double.parse(carrito[i].cantidad).toInt();
            detalleComanda.precioUnitario = double.parse(carrito[i].precioVenta);
            detalleComanda.observacion = carrito[i].observacion;
            detalleComanda.nroCuenta = int.parse(carrito[i].nroCuenta);
            detalleComanda.paraLLevar = (carrito[i].paraLLevar == '1') ? true:false;
            detallesList.add(detalleComanda);
          }
        }

        final carritoNuevo = await carritoDatabase.obtenerCarritoPorIdCarritoAgregarNuevo(mesaID[0].idMesa, mesaID[0].locacionId);

        if (carritoNuevo.length > 0) {
          for (var i = 0; i < carritoNuevo.length; i++) {
            DetalleComanda detalleComanda = DetalleComanda();
            detalleComanda.idComandaDetalle = int.parse(carritoNuevo[i].idComandaDetalle);
            detalleComanda.idProducto = int.parse(carritoNuevo[i].idProducto);
            detalleComanda.cantidad = double.parse(carritoNuevo[i].cantidad).toInt();
            detalleComanda.precioUnitario = double.parse(carritoNuevo[i].precioVenta);
            detalleComanda.observacion = carritoNuevo[i].observacion;
            detalleComanda.nroCuenta = int.parse(carritoNuevo[i].nroCuenta);
            detalleComanda.paraLLevar = (carritoNuevo[i].paraLLevar == '1') ? true:false;
            detallesList.add(detalleComanda);
          }
        }
        comanda.detalles = detallesList;
        var envio = jsonEncode(comanda.toJson());
        final url = Uri.parse('${preferences.url}/api/Comanda');
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Authorization': ' Bearer ${preferences.token}',
        };

        final resp = await http.post(url, headers: headers, body: envio);

        if (resp.statusCode == 401) {
          ApiModel apiModel = ApiModel();
          apiModel.error = true;
          apiModel.resultadoPeticion = false;
          apiModel.mensaje = 'token inválido';

          return apiModel;
        }
        print('comanda api');

        final decodedData = json.decode(resp.body);

        print(decodedData['exito']);
        if ('${decodedData['exito']}' == 'true') {
          ApiModel apiModel = ApiModel();
          apiModel.error = false;
          apiModel.resultadoPeticion = true;
          apiModel.mensaje = 'respuesta correcta';

          return apiModel;
        } else {
          ApiModel apiModel = ApiModel();
          apiModel.error = false;
          apiModel.resultadoPeticion = false;
          apiModel.mensaje = 'el envio no fue exitoso';

          return apiModel;
        }
      } else {
        ApiModel apiModel = ApiModel();
        apiModel.error = false;
        apiModel.resultadoPeticion = false;
        apiModel.mensaje = 'el envio no fue exitoso';

        return apiModel;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      ApiModel apiModel = ApiModel();
      apiModel.error = false;
      apiModel.resultadoPeticion = false;
      apiModel.mensaje = 'error al realizar la peticion';

      return apiModel;
    }
  }
}
