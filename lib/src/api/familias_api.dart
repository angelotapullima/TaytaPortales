import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tayta_restaurant/src/database/familias_database.dart';
import 'package:tayta_restaurant/src/models/api_model.dart';
import 'package:tayta_restaurant/src/models/familias_model.dart';

import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/preferences/prefs_url.dart';


class FamiliasApi {
  final familiasDatabase = FamiliasDatabase();
  final preferences = Preferences();
  final preferencesUrl = PreferencesUrl();
  Future<ApiModel> obtenerFamilias(String idLocacion) async {
    try {
      final url = Uri.parse('${preferencesUrl.url}/api/Familia');
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': ' Bearer ${preferences.token}'};

      final resp = await http.get(
        url,
        headers: headers,
        /* body: jsonEncode({
          'userName': '$user',
          'password': '$pass',
        }), */
      );

      print('FamiliasApi');

      if (resp.statusCode == 401) {
        ApiModel apiModel = ApiModel();
        apiModel.error = true;
        apiModel.resultadoPeticion = false;
        apiModel.mensaje = 'token inválido';

        return apiModel;
      }
      final decodedData = json.decode(resp.body);

      if (decodedData.length > 0) {
        for (var i = 0; i < decodedData.length; i++) {
          FamiliasModel familiasModel = FamiliasModel();
          familiasModel.idFamiliaLocal = '${decodedData[i]['idFamilia'].toString()}$idLocacion';
          familiasModel.idFamilia = decodedData[i]['idFamilia'].toString();
          familiasModel.nombre = decodedData[i]['nombre'].toString();
          familiasModel.idLocacion = idLocacion;
          familiasModel.color = decodedData[i]['color'].toString();

          await familiasDatabase.insertarFamilias(familiasModel);
        }
      }

      ApiModel apiModel = ApiModel();
      apiModel.error = false;
      apiModel.resultadoPeticion = true;
      apiModel.mensaje = 'operación exitosa';

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
