
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
  }) : super(key: key);

  final bool isActive,  showBorder;
  
  final String iconSrc, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {

    final responsive = Responsive.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: InkWell(
        onTap: press,
        child: Row(
          children: [
            /* (isActive || isHover)
                ? Icon(Icons.check_circle, color: kPrimaryColor)
                : SizedBox(width: 15), */
            SizedBox(width: kDefaultPadding / 4),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom:10,top:10, right: 10),
                decoration: showBorder
                    ? BoxDecoration(
                        border: Border.all(color: kPrimaryColor),borderRadius: BorderRadius.circular(10),
                      )
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: responsive.wp(1),),

                    Icon(Icons.people, color: (isActive) ? kPrimaryColor : kGrayColor,),
                    /* WebsafeSvg.asset(
                      iconSrc,
                      height: 20,
                      color: (isActive || isHover) ? kPrimaryColor : kGrayColor,
                    ), */
                    SizedBox(width: kDefaultPadding * 0.75),
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.button.copyWith(
                          fontSize: responsive.ip(1.2),fontWeight: FontWeight.bold,
                              color:
                                  (isActive ) ? kPrimaryColor : kGrayColor,
                            ),
                      ),
                    ),
                    //if (itemCount != null) CounterBadge(count: itemCount)
                  ],
                ),
              ),
            ),SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
