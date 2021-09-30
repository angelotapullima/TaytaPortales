
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tayta_restaurant/src/api/comanda_api.dart';
import 'package:tayta_restaurant/src/api/mesas_api.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/database/carrito_database.dart';
import 'package:tayta_restaurant/src/models/carrtito_model.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/utils/circle.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class EditarProductoTablet extends StatefulWidget {
  const EditarProductoTablet({
    Key key,
    @required this.carrito,
    @required this.mesas,
  }) : super(key: key);

  final CarritoModel carrito;
  final MesasModel mesas;

  @override
  _EditarProductoTabletState createState() => _EditarProductoTabletState();
}

class _EditarProductoTabletState extends State<EditarProductoTablet> {
  TextEditingController observacionController = TextEditingController();
  int _counter = 1;

  @override
  void dispose() {
    observacionController.dispose();
    super.dispose();
  }

  bool val = false;
  void _increase() {
     setState(() {
      
        _counter++;
      
    });
  }

  void _decrease() {
    setState(() {
      _counter--;
    });
  }

  @override
  void initState() {
    observacionController.text = widget.carrito.observacion;
    val = (widget.carrito.paraLLevar == '1') ? true : false;
    _counter = double.parse(widget.carrito.cantidad).toInt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      'Producto',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: ScreenUtil().setWidth(80),
                        height: ScreenUtil().setWidth(80),
                        color: Color(0xffe5e5e5),
                        child: SvgPicture.asset(
                          'assets/platos.svg',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.carrito.nombreProducto}',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'S/.${dosDecimales(
                            double.parse(widget.carrito.precioVenta),
                          )}',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w600,
                            color: Color(0xff808080),
                          ),
                        ), 
                      ],
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(40),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(133),
                      height: ScreenUtil().setHeight(40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                if (_counter != 1) {
                                  _decrease();
                                }
                              },
                              child: CircleContainer(
                                radius: ScreenUtil().setHeight(20),
                                widget: CircleContainer(
                                  color: Colors.white,
                                  radius: ScreenUtil().setHeight(17),
                                  widget: Text(
                                    '-',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(22),
                                    ),
                                  ),
                                ),
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(20),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              transform: Matrix4.translationValues(0, 0, 0),
                              height: ScreenUtil().setHeight(40),
                              child: Text(
                                _counter.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(22),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(20),
                          ),
                          Flexible(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                _increase();
                              },
                              child: CircleContainer(
                                radius: ScreenUtil().setHeight(20),
                                color: Colors.blue,
                                widget: Icon(
                                  Icons.add,
                                  size: ScreenUtil().setSp(26),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ), 
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(180),
                      ),
                      //padding: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
                      child: Text(
                        'Observaciones',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(180),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(10),
                      ),
                      width: double.infinity,
                      height: ScreenUtil().setHeight(100),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                      ),
                      child: TextField(
                        cursorColor: Colors.transparent,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(22),
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: ScreenUtil().setSp(22),
                            ),
                            hintText: 'Ingresar Observaciones'),
                        enableInteractiveSelection: false,
                        controller: observacionController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(140),
                      ),
                      child: CheckboxListTile(
                        title: Row(
                          children: [
                            Text(
                              "Para Llevar",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(22),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(20),
                            ),
                            Container(
                              width: ScreenUtil().setWidth(25),
                              height: ScreenUtil().setWidth(25),
                              child: SvgPicture.asset(
                                'assets/delivery.svg',
                              ),
                            ),
                          ],
                        ),
                        value: val,
                        onChanged: (newValue) {
                          print(newValue);
                          setState(() {
                            val = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(180),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: ScreenUtil().setWidth(300),
                          child: MaterialButton(
                            onPressed: () async {
                              final carritoDatabase = CarritoDatabase();

                              CarritoModel carrito = CarritoModel();
                              carrito.idProducto = widget.carrito.idProducto;
                              carrito.nombreProducto = widget.carrito.nombreProducto;
                              carrito.precioVenta = widget.carrito.precioVenta;
                              carrito.cantidad = _counter.toString();
                              carrito.observacion = observacionController.text;
                              carrito.idMesa = widget.mesas.idMesa;
                              carrito.nombreMesa = widget.mesas.nombreCompleto;
                              carrito.idLocacion = widget.mesas.locacionId;

                              carrito.nroCuenta = '1';
                              carrito.estado = '0';
                              carrito.idComandaDetalle = widget.carrito.idComandaDetalle;
                              carrito.paraLLevar = (val) ? '1' : '0';
                              

                              await carritoDatabase.updateCarritoPorIdComandaDetalle(carrito);

                              final mesasBloc = ProviderBloc.mesas(context);
                              final comandaApi = ComandaApi();
                              final res = await comandaApi.enviarComanda(widget.mesas.idMesa,int.parse(widget.mesas.cantidadPersonas));
                              if (res.resultadoPeticion) {
                                showToast2('Pedido enviado correctamente', Colors.green);

                                final mesasApi = MesasApi();
                                              await mesasApi.obtenerMesasPorLocacion(widget.mesas.locacionId);
                                              
                              } else {
                                showToast2('Ocurrio un error, intentelo nuevamente', Colors.red);
                              }
 
                               mesasBloc.obtenerMesasPorIdAgregar(widget.mesas.idMesa);
                              mesasBloc.obtenerMesasPorIdDisgregar(widget.mesas.idMesa); 

                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(8),
                            ),
                            child: Text(
                              'Actualizar Pedido',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            textColor: Colors.white,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
