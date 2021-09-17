import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tayta_restaurant/src/database/familias_database.dart';
import 'package:tayta_restaurant/src/models/familias_model.dart';

import 'package:tayta_restaurant/src/preferences/preferences.dart';

import 'package:tayta_restaurant/src/utils/constants.dart';

class FamiliasApi {
  final familiasDatabase = FamiliasDatabase();
  final preferences = Preferences();
  Future<bool> obtenerFamilias(String idLocacion) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Familia');
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

      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      return false;
    }
  }
}
