import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayta_restaurant/src/database/carrito_database.dart';
import 'package:tayta_restaurant/src/database/familias_database.dart';
import 'package:tayta_restaurant/src/database/locacion_database.dart';
import 'package:tayta_restaurant/src/database/mesas_database.dart';
import 'package:tayta_restaurant/src/database/pedido_user_database.dart';
import 'package:tayta_restaurant/src/database/productos_database.dart';
import 'package:tayta_restaurant/src/models/pedido_user.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';

class Logout extends StatelessWidget {
  const Logout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preferences = Preferences();
    return Material(
      color: Colors.black.withOpacity(.5),
      child: Stack(
        fit: StackFit.expand,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(250),
              horizontal: ScreenUtil().setWidth(300),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(50),
                ),
                Text(
                  'Desea Cerrar Sesión?',
                  style: TextStyle(fontSize: ScreenUtil().setSp(20)),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: ScreenUtil().setWidth(150),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text('No'),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(100),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(150),
                      child: MaterialButton(
                        onPressed: () async {
                          preferences.clearPreferences();

                          final carritoDatabase = CarritoDatabase();
                          final familiasDatabase = FamiliasDatabase();
                          final locacionDatabase = LocacionDatabase();
                          final mesasDatabase = MesasDatabase();
                          final pedidosUserDatabase = PedidosUserDatabase();
                          final productosDatabase = ProductosDatabase();

                          await carritoDatabase.eliminarTablaCarritoMesa();
                          await familiasDatabase.eliminarTablaFamilias()();
                          await locacionDatabase.eliminarTablaLocacion();
                          await mesasDatabase.eliminarTablaMesas();
                          await pedidosUserDatabase.eliminarTablaPedidoUser();
                          await productosDatabase.eliminarTablaProductos();

                          Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => true);
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text('Si'),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
