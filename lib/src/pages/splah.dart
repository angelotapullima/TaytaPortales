import 'package:flutter/material.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/utils/constants.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /* final tiendadBloc = ProviderBloc.tiendas(context);
      tiendadBloc.obtenerTiendas(); */

      final preferences = Preferences();

      if (preferences.url == null || preferences.url.isEmpty || preferences.url == '') {
        preferences.url = "$apiBaseURL";
      }

      
      if (preferences.token == null || preferences.token.isEmpty) {
        Navigator.pushNamed(context, 'login');
      } else {
        Navigator.pushNamed(context, 'home');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
