import 'dart:async';

import 'package:emptio/core/app_colors.dart';
import 'package:emptio/data/database.dart';
import 'package:emptio/helpers/location.dart';
import 'package:emptio/services/local_notification_service.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/stores/connectivity.store.dart';
import 'package:emptio/stores/environment.store.dart';
import 'package:emptio/views/entry/entry.view.dart';
import 'package:emptio/views/home/home.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:emptio/theme.dart';
import 'package:emptio/views/splash/splash.view.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  // * Handle messages when app is closed on background
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  await Database.init();
  setupStores();

  await initEnvironment();

  runApp(MyApp());
}

void setupStores() {
  GetIt.I.registerSingleton(EnvironmentStore());
  GetIt.I.registerSingleton(ConnectivityStore());
  GetIt.I.registerSingleton(AuthStore());
  GetIt.I.registerSingleton(AppStore());
}

Future<void> initEnvironment() async {
  final remoteConfig = RemoteConfig.instance;

  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: Duration(seconds: 10),
    minimumFetchInterval: Duration(minutes: 1),
  ));

  await remoteConfig.setDefaults(<String, dynamic>{
    'api_url': '192.168.0.194:3000',
    "google_places_key": "",
  });

  await remoteConfig.fetchAndActivate();

  final apiUrl = RemoteConfig.instance.getString("api_url");
  final googlePlacesKey = RemoteConfig.instance.getString("google_places_key");

  final _envStore = GetIt.I<EnvironmentStore>();
  _envStore.setApiUrl(apiUrl);
  _envStore.setGooglePlacesKey(googlePlacesKey);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EnterPoint();
  }
}

class EnterPoint extends StatefulWidget {
  const EnterPoint({Key? key}) : super(key: key);

  @override
  _EnterPointState createState() => _EnterPointState();
}

class _EnterPointState extends State<EnterPoint> {
  final AuthStore _authStore = GetIt.I<AuthStore>();
  final AppStore _appStore = GetIt.I<AppStore>();
  final ConnectivityStore _connectivityStore = GetIt.I<ConnectivityStore>();

  ReactionDisposer? _disposer;
  ReactionDisposer? _authDisposer;

  Timer? _timerDisposer;

  @override
  void initState() {
    super.initState();

    _disposer = reaction(
      (_) => _connectivityStore.isConnected,
      (bool connected) {
        if (_authStore.isActive) {
          if (connected) {
            _authStore.initAuthenticated();
          } else {
            _appStore.homeStore.changeTab(0);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                !connected
                    ? 'Sem conexão com a internet!'
                    : 'Conectado à internet!',
              ),
              backgroundColor: AppColors.darkGrey,
              duration: Duration(seconds: 5),
            ),
          );

          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
    );

    _authDisposer = reaction((_) => _authStore.isLogged, (bool isLogged) {
      if (isLogged) {
        _timerDisposer = Timer.periodic(
            Duration(seconds: 30), (_) => _authStore.updateLoggedUser());
      } else {
        _timerDisposer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    if (_disposer != null) {
      _disposer!();
    }

    if (_authDisposer != null) {
      _authDisposer!();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emptio',
      theme: appTheme(),
      home: FutureBuilder(
        future: _init(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData) {
            return SplashView();
          }

          if (snapshot.data! ||
              !_connectivityStore.isConnected ||
              _authStore.keepLoggedOut) {
            return HomeView();
          }

          return EntryView();
        },
      ),
    );
  }

  Future<bool> _init() async {
    try {
      await initFirebase();
      await requestPermissions();
      await requestLocation();
      final bool authenticated = await validateAuth();
      return Future.value(authenticated);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<void> initFirebase() async {
    LocalNotificationService.initialize();

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      // * Handle messages when app was closed and notification clicked
    });

    FirebaseMessaging.onMessage.listen((message) {
      // * Handle messages when app is on foreground
      if (message.notification != null) {
        LocalNotificationService.display(message);
      }

      _authStore.updateLoggedUser();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // * Handle messages when app is opened on background
    });
  }

  Future<bool> validateAuth() async {
    final bool authenticated = await _authStore.initAuthenticated();
    return Future.value(authenticated);
  }

  Future<bool> requestPermissions() async {
    if (await Permission.camera.request().isGranted) {

      return true;
    }

    return openAppSettings();
  }
}
