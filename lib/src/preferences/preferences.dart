import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = new Preferences._internal();

  factory Preferences() { 
    return _instancia;
  }

  SharedPreferences _prefs;

  Preferences._internal();

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  clearPreferences() async {
    await _prefs.clear();
  }




/////////////////////////////////////////////////////////
  get locacionId {
    return _prefs.getString('locacionId');
  }

  set locacionId(String value) {
    _prefs.setString('locacionId', value);
  }

/////////////////////////////////////////////////////////
  get token {
    return _prefs.getString('token');
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

/////////////////////////////////////////////////////////
  get idUsuario {
    return _prefs.getString('idUsuario');
  }

  set idUsuario(String value) {
    _prefs.setString('idUsuario', value);
  }

/////////////////////////////////////////////////////////
  get nombresCompletos {
    return _prefs.getString('nombresCompletos');
  }

  set nombresCompletos(String value) {
    _prefs.setString('nombresCompletos', value);
  }

/////////////////////////////////////////////////////////
  get codigoUsuario {
    return _prefs.getString('codigoUsuario');
  }

  set codigoUsuario(String value) {
    _prefs.setString('codigoUsuario', value);
  }

/////////////////////////////////////////////////////////
  get nombres {
    return _prefs.getString('nombres');
  }

  set nombres(String value) {
    _prefs.setString('nombres', value);
  }

/////////////////////////////////////////////////////////
  get apellidoPaterno {
    return _prefs.getString('apellidoPaterno');
  }

  set apellidoPaterno(String value) {
    _prefs.setString('apellidoPaterno', value);
  }

/////////////////////////////////////////////////////////
  get apellidoMaterno {
    return _prefs.getString('apellidoMaterno');
  }

  set apellidoMaterno(String value) {
    _prefs.setString('apellidoMaterno', value);
  }




/////////////////////////////////////////////////////////
  get tiendaId {
    return _prefs.getString('tiendaId');
  }

  set tiendaId(String value) {
    _prefs.setString('tiendaId', value);
  }






/////////////////////////////////////////////////////////
  get url {
    return _prefs.getString('url');
  }

  set url(String value) {
    _prefs.setString('url', value);
  }



/////////////////////////////////////////////////////////
  get llamadaLocacion {
    return _prefs.getString('llamadaLocacion');
  }

  set llamadaLocacion(String value) {
    _prefs.setString('llamadaLocacion', value);
  }
}
