import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
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
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  'https://www.supermercadolosportales.pe/wp-content/uploads/2020/05/los-portales.png',
                  width: responsive.wp(8),
                ),
                Spacer(),
                // We don't want to show this close button on Desktop mood
                //if (!ResponsiveBuilder.isDesktop(context)) CloseButton(),
              ],
            ),
            SizedBox(height: kDefaultPadding),
            SizedBox(height: kDefaultPadding * 2),
            // Menu Items
            SideMenuItem(
              press: () {},
              title: "Mesas",showBorder: true,
              iconSrc: "assets/Icons/Inbox.svg",
              isActive: true,
            ),
            SideMenuItem(
              press: () {},
              title: "Pedidos",
              iconSrc: "assets/Icons/Send.svg",
              isActive: false,
            ),
            SideMenuItem(
              press: () {},
              title: "Productos",
              iconSrc: "assets/Icons/File.svg",
              isActive: false,
            ),
            Spacer(),
            SideMenuItem(
              press: () {},
              title: "Cerrar sesión",
              iconSrc: "assets/Icons/Trash.svg",
              isActive: false,
              showBorder: false,
            ),

            SizedBox(height: kDefaultPadding * 2),
            // Tags
            //Tags(),
          ],
        ),
      ),
    );
  }
}
