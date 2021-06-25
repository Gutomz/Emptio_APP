import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/helpers/location.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/stores/connectivity.store.dart';
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
  ConnectivityStore _connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: FutureBuilder(
          future: _init(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: Hero(
                  tag: 'emptio',
                  child: SvgPicture.asset(
                    AppAssets.svgLogo,
                    width: MediaQuery.of(context).size.width * 0.35,
                  ),
                ),
              );
            }

            if (snapshot.data! ||
                !_connectivityStore.isConnected ||
                _authStore.keepLoggedOut) {
              return HomeView();
            }

            return EntryView();
          }),
    );
  }

  Future<bool> _init() async {
    try {
      await Firebase.initializeApp();
      await requestLocation();
      bool authenticated = await validateAuth();
      return Future.value(authenticated);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future validateAuth() async {
    bool authenticated = await _authStore.initAuthenticated();
    return Future.value(authenticated);
  }
}
