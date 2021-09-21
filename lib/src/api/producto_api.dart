



import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:tayta_restaurant/src/database/productos_database.dart';
import 'package:tayta_restaurant/src/models/api_model.dart';
import 'package:tayta_restaurant/src/models/productos_model.dart';

import 'package:tayta_restaurant/src/preferences/preferences.dart';

import 'package:tayta_restaurant/src/utils/constants.dart';

class ProductoApi {
  final productosDatabase = ProductosDatabase();
  final preferences = Preferences();
  Future<ApiModel> obtenerProductosPorFamilia(String idFamilia,String idLocacion) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Producto/$idFamilia/$idLocacion');
      Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': ' Bearer ${preferences.token}'};

      final resp = await http.get(
        url,
        headers: headers,
        /* body: jsonEncode({
          'userName': '$user',
          'password': '$pass',
        }), */
      );


      print('productos Familia');
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
          ProductosModel productosModel = ProductosModel();
          var id = '${decodedData[i]['idProducto'].toString()}$idLocacion';
          productosModel.idProductoLocal = id;
          productosModel.idProducto = decodedData[i]['idProducto'].toString();
          productosModel.nombreProducto = decodedData[i]['nombreProducto'].toString();
          productosModel.precioVenta = decodedData[i]['precioVenta'].toString();
          productosModel.precioLlevar = decodedData[i]['precioLlevar'].toString();
          productosModel.saldo = decodedData[i]['saldo'].toString();
          productosModel.idFamilia = idFamilia;
          productosModel.idLocacion = idLocacion;
          
          await productosDatabase.insertarProductos(productosModel);
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
