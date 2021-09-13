import 'package:flutter/material.dart';
import 'package:tayta_restaurant/src/utils/constants.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    Key key,
    this.isActive,
    this.showBorder = false,
    @required this.iconSrc,
    @required this.title,
    @required this.press,
    @required this.color,
  }) : super(key: key);

  final bool isActive, showBorder;
  final Color color;
  final String iconSrc, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return InkWell(
        onTap: press,
        child: RotatedBox(
          quarterTurns: 3,
          child: Container(
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: responsive.ip(1.2),
                      
                      fontWeight: FontWeight.bold,
                      color: color  ,
                    ),
              ),
            ),
          ),
        ));
  }
}
