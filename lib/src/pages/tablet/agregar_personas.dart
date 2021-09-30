import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tayta_restaurant/src/api/comanda_api.dart';
import 'package:tayta_restaurant/src/bloc/index_bloc.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class AgregarPersonasTablet extends StatefulWidget {
  const AgregarPersonasTablet({
    Key key,
    @required this.mesa,
  }) : super(key: key);

  final MesasModel mesa;

  @override
  _AgregarPersonasTabletState createState() => _AgregarPersonasTabletState();
}

class _AgregarPersonasTabletState extends State<AgregarPersonasTablet> {
  TextEditingController cantidadController = TextEditingController();

  @override
  void dispose() {
    cantidadController.dispose();
    super.dispose();
  }

  @override
  void initState() {

    cantidadController.text = widget.mesa.cantidadPersonas.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IndexBlocListener>(context, listen: false);

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
            margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(100),
              horizontal: ScreenUtil().setWidth(100),
            ),
            height: ScreenUtil().setHeight(70),
            width: ScreenUtil().setWidth(70),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(10),
                      topStart: Radius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(10),
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Envio de pedido',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(180),
                  ),
                  //padding: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
                  child: Row(
                    children: [
                      Text(
                        'Ingrese la cantidad de personas en la mesa',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(180),
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
                      fontSize: ScreenUtil().setSp(15),
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: ScreenUtil().setSp(18),
                        ),
                        hintText: 'Ingresar Observaciones'),
                    enableInteractiveSelection: false,
                    controller: cantidadController,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                  width: ScreenUtil().setWidth(200),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Enviar pedidos'),
                    onPressed: () async {
                      if (cantidadController.text.isNotEmpty) {

                        Navigator.pop(context);
                        final comandaApi = ComandaApi();
                        provider.changeCargandoTrue();
                        final res = await comandaApi.enviarComanda(widget.mesa.idMesa, int.parse(cantidadController.text));
                        if (res.resultadoPeticion) {
                          showToast2('Pedido enviado correctamente', Colors.green);
                          provider.changeCargandoFalse();
                          provider.changeToMesa(context);
                        } else {
                          showToast2('Ocurrio un error, intentelo nuevamente', Colors.red);
                          provider.changeCargandoFalse();
                        }
                      }else{
                        showToast2('Ingrese la cantidad de personas', Colors.red);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
