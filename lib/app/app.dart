import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'router.dart';
import '../utils/constants.dart';
import '../bindings/app_bindings.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  MaterialColor myCustomColor = MaterialColor(
    0xFF6200EE, // Valeur ARGB de votre couleur principale
    <int, Color>{
      50: Color(0xFFE8EAF6),
      100: Color(0xFFC5CAE9),
      200: Color(0xFF9FA8DA),
      300: Color(0xFF7986CB),
      400: Color(0xFF5C6BC0),
      500: Color(0xFF3F51B5), // Couleur principale
      600: Color(0xFF3949AB),
      700: Color(0xFF303F9F),
      800: Color(0xFF283593),
      900: Color(0xFF1A237E),
    },
  );
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: myCustomColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        scaffoldBackgroundColor: Colors.grey[50],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF6C63FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      initialBinding: AppBindings(),
      initialRoute: AppConstants.homeRoute,
      getPages: AppRouter.routes,
      defaultTransition: Transition.fade,
    );
  }
}
