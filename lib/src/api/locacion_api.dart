import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tayta_restaurant/src/database/locacion_database.dart';
import 'package:tayta_restaurant/src/models/api_model.dart';
import 'package:tayta_restaurant/src/models/locacion_model.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/preferences/prefs_url.dart';



class LocacionApi {
  final locacionDatabase = LocacionDatabase();
  final preferences = Preferences();
  final preferencesUrl = PreferencesUrl();
  Future<ApiModel> obtenerLocacionesPorTienda(String idTienda) async {
    try {
      final url = Uri.parse('${preferencesUrl.url}/api/Locacion/$idTienda');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': ' Bearer ${preferences.token}',
      };

      final resp = await http.get(
        url,
        headers: headers,
        /* body: jsonEncode({
          'userName': '$user',
          'password': '$pass',
        }), */
      );
      if (resp.statusCode == 401) {
        ApiModel apiModel = ApiModel();
        apiModel.error = true;
        apiModel.resultadoPeticion = false;
        apiModel.mensaje = 'token inválido';

        return apiModel;
      }
      print('locacionApi');

      final decodedData = json.decode(resp.body);

      if (decodedData.length > 0) {
        for (var i = 0; i < decodedData.length; i++) {
          LocacionModel locacionModel = LocacionModel();
          locacionModel.idLocacion = decodedData[i]['codigo'].toString();
          locacionModel.nombre = decodedData[i]['descripcion'].toString();
          locacionModel.idTienda = idTienda;

          await locacionDatabase.insertarLocacion(locacionModel);
        }
      }

      ApiModel apiModel = ApiModel();
      apiModel.error = false;
      apiModel.resultadoPeticion = true;
      apiModel.mensaje = 'respuesta correcta';

      return apiModel;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      ApiModel apiModel = ApiModel();
      apiModel.error = false;
      apiModel.resultadoPeticion = false;
      apiModel.mensaje = 'el envio no fue exitoso';

      return apiModel;
    }
  }
}
