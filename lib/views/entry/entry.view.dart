import 'package:emptio/core/app_colors.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/stores/environment.store.dart';
import 'package:emptio/views/home/home.view.dart';
import 'package:emptio/views/login/login.view.dart';
import 'package:emptio/views/register/register.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'widgets/entry_header.widget.dart';

class EntryView extends StatelessWidget {
  final AuthStore _authStore = GetIt.I<AuthStore>();
  final EnvironmentStore _envStore = GetIt.I<EnvironmentStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EntryHeaderWidget(
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Observer(builder: (_) {
                        return Text(
                          _envStore.entryTitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                      SizedBox(height: 5),
                      Observer(builder: (_) {
                        return Text(
                          _envStore.entryDescription,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 75),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () => _onRegisterPressed(context),
                                style: OutlinedButton.styleFrom(
                                  primary: AppColors.orange,
                                  side: BorderSide(color: AppColors.orange),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                ),
                                child: Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () => _onLoginPressed(context),
                                style: OutlinedButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: AppColors.orange,
                                  side: BorderSide(
                                    color: AppColors.orange,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                ),
                                child: Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      TextButton(
                        onPressed: () => _onKeepLoggedOutPressed(context),
                        style: TextButton.styleFrom(
                          primary: AppColors.lightGrey,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Continuar sem cadastro'),
                            Icon(Icons.chevron_right_rounded),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onRegisterPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_ctx) => RegisterView(),
      ),
    );
  }

  void _onLoginPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_ctx) => LoginView(),
      ),
    );
  }

  void _onKeepLoggedOutPressed(BuildContext context) {
    _authStore.setKeepLoggedOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_ctx) => HomeView(),
      ),
      (route) => false,
    );
  }
}
