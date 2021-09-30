import 'package:rxdart/rxdart.dart';

class ErrorApi {
  final _errorControllerMesasApi = BehaviorSubject<ErrorApiModel>();

  Stream<ErrorApiModel> get errorMesaStream => _errorControllerMesasApi.stream;

  dispose() {
    _errorControllerMesasApi?.close();
  }

  void respuestaApiMesas(bool respuestaApi, String mensaje) async {

    ErrorApiModel errorApiModel = ErrorApiModel();
    errorApiModel.respuestaApi = respuestaApi;
    errorApiModel.mensaje = mensaje;
    _errorControllerMesasApi.sink.add(errorApiModel);
  }
}

class ErrorApiModel {
  String mensaje;
  bool respuestaApi;
  ErrorApiModel({this.mensaje, this.respuestaApi});
}
