import 'package:flutter/material.dart';
import 'package:fotos/firebase_options.dart';
import 'package:fotos/pages/home_page.dart';
import 'package:fotos/pages/login_page.dart';
import 'package:fotos/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fotos/services/firebase_service.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GetIt.instance.registerSingleton<FirebaseService>(
    FirebaseService(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fotos',
        theme: ThemeData(primarySwatch: Colors.red),
        initialRoute: 'login',
        routes: {
          'register': (context) => RegisterPage(),
          'login': (context) => LoginPage(),
          'home': (context) => HomePage(),
        });
  }
}
