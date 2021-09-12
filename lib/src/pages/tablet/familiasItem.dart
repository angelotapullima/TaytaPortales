import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return StreamBuilder(
      stream: familiasBloc.familiasStream,
      builder: (BuildContext context, AsyncSnapshot<List<FamiliasModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return Container(
              child: Container(
                width: responsive.wp(30),
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _catController.changeIndex(index, snapshot.data[index].idFamilia);
                          productosBloc.obtenerProductosPorFamilia(snapshot.data[index].idFamilia, snapshot.data[index].idLocacion);
                        },
                        child: AnimatedBuilder(
                            animation: _catController,
                            builder: (_, s) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: (_catController.index == index) ? Colors.red : Colors.transparent,
                                  border: Border.all(
                                    color: (_catController.index == index) ? Colors.red : Colors.grey,
                                  ),
                                ),
                                height: responsive.hp(8),
                                child: Center(
                                  child: Text(
                                    '${snapshot.data[index].nombre}',
                                    style: TextStyle(
                                      color: (_catController.index == index) ? Colors.white : Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }),
                      );
                    }),
              ),
            );
          } else {
            return CupertinoActivityIndicator();
          }
        } else {
          return CupertinoActivityIndicator();
        }
      },
    );
  }
}
