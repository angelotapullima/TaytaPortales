import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tayta_restaurant/src/database/carrito_database.dart';
import 'package:tayta_restaurant/src/database/mesas_database.dart';
import 'package:tayta_restaurant/src/models/api_model.dart';
import 'package:tayta_restaurant/src/models/carrtito_model.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class MesasApi {
  final mesasDatabase = MesasDatabase();
  final carritoDatabase = CarritoDatabase();
  final preferences = Preferences();
  Future<ApiModel> obtenerMesasPorLocacion(String idLocacion) async {
    var entradaapi = DateTime.now();

    print('entrada a la api $entradaapi');
    try {
      final List<MesasModel> listMesas = [];
      final url = Uri.parse('${preferences.url}/api/MesaLayout/$idLocacion');
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': ' Bearer ${preferences.token}'};

      final resp = await http.get(
        url,
        headers: headers,
        /* body: jsonEncode({
          'userName': '$user',
          'password': '$pass',
        }), */
      );

      print(resp.statusCode);
      var respuestaApi = DateTime.now();

      Duration _minutos = respuestaApi.difference(entradaapi);

      print('diferencia a la api ${_minutos.inMilliseconds}');

      if (resp.statusCode == 401) {
        ApiModel apiModel = ApiModel();
        apiModel.error = true;
        apiModel.resultadoPeticion = false;
        apiModel.mensaje = 'token inválido';

        return apiModel;
      }
      final decodedData = json.decode(resp.body);

      if (decodedData.length > 0) {
        await carritoDatabase.eliminarTablaCarritoMesa();
        //await mesasDatabase.eliminarTablaMesas();
        for (var i = 0; i < decodedData.length; i++) {
          MesasModel mesasModel = MesasModel();
          mesasModel.idMesa = decodedData[i]['mesaId'].toString();
          mesasModel.idComanda = decodedData[i]['id'].toString();
          mesasModel.cantidadPersonas = decodedData[i]['cantidadPersonas'].toString();
          mesasModel.horaIngreso = decodedData[i]['horaIngreso'].toString();
          mesasModel.mesa = decodedData[i]['mesa'].toString();
          mesasModel.total = decodedData[i]['total'].toString();
          mesasModel.estado = decodedData[i]['estado'].toString();
          mesasModel.paraLlevar = decodedData[i]['paraLlevar'].toString();
          mesasModel.idUsuario = decodedData[i]['idUsuario'].toString();
          mesasModel.codigoUsuario = decodedData[i]['codigoUsuario'].toString();
          mesasModel.nombreCompleto = decodedData[i]['nombresCompletos'].toString();
          mesasModel.locacionId = idLocacion.toString();

          await mesasDatabase.insertarMesas(mesasModel);

          if (decodedData[i]['detalles'] != null) {
            if (decodedData[i]['detalles'].length > 0) {
              //await carritoDatabase.eliminarPedidosPorMesa(decodedData[i]['mesaId'].toString(), idLocacion.toString());

              final List<CarritoModel> listCarrito = [];
              for (var x = 0; x < decodedData[i]['detalles'].length; x++) {
                CarritoModel carritoModel = CarritoModel();
                carritoModel.idProducto = decodedData[i]['detalles'][x]['idProducto'].toString();
                carritoModel.idComandaDetalle = decodedData[i]['detalles'][x]['idComandaDetalle'].toString();
                carritoModel.nombreProducto = decodedData[i]['detalles'][x]['nombreProducto'].toString();
                carritoModel.precioVenta = decodedData[i]['detalles'][x]['precioUnitario'].toString();
                carritoModel.cantidad = decodedData[i]['detalles'][x]['cantidad'].toString();
                carritoModel.observacion = decodedData[i]['detalles'][x]['observacion'].toString();
                carritoModel.nroCuenta = decodedData[i]['detalles'][x]['nroCuenta'].toString();
                carritoModel.paraLLevar = (decodedData[i]['detalles'][x]['paraLlevar'].toString() == 'true') ? '1' : '0';
                carritoModel.idMesa = decodedData[i]['mesaId'].toString();
                carritoModel.idLocacion = idLocacion.toString();
                carritoModel.estado = '1';
                carritoModel.productoDisgregacion = '0';
                listCarrito.add(carritoModel);

                await carritoDatabase.insertarCarito(carritoModel);
              }

              mesasModel.carrito = listCarrito;
            } else {
              await carritoDatabase.eliminarPedidosPorMesa(decodedData[i]['mesaId'].toString(), idLocacion.toString());
            }
          } else {
            await carritoDatabase.eliminarPedidosPorMesa(decodedData[i]['mesaId'].toString(), idLocacion.toString());
          }

          listMesas.add(mesasModel);
        }
      }

      ApiModel apiModel = ApiModel();
      apiModel.error = false;
      apiModel.resultadoPeticion = true;
      apiModel.mensaje = 'respuesta correcta';
      apiModel.mesas = listMesas;

      var salidaFuncion = DateTime.now();


      Duration _final = salidaFuncion.difference(respuestaApi);

      print('salida deapi ${_final.inMilliseconds}');

     
      return apiModel;
    } catch (error, stacktrace) {
      showToast2("Exception occured: $error stackTrace: $stacktrace", Colors.red);
      print("Exception occured: $error stackTrace: $stacktrace");

      ApiModel apiModel = ApiModel();
      apiModel.error = false;
      apiModel.resultadoPeticion = false;
      apiModel.mensaje = "Exception occured: $error stackTrace: $stacktrace";

     

      return apiModel;
    }
  }
}
