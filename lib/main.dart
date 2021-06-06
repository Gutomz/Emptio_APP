import 'package:emptio/core/app_colors.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/views/entry/entry.view.dart';
import 'package:emptio/views/splash/splash.view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocators();
  runApp(MyApp());
}

void setupLocators() {
  GetIt.I.registerSingleton(AuthStore());
}

class MyApp extends StatelessWidget {
  Future<bool> _init() async {
    try {
      await Firebase.initializeApp();
      await _initLocation();
      return Future.value(true);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future _initLocation() async {
    Location location = Location();

    var serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();

      if (!serviceEnabled) {
        return Future.error("location_service");
      }
    }

    var permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error('location_permission');
      }
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emptio',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        backgroundColor: AppColors.white,
        primaryColor: AppColors.blue,
        buttonColor: AppColors.orange,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.darkBlue,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.red,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.darkOrange;
              }

              return AppColors.orange;
            }),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.lightGrey;
              }

              return Colors.white;
            }),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.orange),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.red),
          ),
          errorStyle: TextStyle(color: AppColors.red),
        ),
      ),
      home: FutureBuilder(
        future: _init(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong');
          } else if (snapshot.hasData) {
            return EntryView();
          }

          return SplashView();
        },
      ),
    );
  }
}
