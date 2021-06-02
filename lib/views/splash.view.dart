import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(5, 38, 67, 1),
      body: Center(
        child: Hero(
          tag: 'emptio',
          child: SvgPicture.asset(
            'assets/svg/logo.svg',
            width: MediaQuery.of(context).size.width * 0.35,
          ),
        ),
      ),
    );
  }
}
