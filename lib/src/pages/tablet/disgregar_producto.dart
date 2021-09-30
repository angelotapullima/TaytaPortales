import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tayta_restaurant/src/api/comanda_api.dart';
import 'package:tayta_restaurant/src/api/mesas_api.dart';
import 'package:tayta_restaurant/src/bloc/index_bloc.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/database/carrito_database.dart';
import 'package:tayta_restaurant/src/models/carrtito_model.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';
import 'package:tayta_restaurant/src/utils/utils.dart';

class DisgregarProductoTablet extends StatefulWidget {
  const DisgregarProductoTablet({
    Key key,
    @required this.carrito,
    @required this.mesas,
  }) : super(key: key);

  final CarritoModel carrito;
  final MesasModel mesas;

  @override
  _DisgregarProductoTabletState createState() => _DisgregarProductoTabletState();
}

class _DisgregarProductoTabletState extends State<DisgregarProductoTablet> {
  TextEditingController nroCuentaController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();

  @override
  void dispose() {
    nroCuentaController.dispose();
    cantidadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IndexBlocListener>(context, listen: false);

    final responsive = Responsive.of(context);
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
                      width: ScreenUtil().setWidth(60),
                    ),
                    (double.parse('${widget.carrito.cantidad}').toInt() > 2)
                        ? Text(
                            '${double.parse('${widget.carrito.cantidad}').toInt()} productos por disgregar',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            '${double.parse('${widget.carrito.cantidad}').toInt()} producto por disgregar',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
                        'Cantidad',
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
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                      ),
                      child: TextField(
                        cursorColor: Colors.transparent,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(22),
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: ScreenUtil().setSp(22),
                            ),
                            hintText: 'Cantidad'),
                        enableInteractiveSelection: false,
                        controller: cantidadController,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(180),
                      ),
                      //padding: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
                      child: Text(
                        'Nro. Cuenta',
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
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                      ),
                      child: TextField(
                        cursorColor: Colors.transparent,
                        maxLines: 1,
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
                            hintText: 'Nro. Cuenta'),
                        enableInteractiveSelection: false,
                        controller: nroCuentaController,
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
                              if (cantidadController.text.isNotEmpty) {
                                if (nroCuentaController.text.isNotEmpty) {
                                  if (double.parse(cantidadController.text).toInt() > double.parse(widget.carrito.cantidad).toInt()) {
                                    showToast2('La cantidad a disgregar no puede ser mayor a la cantidad del producto seleccionado', Colors.red);
                                  } else {
                                    if (double.parse(cantidadController.text).toInt() == double.parse(widget.carrito.cantidad).toInt()) {
                                      //solo editar número de cuenta
                                      provider.changeCargandoTrueDisgregacion();
                                      final carritoDatabase = CarritoDatabase();
                                      final comandaApi = ComandaApi();
                                      CarritoModel carrito = CarritoModel();
                                      carrito.idProducto = widget.carrito.idProducto;
                                      carrito.nombreProducto = widget.carrito.nombreProducto;
                                      carrito.precioVenta = widget.carrito.precioVenta;
                                      carrito.cantidad = widget.carrito.cantidad;
                                      carrito.nroCuenta = nroCuentaController.text;
                                      carrito.observacion = widget.carrito.observacion;
                                      carrito.paraLLevar = widget.carrito.paraLLevar;
                                      carrito.idMesa = widget.carrito.idMesa;
                                      carrito.nombreMesa = widget.carrito.nombreMesa;
                                      carrito.idLocacion = widget.carrito.idLocacion;
                                      carrito.idComandaDetalle = widget.carrito.idComandaDetalle;
                                      await carritoDatabase.updateCarritoPorIdComandaDetalle(carrito);

                                      final res = await comandaApi.enviarComanda(widget.carrito.idMesa, int.parse(widget.mesas.cantidadPersonas));

                                      if (res.resultadoPeticion) {
                                        showToast2('Se ha actualizado la cuenta', Colors.green);
                                      } else {
                                        showToast2('No se ha podido actualizar la cuenta', Colors.red);
                                      }

                                      final mesabloc = ProviderBloc.mesas(context);
                                      final mesasApi = MesasApi();
                                      await mesasApi.obtenerMesasPorLocacion(widget.mesas.locacionId,context);

                                      mesabloc.obtenerMesasPorIdAgregar(widget.carrito.idMesa);
                                      mesabloc.obtenerMesasPorIdDisgregar(widget.carrito.idMesa);

                                      provider.changeCargandoFalseDisgregacion();
                                      Navigator.pop(context);
                                    } else {
                                      //Crear dos productos con numero de cuenta diferentes
                                      provider.changeCargandoTrueDisgregacion();
                                      final carritoDatabase = CarritoDatabase();
                                      final comandaApi = ComandaApi();
                                      var cantidadRestada = double.parse(widget.carrito.cantidad).toInt() - double.parse(cantidadController.text).toInt();

                                      CarritoModel carrito = CarritoModel();
                                      carrito.idProducto = widget.carrito.idProducto;
                                      carrito.nombreProducto = widget.carrito.nombreProducto;
                                      carrito.precioVenta = widget.carrito.precioVenta;
                                      carrito.cantidad = cantidadRestada.toString();
                                      carrito.nroCuenta = widget.carrito.nroCuenta;
                                      carrito.observacion = widget.carrito.observacion;
                                      carrito.paraLLevar = widget.carrito.paraLLevar;
                                      carrito.idMesa = widget.carrito.idMesa;
                                      carrito.nombreMesa = widget.carrito.nombreMesa;
                                      carrito.idLocacion = widget.carrito.idLocacion;
                                      carrito.idComandaDetalle = widget.carrito.idComandaDetalle;
                                      await carritoDatabase.updateCarritoPorIdComandaDetalle(carrito);

                                      CarritoModel carrito2 = CarritoModel();
                                      carrito2.idProducto = widget.carrito.idProducto;
                                      carrito2.nombreProducto = widget.carrito.nombreProducto;
                                      carrito2.precioVenta = widget.carrito.precioVenta;
                                      carrito2.cantidad = cantidadController.text;
                                      carrito2.nroCuenta = nroCuentaController.text;
                                      carrito2.observacion = widget.carrito.observacion;
                                      carrito2.paraLLevar = widget.carrito.paraLLevar;
                                      carrito2.idMesa = widget.carrito.idMesa;
                                      carrito2.nombreMesa = widget.carrito.nombreMesa;
                                      carrito2.idLocacion = widget.carrito.idLocacion;
                                      carrito2.idComandaDetalle = '0';
                                      await carritoDatabase.insertarCarito(carrito2);

                                      final res = await comandaApi.enviarComanda(widget.carrito.idMesa, int.parse(widget.mesas.cantidadPersonas));

                                      if (res.resultadoPeticion) {
                                        showToast2('Se ha actualizado la cuenta', Colors.green);
                                      } else {
                                        showToast2('No se ha podido actualizar la cuenta', Colors.red);
                                      }

                                      final mesabloc = ProviderBloc.mesas(context);
                                      final mesasApi = MesasApi();
                                      await mesasApi.obtenerMesasPorLocacion(widget.mesas.locacionId,context);

                                      mesabloc.obtenerMesasPorIdAgregar(widget.carrito.idMesa);
                                      mesabloc.obtenerMesasPorIdDisgregar(widget.carrito.idMesa);

                                      provider.changeCargandoFalseDisgregacion();
                                      Navigator.pop(context);
                                    }
                                  }
                                } else {
                                  showToast2('Por favor ingrese él número de cuenta a mover', Colors.red);
                                }
                              } else {
                                showToast2('Por favor ingrese la cantidad a disgregar', Colors.red);
                              }
                              /*  final carritoDatabase = CarritoDatabase();
            
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
                             
                              carrito.nroCuenta = '1';
                              carrito.estado = '0';
                              carrito.idComandaDetalle = '0';
                              carrito.paraLLevar = (val) ? '1' : '0';
            
                              //llevar = true -> ==== 1  producto para llevar
                              //llevar = false -> ==== 0  producto para local
            
                              await carritoDatabase.insertarCarito(carrito);
            
                              final mesasBloc = ProviderBloc.mesas(context);
                              mesasBloc.obtenerMesasPorIdAgregar(widget.mesas.idMesa);
                              mesasBloc.obtenerMesasPorIdDisgregar(widget.mesas.idMesa);
            
                              Navigator.pop(context); */
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(8),
                            ),
                            child: Text(
                              'Aceptar cambios',
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
          ValueListenableBuilder(
              valueListenable: provider.cargandoDisgregacion,
              builder: (context, data, widget) {
                return (data)
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: responsive.wp(10)),
                          padding: EdgeInsets.symmetric(horizontal: responsive.wp(15)),
                          width: double.infinity,
                          height: responsive.hp(50),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: responsive.wp(10),
                                ),
                                height: responsive.ip(4),
                                width: responsive.ip(4),
                                child: CircularProgressIndicator(),
                              ),
                              SizedBox(
                                height: responsive.hp(4),
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
                    : Center(child: Container());
              })
        ],
      ),
    );
  }
}
