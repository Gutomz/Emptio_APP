import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/helpers/location.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/views/entry/entry.view.dart';
import 'package:emptio/views/home/home.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AuthStore _authStore = GetIt.I<AuthStore>();

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Center(
        child: SvgPicture.asset(
          AppAssets.svgLogo,
          width: MediaQuery.of(context).size.width * 0.35,
        ),
      ),
    );
  }

  Future _init() async {
    try {
      await Firebase.initializeApp();
      await requestLocation();
      await validateAuth();
    } catch (error) {
      return Future.error(error);
    }
  }

  Future validateAuth() async {
    bool authenticated = await _authStore.initAuthenticated();

    MaterialPageRoute route;

    if (authenticated) {
      route = MaterialPageRoute(builder: (ctx) => HomeView());
    } else {
      route = MaterialPageRoute(builder: (ctx) => EntryView());
    }

    Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
  }
}
