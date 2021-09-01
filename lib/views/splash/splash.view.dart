import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Center(
        child: Hero(
          tag: 'emptio',
          child: SvgPicture.asset(
            AppAssets.svgLogo,
            width: MediaQuery.of(context).size.width * 0.35,
          ),
        ),
      ),
    );
  }
}
