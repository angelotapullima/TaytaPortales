import 'dart:convert';

import 'package:tayta_restaurant/src/database/carrito_database.dart';
import 'package:tayta_restaurant/src/database/mesas_database.dart';
import 'package:tayta_restaurant/src/database/productos_database.dart';
import 'package:tayta_restaurant/src/models/comanda_model.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class ComandaApi {
  final carritoDatabase = CarritoDatabase();
  final mesasDatabase = MesasDatabase();
  final productoDatabase = ProductosDatabase();
  final preferences = Preferences();

  Future<bool> enviarComanda(String idMesa) async {
    try {
      final mesaID = await mesasDatabase.obtenerMesaPorId(idMesa);

      if (mesaID.length > 0) {
        final List<DetalleComanda> detallesList = [];

        ComandaModel comanda = ComandaModel();
        comanda.idComanda = int.parse(mesaID[0].idComanda);
        comanda.idUsuario = preferences.idUsuario;
        comanda.cantidadPersonas = 0;
        comanda.mesaId = int.parse(mesaID[0].idMesa);

        final carrito = await carritoDatabase.obtenerCarritoPorIdCarritoDisgregar(mesaID[0].idMesa, mesaID[0].locacionId);

        if (carrito.length > 0) {
          for (var i = 0; i < carrito.length; i++) {
            
            DetalleComanda detalleComanda = DetalleComanda();
            detalleComanda.idComandaDetalle = int.parse(carrito[i].idComandaDetalle);
            detalleComanda.idProducto = int.parse(carrito[i].idProducto);
            detalleComanda.cantidad = double.parse(carrito[i].cantidad).toInt();
            detalleComanda.precioUnitario = (carrito[i].paraLLevar == '1') ? double.parse(carrito[0].precioLlevar) : double.parse(carrito[i].precioVenta);
            detalleComanda.observacion = carrito[i].observacion;
            detalleComanda.nroCuenta = int.parse(carrito[i].nroCuenta);
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
            detalleComanda.precioUnitario = (carritoNuevo[i].paraLLevar == '1') ? double.parse(carritoNuevo[i].precioLlevar) : double.parse(carritoNuevo[i].precioVenta);
            detalleComanda.observacion = carritoNuevo[i].observacion;
            detalleComanda.nroCuenta = int.parse(carritoNuevo[i].nroCuenta);
            detallesList.add(detalleComanda);
          }
        }
        comanda.detalles = detallesList;
        var envio = jsonEncode(comanda.toJson());
        final url = Uri.parse('$apiBaseURL/api/Comanda');
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Authorization': ' Bearer ${preferences.token}',
        };

        final resp = await http.post(url, headers: headers, body: envio);

        print('comanda api');

        
        final decodedData = json.decode(resp.body);

        print(decodedData['exito']);
        if ('${decodedData['exito']}' == 'true') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      return false;
    }
  }
}
