import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:tayta_restaurant/src/preferences/preferences.dart';


class LoginApi {
  final prefs = new Preferences();

  Future<bool> login(String userName, String password) async {
    try {
      final url = Uri.parse('${prefs.url}/api/User/Login');

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final resp = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'userName': '$userName',
          'password': '$password',
        }),
      );


      print('LoginApi');

      final decodedData = json.decode(resp.body);

      prefs.token = decodedData['token'];
      prefs.idUsuario = decodedData['idUsuario'];
      prefs.nombresCompletos = decodedData['nombresCompletos'];
      prefs.codigoUsuario = decodedData['result']['codigoUsuario'];
      prefs.nombres = decodedData['result']['nombres'];
      prefs.apellidoPaterno = decodedData['result']['apellidoPaterno'];
      prefs.apellidoMaterno = decodedData['result']['apellidoMaterno'];

      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      return false;
    }
  }
}
