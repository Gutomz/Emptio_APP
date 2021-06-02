import 'package:emptio/core/app_colors.dart';
import 'package:emptio/views/entry/entry.view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future<void> _init() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emptio',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        backgroundColor: AppColors.white,
        primaryColor: AppColors.orange,
        buttonColor: AppColors.orange,
      ),
      home: FutureBuilder(
        future: _init(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong');
          } else if (snapshot.hasData) {
            // TODO - Save data
          }

          return EntryView();
        },
      ),
    );
  }
}
