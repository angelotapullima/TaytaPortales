import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tayta_restaurant/src/database/tienda_database.dart';
import 'package:tayta_restaurant/src/models/tienda_model.dart';
import 'package:tayta_restaurant/src/preferences/prefs_url.dart';


class TiendaApi {
  final tiendasDatabase = TiendasDatabase();

  final preferencesUrl = PreferencesUrl();
  Future<bool> obtenerTiendas() async {
    try {
      final url = Uri.parse('${preferencesUrl.url}/api/Tienda');
      // var to = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3ByaW1hcnlzaWQiOiJiMDU3ZmViZS00ZTE2LTRkODktOTFhMy03OWQ4NTk0OTg4YWYiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiTWVzZXJhIFJlc3RhdXJhbnQgVGF5dGEiLCJuYmYiOjE2MzEwNDk5MjksImV4cCI6MTYzMTA3MTUyOSwiaXNzIjoiR3J1cG8gTWVyY2FkbyDCriIsImF1ZCI6IlNlcnZlcklJUyJ9.45IEr1-F4vYqg7J3DVu1CG95m8fZ09e6lhq6iupNtcQ';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      /* Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': ' Bearer $to'};

       */

      final resp = await http.get(
        url,
        headers: headers,
        /* body: jsonEncode({
          'userName': '$user',
          'password': '$pass',
        }), */
      );

      final decodedData = json.decode(resp.body);


      print('tienda Familia');


      if (decodedData.length > 0) {
        for (var i = 0; i < decodedData.length; i++) {
          TiendaModel tiendaModel = TiendaModel();
          tiendaModel.idTienda = decodedData[i]['tiendaId'].toString();
          tiendaModel.tienda = decodedData[i]['tienda'].toString();
          await tiendasDatabase.insertarTienda(tiendaModel);
        }
      }

      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      return false;
    }
  }
}
