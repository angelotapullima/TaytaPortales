import 'package:flutter/material.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/models/productos_model.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';

class AgregarAlCarrito extends StatefulWidget {
  const AgregarAlCarrito({Key key, @required this.productosModel, @required this.mesas}) : super(key: key);

  final ProductosModel productosModel;
  final MesasModel mesas;

  @override
  _AgregarAlCarritoState createState() => _AgregarAlCarritoState();
}

class _AgregarAlCarritoState extends State<AgregarAlCarrito> {
  int _counter = 1;

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
          /* Column(
            children: [
              Container(
                child: Lottie.asset('assets/lottie/pride.json'),
              ),
              Text(
                'Cesar Jose Roberto Ruiz De Melendez',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: responsive.ip(2),
                ),
              )
            ],
          ), */
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: MediaQuery.of(context).viewInsets,
              margin: EdgeInsets.only(top: responsive.hp(10)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: responsive.hp(1), horizontal: responsive.wp(4)),
                      child: Text(
                        widget.productosModel.nombreProducto,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.ip(2.8),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                      child: Row(
                        children: [
                          Text(
                            'Cantidad :',
                            style: TextStyle(
                              fontSize: responsive.ip(2.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: responsive.wp(30),
                              height: responsive.hp(5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(
                                    flex: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (_counter != 0) {
                                          _decrease();
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                          ),
                                        ),
                                        height: double.infinity,
                                        child: Center(
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: responsive.ip(2.1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      color: Colors.white,
                                      height: double.infinity,
                                      child: Center(
                                        child: Text(
                                          _counter.toString(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: responsive.ip(3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        _increase();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                        ),
                                        height: double.infinity,
                                        child: Center(
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: responsive.ip(2.1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsive.hp(3),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
                      child: Text(
                        'Observaciones',
                        style: TextStyle(fontSize: responsive.ip(2.5), fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                      ),
                      child: TextField(
                        cursorColor: Colors.transparent,
                        maxLines: 2,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.black45,
                            ),
                            hintText: 'Ingresar Observaciones'),
                        enableInteractiveSelection: false,
                        //controller: telefonoController,
                      ),
                    ),
                    CheckboxListTile(
                      title: Text("Para Llevar"),
                      value: val,
                      onChanged: (newValue) {
                        print(newValue);
                        setState(() {
                          val = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
                      child: Text(
                        'Nro de cuenta',
                        style: TextStyle(fontSize: responsive.ip(2.5), fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                      ),
                      child: TextField(
                        cursorColor: Colors.transparent,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.black45,
                            ),
                            hintText: 'Ingresar número de cuenta'),
                        enableInteractiveSelection: false,
                        //controller: telefonoController,
                      ),
                    ),
                    SizedBox(
                      height: responsive.hp(2),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(3),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'Agregar',
                            style: TextStyle(
                              fontSize: responsive.ip(2),
                            ),
                          ),
                          textColor: Colors.white,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: responsive.hp(10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
