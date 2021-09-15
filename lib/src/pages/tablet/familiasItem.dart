import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/familias_model.dart';
import 'package:tayta_restaurant/src/pages/categoriasProducto/categorias_productos_page.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';

class Familiasitem extends StatefulWidget {
  const Familiasitem({Key key}) : super(key: key);

  @override
  _FamiliasitemState createState() => _FamiliasitemState();
}

class _FamiliasitemState extends State<Familiasitem> {
  final _catController = CategoryController();
  @override
  Widget build(BuildContext context) {
    final familiasBloc = ProviderBloc.familias(context);

    final productosBloc = ProviderBloc.prod(context);
    final responsive = Responsive.of(context);
    Offset offset = const Offset(5, 5);
    return StreamBuilder(
      stream: familiasBloc.familiasStream,
      builder: (BuildContext context, AsyncSnapshot<List<FamiliasModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            productosBloc.obtenerProductosPorFamilia(snapshot.data[0].idFamilia, snapshot.data[0].idLocacion);

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
                  BoxShadow(offset: Offset(-offset.dx, -offset.dx), blurRadius: 20.0, color: Colors.grey.withOpacity(.5)),
                ],
              ),
              width: responsive.wp(20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(15),
                    ),
                    child: Text(
                      'Categorías',
                      style: TextStyle(
                        fontSize: responsive.ip(1.5),
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
                        return InkWell(
                          onTap: () {
                            _catController.changeIndex(index, snapshot.data[index].idFamilia);
                            productosBloc.obtenerProductosPorFamilia(snapshot.data[index].idFamilia, snapshot.data[index].idLocacion);
                          },
                          child: AnimatedBuilder(
                            animation: _catController,
                            builder: (_, s) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(24),
                                  vertical: ScreenUtil().setHeight(5),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(12),
                                ),
                                decoration: BoxDecoration(
                                  color: (_catController.index == index) ? color[200] : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: ScreenUtil().setHeight(74),
                                child: Row(
                                  children: [
                                    Container(
                                      width: ScreenUtil().setWidth(40),
                                      height: ScreenUtil().setWidth(40),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: color[700],
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(
                                          ScreenUtil().setWidth(8),
                                        ),
                                        height: ScreenUtil().setWidth(10),
                                        width: ScreenUtil().setWidth(10),
                                        child: SvgPicture.asset(
                                          'assets/flame.svg',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: responsive.wp(2),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${snapshot.data[index].nombre}',
                                        style: TextStyle(
                                          color: (_catController.index == index) ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        } else {
          return Center(child: CupertinoActivityIndicator());
        }
      },
    );
  }
}
