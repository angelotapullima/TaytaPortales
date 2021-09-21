import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUrl {
  static final PreferencesUrl _instancia = new PreferencesUrl._internal();

  factory PreferencesUrl() {
    return _instancia;
  }

  SharedPreferences _prefsURl;

  PreferencesUrl._internal();

  initPrefsUrl() async {
    this._prefsURl = await SharedPreferences.getInstance();
  }

  clearPreferencesUrl() async {
    await _prefsURl.clear();
  }

/////////////////////////////////////////////////////////
  get url {
    return _prefsURl.getString('url');
  }

  set url(String value) {
    _prefsURl.setString('url', value);
  }

}
