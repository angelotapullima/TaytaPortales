import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUrl {
  static final PreferencesUrl _instancia = new PreferencesUrl._internal();

  factory PreferencesUrl() {
    return _instancia;
  }

  SharedPreferences _prefs;

  PreferencesUrl._internal();

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  clearPreferences() async {
    await _prefs.clear();
  }

/////////////////////////////////////////////////////////
  get url {
    return _prefs.getString('url');
  }

  set url(String value) {
    _prefs.setString('url', value);
  }

}
