



import 'package:rxdart/rxdart.dart';
import 'package:tayta_restaurant/src/api/login_api.dart';

class LoginBloc {

  final loginApi =  LoginApi();

  final _usuarioController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _cargandoLoginController  = new BehaviorSubject<bool>();
  


  //Recuperaer los datos del Stream
  Stream<String> get usuarioStream => _usuarioController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<bool> get cargando => _cargandoLoginController.stream;

  Stream<bool> get formValidStream => 
      Rx.combineLatest2(usuarioStream,passwordStream,(e,p)=> true);


  //inserta valores al Stream
  Function(String) get changeUsuario => _usuarioController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(bool) get changeCargando => _cargandoLoginController.sink.add;


  //obtener el ultimo valor ingresado a los stream
  String get usuario => _usuarioController.value;
  String get password => _passwordController.value;

  dispose(){
    _usuarioController?.close();
    _passwordController?.close();
    _cargandoLoginController?.close();
  }
  void cargandoFalse(){
    _cargandoLoginController.sink.add(false);
  }

  Future<bool> login(String user,String pass)async{

    _cargandoLoginController.sink.add(true);
    final resp = await loginApi.login(user, pass);
    _cargandoLoginController.sink.add(false);

    return resp;

  }
}