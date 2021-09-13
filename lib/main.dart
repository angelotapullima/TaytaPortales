import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tayta_restaurant/src/bloc/index_bloc.dart';
import 'package:tayta_restaurant/src/pages/home_page.dart';
import 'package:tayta_restaurant/src/pages/login.dart';
import 'package:tayta_restaurant/src/pages/splah.dart';
import 'package:tayta_restaurant/src/preferences/preferences.dart';

import 'src/bloc/provider.dart';

void main()async {


    WidgetsFlutterBinding.ensureInitialized();


    final prefs = new Preferences();

    await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderBloc(
      child: MultiProvider(
         providers: [
        ChangeNotifierProvider<IndexBlocListener>(
          create: (_) => IndexBlocListener(),
        ),
        
      ],
        child: ScreenUtilInit(
            designSize: Size(1024, 768),
            builder: () =>MaterialApp(
          builder: (BuildContext context, Widget child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(textScaleFactor: data.textScaleFactor > 2.0 ? 1.2 : data.textScaleFactor),
              child: child,
            );
          },
      
          theme: ThemeData(
                  primarySwatch: Colors.green,
                  scaffoldBackgroundColor: Color(0xFFF0F1F5),
                  canvasColor: Colors.transparent,
                  textTheme: GoogleFonts.poppinsTextTheme(),
                ),
          debugShowCheckedModeBanner: false,
          title: 'Tayta',
          initialRoute: 'splash',
          routes: {
            "splash": (BuildContext context) => Splash(),
            "home": (BuildContext context) => HomePage(),
            "login": (BuildContext context) => LoginPage(),
          },
        ),
      ),)
    );
  }
}
