import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:tayta_restaurant/src/bloc/index_bloc.dart';
import 'package:tayta_restaurant/src/utils/constants.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';
import 'package:tayta_restaurant/src/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);


    final provider = Provider.of<IndexBlocListener>(context, listen: false);
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      child: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: provider.page,
          builder: (BuildContext context, EnumIndex data, Widget child) {
            return Column(
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
                SizedBox(height: kDefaultPadding * 2),
                // Menu Items
                SideMenuItem(
                  press: () {
                    provider.changeToMesa();},
                  title: "Mesas",
                  iconSrc: "assets/Icons/Inbox.svg",
                  isActive: (data == EnumIndex.mesas)?true:false,
                ),
                SideMenuItem(
                  press: () {},
                  title: "Pedidos",
                  iconSrc: "assets/Icons/Send.svg",
                  isActive: (data == EnumIndex.pedidos)?true:false,
                ),
                SideMenuItem(
                  press: () {
                    provider.changeToProductos();
                  },
                  title: "Productos",
                  iconSrc: "assets/Icons/File.svg",
                  isActive: (data == EnumIndex.productos)?true:false,
                ),
                Spacer(),
                SideMenuItem(
                  press: () {},
                  title: "Cerrar sesión",
                  iconSrc: "assets/Icons/Trash.svg",
                  isActive: false,
                  showBorder: (data == EnumIndex.mesas)?true:false,
                ),
        
                SizedBox(height: kDefaultPadding * 2),
                // Tags
                //Tags(),
              ],
            );
          }
        ),
      ),
    );
  }
}
