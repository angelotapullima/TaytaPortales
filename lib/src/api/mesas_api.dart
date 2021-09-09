



import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tayta_restaurant/src/database/mesas_database.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';

import 'package:tayta_restaurant/src/utils/constants.dart';

class MesasApi {
  final mesasDatabase = MesasDatabase();
  final preferences = Preferences();
  Future<bool> obtenerMesasPorLocacion(String idLocacion) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/MesaLayout/$idLocacion');
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': ' Bearer ${preferences.token}'};

      final resp = await http.get(
        url,
        headers: headers,
        /* body: jsonEncode({
          'userName': '$user',
          'password': '$pass',
        }), */
      );

      final decodedData = json.decode(resp.body);

      if (decodedData.length > 0) {
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
        }
      }

      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      return false;
    }
  }
}
