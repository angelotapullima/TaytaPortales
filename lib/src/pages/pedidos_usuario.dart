import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/pedido_user.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';

class PedidosUsuario extends StatefulWidget {
  const PedidosUsuario({Key key}) : super(key: key);

  @override
  _PedidosUsuarioState createState() => _PedidosUsuarioState();
}

class _PedidosUsuarioState extends State<PedidosUsuario> {
  var fecha = '';

  @override
  void initState() {
    var now = DateTime.now();

    fecha = '${now.year.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final preferences = Preferences();

    final pedidosUserBloc = ProviderBloc.pedidoUser(context);
    pedidosUserBloc.obtenerPedidosPorUsuarioEnElDia(fecha);
    return StreamBuilder(
        stream: pedidosUserBloc.pedidosUserStream,
        builder: (context, AsyncSnapshot<List<PedidosUserModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Container(
                      padding: EdgeInsets.all(
                        ScreenUtil().setWidth(8),
                      ),
                      height: ScreenUtil().setWidth(150),
                      width: ScreenUtil().setWidth(150),
                      child: SvgPicture.asset(
                        'assets/userPicture.svg',
                      ),
                    ),
                    Text(
                      preferences.nombresCompletos,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Text(
                      'Historial de pedidos',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: ScreenUtil().setWidth(40),
                                      child: Text(
                                        'Mesa',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                        width: ScreenUtil().setWidth(100),
                                        child: Text(
                                          'Personas',
                                          textAlign: TextAlign.center,
                                        )),
                                    Container(
                                      width: ScreenUtil().setWidth(80),
                                      child: Text(
                                        'Monto',
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                                Divider()
                              ],
                            );
                          }

                          index = index - 1;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(40),
                                child: Text(
                                  '${snapshot.data[index].mesa}',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(100),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.person),
                                    Text('${snapshot.data[index].cantidadPersonas}'),
                                  ],
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(80),
                                child: Text(
                                  'S/.${snapshot.data[index].total}',
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('Aún no tiene pedidos hoy'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
