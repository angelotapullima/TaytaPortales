import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tayta_restaurant/src/database/pedido_user_database.dart';
import 'package:tayta_restaurant/src/models/pedido_user.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/utils/constants.dart';

class PedidosUserApi {
  Future<bool> obtenerPedidosPorUsuario() async {
    final preferences = Preferences();

    final pedidosUserDatabase = PedidosUserDatabase();
    try {
      final url = Uri.parse('$apiBaseURL/api/User/GetProductsByUser');
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': ' Bearer ${preferences.token}'};

      final resp = await http.get(
        url,
        headers: headers,
        /* body: jsonEncode({
          'userName': '$user',
          'password': '$pass',
        }), */
      );

      print('user api');
      final decodedData = json.decode(resp.body);

      if (decodedData.length > 0) {
        for (var i = 0; i < decodedData.length; i++) {
          PedidosUserModel pedidosUserModel = PedidosUserModel();
          pedidosUserModel.idPedido = decodedData[i]['id'].toString();
          pedidosUserModel.mesaId = decodedData[i]['mesaId'].toString();
          pedidosUserModel.cantidadPersonas = decodedData[i]['cantidadPersonas'].toString();
          pedidosUserModel.horaIngreso = decodedData[i]['horaIngreso'].toString();
          pedidosUserModel.mesa = decodedData[i]['mesa'].toString();
          pedidosUserModel.total = decodedData[i]['total'].toString();
          pedidosUserModel.estado = decodedData[i]['estado'].toString();
          pedidosUserModel.paraLlevar = decodedData[i]['paraLlevar'].toString();
          pedidosUserModel.idUsuario = decodedData[i]['idUsuario'].toString();
          pedidosUserModel.codigoUsuario = decodedData[i]['codigoUsuario'].toString();

          final horaSinFormato = decodedData[i]['horaIngreso'].toString().split('T');
          final dia = horaSinFormato[0].trim();

          pedidosUserModel.dia = dia;

          await pedidosUserDatabase.insertarPedidosPorUsuario(pedidosUserModel);
        }
      }

      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      return false;
    }
  }
}
