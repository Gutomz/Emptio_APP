import 'package:emptio/stores/auth.store.dart';
import 'package:flutter/material.dart';
import 'package:emptio/theme.dart';
import 'package:emptio/views/splash/splash.view.dart';
import 'package:get_it/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocators();
  runApp(MyApp());
}

void setupLocators() {
  GetIt.I.registerSingleton(AuthStore());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emptio',
      theme: appTheme(),
      home: SplashView(),
    );
  }
}
