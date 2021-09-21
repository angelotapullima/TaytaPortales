import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayta_restaurant/src/api/tiendas_api.dart';
import 'package:tayta_restaurant/src/preferences/prefs_url.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key key}) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  TextEditingController urlController = TextEditingController();

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Offset offset = const Offset(5, 5);

    final preferences = PreferencesUrl();

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
      child: SafeArea(
        child: Column(
          children: [

            SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
            Text('URL Actual'),
                Text('${preferences.url}'),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                Text('Nueva Url'),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(300),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  width: double.infinity,
                  height: ScreenUtil().setHeight(40),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                  ),
                  child: TextField(
                    cursorColor: Colors.transparent,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(17),
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: ScreenUtil().setSp(17),
                        ),
                        hintText: 'Ingresar nueva Url'),
                    enableInteractiveSelection: false,
                    controller: urlController,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(300),
                  child: MaterialButton(
                    onPressed: () async {
                      if (urlController.text.isNotEmpty) {
                        preferences.url = 'https://${urlController.text}';
                        final tiendasApi = TiendaApi();
                         tiendasApi.obtenerTiendas();
      
                        Navigator.pop(context);
                      } else {
                        showToast2('Por favor ingrese la url', Colors.red);
                      }
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Guardar Cambios'),
                  ),
                )
              
          ],
        ),
      ),
    );
  }
}

class ConfigPageLogin extends StatefulWidget {
  const ConfigPageLogin({Key key}) : super(key: key);

  @override
  _ConfigPageLoginState createState() => _ConfigPageLoginState();
}

class _ConfigPageLoginState extends State<ConfigPageLogin> {
  TextEditingController urlController = TextEditingController();

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Offset offset = const Offset(5, 5);

    final preferences = PreferencesUrl();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
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
              Text('URL Actual'),
              Text('${preferences.url}'),
              SizedBox(
                height: ScreenUtil().setHeight(40),
              ),
              Text('Nueva Url'),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(300),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                ),
                width: double.infinity,
                height: ScreenUtil().setHeight(40),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                ),
                child: TextField(
                  cursorColor: Colors.transparent,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(17),
                  ),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: ScreenUtil().setSp(17),
                      ),
                      hintText: 'Ingresar nueva Url'),
                  enableInteractiveSelection: false,
                  controller: urlController,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(40),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(300),
                child: MaterialButton(
                  onPressed: () async {
                    if (urlController.text.isNotEmpty) {
                      preferences.url = 'https://${urlController.text}';
                      final tiendasApi = TiendaApi();
                       tiendasApi.obtenerTiendas();

                      Navigator.pop(context);
                    } else {
                      showToast2('Por favor ingrese la url', Colors.red);
                    }
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Guardar Cambios'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
