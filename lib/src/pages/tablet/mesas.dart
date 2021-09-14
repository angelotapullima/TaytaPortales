import 'package:flutter/material.dart';
import 'package:tayta_restaurant/src/bloc/provider.dart';
import 'package:tayta_restaurant/src/models/mesas_model.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';
import 'package:tayta_restaurant/src/utils/responsive.dart';

class MesasWidget extends StatelessWidget {
  const MesasWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();

    final locacionBloc = ProviderBloc.locacion(context);
    locacionBloc.obtenerLocacionesPorIdTienda(prefs.tiendaId);

    final mesabloc = ProviderBloc.mesas(context);

    final responsive = Responsive.of(context);

    Offset offset = const Offset(5, 5);

    return SafeArea(
      child: StreamBuilder(
         stream: mesabloc.mesasStream,
         builder: (BuildContext context, AsyncSnapshot<List<MesasModel>> mesas) {
           if (mesas.hasData) {
             if (mesas.data.length > 0) {
               return Container(
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20),
                   boxShadow: [
                     BoxShadow(
                       offset: offset,
                       blurRadius: 10.0,
                       color: Color(0x26234395),
                     ),
                     BoxShadow(
                       offset: Offset(-offset.dx, -offset.dx),
                       blurRadius: 10.0,
                       color: Colors.grey[300],
                     ),
                   ],
                 ),
                 child: GridView.builder(
                   padding: EdgeInsets.symmetric(
                     horizontal: responsive.wp(1),
                   ),
                   itemCount: mesas.data.length,
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 3,
                     childAspectRatio: 1,
                     mainAxisSpacing: responsive.hp(0),
                     crossAxisSpacing: responsive.wp(2),
                   ),
                   scrollDirection: Axis.vertical,
                   itemBuilder: (BuildContext context, int index) {
                     return LayoutBuilder(builder: (context, constraints) {
                       return InkWell(
                         onTap: () {
                           mesabloc.obtenerMesasPorId(mesas.data[index].idMesa);
                         },
                         child: Container(
                           //color: ('${mesas.data[index].idComanda}' == '0') ? Colors.red : Colors.blue,
                           width: constraints.maxWidth,
                           child: Row(
                             children: [
                               Container(
                                 width: constraints.maxWidth * 0.12,
                                 child: Padding(
                                   padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     children: [
                                       Container(
                                         decoration: BoxDecoration(
                                           color: (index % 2 == 0) ? Colors.blue : Color(0xffFFB400),
                                           borderRadius: BorderRadius.circular(5),
                                         ),
                                         height: constraints.maxHeight * 0.12,
                                         width: constraints.maxWidth * 0.2,
                                       ),
                                       Container(
                                         decoration: BoxDecoration(
                                           color: Colors.grey,
                                           borderRadius: BorderRadius.circular(5),
                                         ),
                                         height: constraints.maxHeight * 0.12,
                                         width: constraints.maxWidth * 0.2,
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                               SizedBox(
                                 width: responsive.wp(.5),
                               ),
                               Container(
                                 height: constraints.maxHeight * 0.6,
                                 width: constraints.maxWidth * 0.75 - responsive.wp(2),
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(5),
                                   gradient: LinearGradient(
                                     begin: Alignment.bottomLeft ,
                                     end: Alignment.topRight,
                                     colors: [
                                       Color(0xffFFB400).withOpacity(1),
                                       Color(0xffFFB400).withOpacity(.7),
                                     ],

                                     //
                                   ),
                                   boxShadow: [
                                    /*  BoxShadow(
                                       offset: offset,
                                       blurRadius: 40.0,
                                       color: Color(0xffFFB400).withOpacity(.5),
                                     ), */
                                     BoxShadow(offset: Offset(0 ,0), blurRadius: 20.0, color: Color(0xffFFB400).withOpacity(.5),),
                                   ], 
                                 ),
                                 child: Padding(
                                   padding: EdgeInsets.symmetric(
                                     horizontal: responsive.wp(1),
                                   ),
                                   child: Column(
                                     children: [
                                       Row(
                                         children: [
                                           Text(
                                             '${mesas.data[index].mesa}',
                                             style: TextStyle(
                                               fontSize: responsive.ip(1.7),
                                               color:Colors.white,
                                               fontWeight: FontWeight.bold,
                                             ),
                                           ),
                                           Spacer(),
                                         ],
                                       ),
                                       Spacer(),
                                       Row(
                                         children: [
                                           Icon(Icons.person,color: Colors.white,),
                                           Expanded(
                                             child: Text(
                                               '${mesas.data[index].idMesa}',
                                               style: TextStyle(
                                                 fontSize: responsive.ip(2),
                                               color:Colors.white,
                                                 fontWeight: FontWeight.bold,
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                               SizedBox(
                                 width: responsive.wp(.5),
                               ),
                               Container(
                                 width: constraints.maxWidth * 0.12,
                                 child: Padding(
                                   padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     children: [
                                       Container(
                                         decoration: BoxDecoration(
                                           color: (index % 2 == 0) ? Colors.blue : Color(0xffFFB400),
                                           borderRadius: BorderRadius.circular(5),
                                         ),
                                         height: constraints.maxHeight * 0.12,
                                         width: constraints.maxWidth * 0.2,
                                       ),
                                       Container(
                                         decoration: BoxDecoration(
                                           color: Colors.grey,
                                           borderRadius: BorderRadius.circular(5),
                                         ),
                                         height: constraints.maxHeight * 0.12,
                                         width: constraints.maxWidth * 0.2,
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       );
                     });
                   },
                 ),
               );
             } else {
               return CircularProgressIndicator();
             }
           } else {
             return CircularProgressIndicator();
           }
         },
       ),
    );
  }
}
