import 'package:flutter/material.dart';
import 'package:invi/homepage/home_page.dart';
import 'package:invi/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:go_router/go_router.dart';
import 'package:invi/helpers/routes_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:invi/newproduct/newproduct_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAIlcYxLd1DEN2eZxjQcNfSQh2sy76Xc_E",
      authDomain: "inventario-sanjose.firebaseapp.com",
      projectId: "inventario-sanjose",
      storageBucket: "inventario-sanjose.appspot.com",
      messagingSenderId: "820908726224",
      appId: "1:820908726224:web:38ac3e35ed8a43c4b18bd5",
      measurementId: "G-99HEHCHJ03"),
  );

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Inventario San Jose',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      routerConfig: GoRouter(routes: <RouteBase>[
        GoRoute(
          path: RoutesConstants.login,
          builder: (context, state) => LoginPage(),
          routes: <RouteBase>[
            GoRoute(
              path: RoutesConstants.homepage,
              builder: (context, state) => HomePage(),
            ),
            GoRoute(
              path: RoutesConstants.newproduct,
              builder: (context, state) => NewProductPage(),
            ),
          ]),
      ]),
    );
  }
}