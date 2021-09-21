import 'package:flutter/material.dart'; 
import 'package:tayta_restaurant/src/preferences/prefs_url.dart'; 

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Offset offset = const Offset(5, 5);

    final preferences =PreferencesUrl();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: offset,
            blurRadius: 10.0,
            color: Color(0x26234395),
          ),
          BoxShadow(
            offset: Offset(-offset.dx, -offset.dx),
            blurRadius: 20.0,
            color: Colors.grey.withOpacity(.5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text('URl Base'),
          Text('${preferences.url}'),
        ],
      ),
    );
  }
}
