import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/database/carrito_database.dart';
import 'package:tayta_restaurant/src/models/carrtito_model.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/models/productos_model.dart';
import 'package:tayta_restaurant/src/utils/circle.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class AgregarProductTablet extends StatefulWidget {
  const AgregarProductTablet({
    Key key,
    @required this.productos,
    @required this.mesas,
  }) : super(key: key);

  final ProductosModel productos;
  final MesasModel mesas;

  @override
  _AgregarProductTabletState createState() => _AgregarProductTabletState();
}

class _AgregarProductTabletState extends State<AgregarProductTablet> {
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
                          '${widget.productos.nombreProducto}',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'S/.${dosDecimales(
                            double.parse(widget.productos.precioVenta),
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
                              fontSize: ScreenUtil().setSp(22),),
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
                              carrito.idProducto = widget.productos.idProducto;
                              carrito.nombreProducto = widget.productos.nombreProducto;
                              carrito.precioVenta = widget.productos.precioVenta;
                              carrito.precioLlevar = widget.productos.precioLlevar;
                              carrito.cantidad = _counter.toString();
                              carrito.observacion = observacionController.text;
                              carrito.idMesa = widget.mesas.idMesa;
                              carrito.nombreMesa = widget.mesas.nombreCompleto;
                              carrito.idLocacion = widget.mesas.locacionId;
                              carrito.estado = '0';
                              carrito.nroCuenta = '1';
                              //estado  == 0 -> enviado
                              //estado  == 1 -> preparado
                              carrito.paraLLevar = (val) ? '1' : '0';

                              //llevar = true -> ==== 1  producto para llevar
                              //llevar = false -> ==== 0  producto para local

                              await carritoDatabase.insertarCarito(carrito);

                              final mesasBloc = ProviderBloc.mesas(context);
                              mesasBloc.obtenerMesasPorId(widget.mesas.idMesa);

                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(8),
                            ),
                            child: Text(
                              'Añadir pedido',
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
