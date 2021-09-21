import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tayta_restaurant/src/bloc/login_bloc.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/tienda_model.dart';
import 'package:tayta_restaurant/src/pages/tablet/config.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  {
  final _cargando = ValueNotifier<bool>(false);

  int cantItems = 0;
  String dropdownTienda = '';
  String codTienda = ""; 
 

  @override
  Widget build(BuildContext context) {
  
    final responsive = Responsive.of(context);
    final loginBloc = ProviderBloc.login(context);

    final tiendasBloc = ProviderBloc.tiendas(context);

    final pedidoUsuarioBloc =ProviderBloc.pedidoUser(context);

    if (cantItems == 0) {
      tiendasBloc.obtenerTiendas();
    }

    final prefsUrl = Preferences();
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _cargando,
        builder: (BuildContext context, bool dataToque, Widget child) {
          return Stack(
            children: [
              _form(context, responsive, loginBloc),
              (dataToque)
                  ? Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: responsive.wp(10)),
                        padding: EdgeInsets.symmetric(horizontal: responsive.wp(10)),
                        width: double.infinity,
                        height: responsive.hp(50),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: responsive.wp(10), vertical: responsive.wp(6)),
                              height: responsive.ip(4),
                              width: responsive.ip(4),
                              child: CircularProgressIndicator(),
                            ),
                            Text(
                              'Cargando',
                              style: TextStyle(
                                fontSize: responsive.ip(2),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
              Positioned(
                top: ScreenUtil().setHeight(20),
                right: ScreenUtil().setWidth(20),
                child: SafeArea(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return ConfigPageLogin();
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(
                              CurveTween(curve: curve),
                            );

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );

                      //ConfigPage
                    },
                    child: Container(
                      height: ScreenUtil().setHeight(50),
                      width: ScreenUtil().setHeight(50),
                      child: SvgPicture.asset(
                        'assets/settings_blue.svg',
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: pedidoUsuarioBloc.pedidosUserStream,
                builder: (context, snapshot) {
                  return Positioned(
                    top: ScreenUtil().setHeight(20),
                    left: ScreenUtil().setWidth(20),
                    child: SafeArea(
                      child: InkWell(
                        onTap: () {
                          //ConfigPage
                        },
                        child: Text('url = ${prefsUrl.url}'),
                      ),
                    ),
                  );
                }
              )
            ],
          );
        },
      ),
    );
  }

  var list;
  var listTiendas;

  Widget _tiendas(BuildContext context, Responsive responsive) {
    final tiendasBloc = ProviderBloc.tiendas(context);
    return StreamBuilder(
      stream: tiendasBloc.tiendasStream,
      builder: (BuildContext context, AsyncSnapshot<List<TiendaModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            if (cantItems == 0) {
              listTiendas = List<String>();

              listTiendas.add('Seleccionar Tienda');
              for (int i = 0; i < snapshot.data.length; i++) {
                String nombreSedes = snapshot.data[i].tienda;
                listTiendas.add(nombreSedes);
              }
              dropdownTienda = "Seleccionar Tienda";
            }
            return Padding(
              padding: EdgeInsets.only(
                bottom: responsive.hp(2),
                left: responsive.wp(6),
                right: responsive.wp(6),
              ),
              child: _tiendasItem(responsive, snapshot.data, listTiendas),
            );
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  Widget _tiendasItem(Responsive responsive, List<TiendaModel> sedes, List<String> canche) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.wp(4),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        //border: Border.all(color: Colors.blue[300]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: dropdownTienda,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(16),
        ),
        underline: Container(),
        onChanged: (String data) {
          setState(() {
            dropdownTienda = data;
            cantItems++;

            obtenerIdTienda(data, sedes);
          });
        },
        items: canche.map(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                maxLines: 2,
                style: TextStyle(color: Colors.blue[900], fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  void obtenerIdTienda(String dato, List<TiendaModel> list) {
    if (dato == "Seleccionar Tienda") {
      codTienda = '';
    } else {
      for (int i = 0; i < list.length; i++) {
        if (dato == list[i].tienda) {
          codTienda = list[i].idTienda;
          print('$codTienda ${list[i].tienda}');
        }
      }
    }
  }

  Widget _form(BuildContext context, Responsive responsive, LoginBloc loginBloc) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              FlutterLogo(
                size: ScreenUtil().setHeight(150),
              ),
              Text(
                "Bienvenido",
                style: TextStyle(fontSize: ScreenUtil().setSp(50), fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(10),
                ),
                child: Text(
                  "Inicie Sesión",
                  style: TextStyle(fontSize: ScreenUtil().setSp(24)),
                ),
              ),
              _user(loginBloc, responsive),
              _pass(loginBloc, responsive),
              _tiendas(context, responsive),
              _botonLogin(context, loginBloc, responsive),
            ],
          ),
        ),
      ),
    );
  }

  Widget _user(LoginBloc bloc, Responsive responsive) {
    return StreamBuilder(
      stream: bloc.usuarioStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: ScreenUtil().setHeight(20),
            left: responsive.wp(6),
            right: responsive.wp(6),
          ),
          child: TextField(
            textAlign: TextAlign.left,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: Theme.of(context).dividerColor,
              hintText: 'Ingrese su usuario',
              hintStyle: TextStyle(
                fontSize: ScreenUtil().setSp(16),
                color: Colors.black54,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              contentPadding: EdgeInsets.all(
                responsive.ip(2),
              ),
              errorText: snapshot.error,
              suffixIcon: Icon(
                Icons.person,
                color: Color(0xFFF93963),
              ),
            ),
            onChanged: bloc.changeUsuario,
          ),
        );
      },
    );
  }

  Widget _pass(LoginBloc bloc, Responsive responsive) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: responsive.hp(2),
            left: responsive.wp(6),
            right: responsive.wp(6),
          ),
          child: TextField(
            obscureText: true,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: Theme.of(context).dividerColor,
              hintText: 'Ingrese su contraseña',
              hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16), fontFamily: 'Montserrat', color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              contentPadding: EdgeInsets.all(
                responsive.ip(2),
              ),
              errorText: snapshot.error,
              suffixIcon: Icon(
                Icons.lock_outline,
                color: Color(0xFFF93963),
              ),
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _botonLogin(BuildContext context, LoginBloc bloc, Responsive responsive) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Padding(
            padding: EdgeInsets.only(
              top: responsive.hp(2),
              left: responsive.wp(6),
              right: responsive.wp(6),
            ),
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (snapshot.hasData) ? () => _submit(context, bloc) : null,
                  child: Text('Iniciar Sesión'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.all(0.0),
                    primary: Color(0xFFF93963),
                    onPrimary: Colors.white,
                  ),
                )

                // RaisedButton(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30.0),
                //   ),
                //   padding: EdgeInsets.all(0.0),
                //   child: Text('Iniciar Sesión'),
                //   color: Color(0xFFF93963),
                //   textColor: Colors.white,
                //   onPressed:
                //       (snapshot.hasData) ? () => _submit(context, bloc) : null,
                // ),
                ),
          );
        });
  }

  _submit(BuildContext context, LoginBloc bloc) async {
    print(codTienda);

    if (codTienda.length > 0) {
      _cargando.value = true;
      final bool code = await bloc.login('${bloc.usuario}', '${bloc.password}');

      if (code) {
        final preferences = Preferences();
        preferences.tiendaId = codTienda;
        Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => true);

        // Navigator.pushReplacementNamed(context, 'home');
      } else {
        showToast2('Datos incorrectos', Colors.red);
      }

      _cargando.value = false;
    } else {
      showToast2('Seleccione tienda', Colors.black);
    }
  }
}
