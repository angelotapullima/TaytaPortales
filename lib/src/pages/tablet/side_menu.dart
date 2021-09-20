import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tayta_restaurant/src/bloc/index_bloc.dart';
import 'package:tayta_restaurant/src/pages/tablet/logout.dart';
import 'package:tayta_restaurant/src/utils/constants.dart';
import 'package:tayta_restaurant/src/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IndexBlocListener>(context, listen: false);
    return Container(
      width: ScreenUtil().setWidth(83),
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      child: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: provider.page,
          builder: (BuildContext context, EnumIndex data, Widget child) {
            return Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(51),
                      color: Color(0xff3783f5),
                    ),
                    Container(
                      transform: Matrix4.translationValues(-ScreenUtil().setWidth(10), 0, 0),
                      width: ScreenUtil().setWidth(83) - ScreenUtil().setWidth(51),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ScreenUtil().setWidth(10)),
                            bottomLeft: Radius.circular(
                              ScreenUtil().setWidth(10),
                            ),
                          ),
                          color: Color(0xfff7f7f7)),
                    ),
                  ],
                ),
                Container(
                  width: ScreenUtil().setWidth(66),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          /* Image.network(
                            'https://www.supermercadolosportales.pe/wp-content/uploads/2020/05/los-portales.png',
                            width: responsive.wp(8),
                          ), */
                          Spacer(),
                          // We don't want to show this close button on Desktop mood
                          //if (!ResponsiveBuilder.isDesktop(context)) CloseButton(),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding),
                      Container(
                        height: ScreenUtil().setHeight(120),
                        child: Stack(
                          children: [
                            Center(
                              child: SideMenuItem(
                                press: () {
                                  provider.changeToMesa();
                                },
                                color: Colors.transparent,
                                title: "Mesas",
                                iconSrc: "assets/Icons/Inbox.svg",
                                isActive: (data == EnumIndex.mesas) ? true : false,
                              ),
                            ),
                            (data == EnumIndex.mesas || data == EnumIndex.familiaMesa)
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          transform: Matrix4.translationValues(-ScreenUtil().setWidth(10), 0, 0),
                                          child: CircleAvatar(
                                            backgroundColor: (data == EnumIndex.mesas || data == EnumIndex.familiaMesa) ? Color(0xff3783f5) : Colors.white,
                                            radius: ScreenUtil().setHeight(60),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Spacer(),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.white,
                                                      size: ScreenUtil().setWidth(15),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(120),
                        child: Stack(
                          children: [
                            Center(
                              child: SideMenuItem(
                                press: () {
                                  provider.changeToPedidos();},
                                color: Colors.transparent,
                                title: "Pedidos",
                                iconSrc: "assets/Icons/Send.svg",
                                isActive: (data == EnumIndex.pedidos) ? true : false,
                              ),
                            ),
                            (data == EnumIndex.pedidos)
                                ? Center(
                                    child: Container(
                                      transform: Matrix4.translationValues(-ScreenUtil().setWidth(10), 0, 0),
                                      child: CircleAvatar(
                                        backgroundColor: (data == EnumIndex.pedidos) ? Color(0xff3783f5) : Colors.white,
                                        radius: ScreenUtil().setWidth(40),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Spacer(),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                  size: ScreenUtil().setWidth(15),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(150),
                        child: Stack(
                          children: [
                            Center(
                              child: SideMenuItem(
                                press: () {
                                  provider.changeToProductos();
                                },
                                color: Colors.transparent,
                                title: "Productos",
                                iconSrc: "assets/Icons/File.svg",
                                isActive: (data == EnumIndex.productos) ? true : false,
                              ),
                            ),
                            (data == EnumIndex.productos)
                                ? Center(
                                    child: Container(
                                      transform: Matrix4.translationValues(-ScreenUtil().setWidth(10), 0, 0),
                                      child: CircleAvatar(
                                        backgroundColor: (data == EnumIndex.productos) ? Color(0xff3783f5) : Colors.white,
                                        radius: ScreenUtil().setWidth(40),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Spacer(),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                  size: ScreenUtil().setWidth(15),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      Spacer(),

                      SizedBox(height: kDefaultPadding * 2),
                      // Tags
                      //Tags(),
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(51),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          /* Image.network(
                            'https://www.supermercadolosportales.pe/wp-content/uploads/2020/05/los-portales.png',
                            width: responsive.wp(8),
                          ), */
                          Spacer(),
                          // We don't want to show this close button on Desktop mood
                          //if (!ResponsiveBuilder.isDesktop(context)) CloseButton(),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding),
                      // Menu Items
                      Container(
                        height: ScreenUtil().setHeight(120),
                        child: Center(
                          child: SideMenuItem(
                            press: () {
                              provider.changeToMesa();
                            },
                            color: Colors.white,
                            title: "Mesas",
                            iconSrc: "assets/Icons/Inbox.svg",
                            isActive: (data == EnumIndex.mesas) ? true : false,
                          ),
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(120),
                        child: SideMenuItem(
                          press: () {
                              provider.changeToPedidos();},
                          color: Colors.white,
                          title: "Pedidos",
                          iconSrc: "assets/Icons/Send.svg",
                          isActive: (data == EnumIndex.pedidos) ? true : false,
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(150),
                        child: SideMenuItem(
                          press: () {
                            provider.changeToProductos();
                          },
                          color: Colors.white,
                          title: "Productos",
                          iconSrc: "assets/Icons/File.svg",
                          isActive: (data == EnumIndex.productos) ? true : false,
                        ),
                      ),
                      Spacer(),
                      Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return Logout();
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
                  
                            //Logout
                          },
                          icon: Icon(Icons.logout_sharp, color: Colors.white),
                        ),
                      ),
                  
                      SizedBox(height: kDefaultPadding * 2),
                      // Tags
                      //Tags(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
