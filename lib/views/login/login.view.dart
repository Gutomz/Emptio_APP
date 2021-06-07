import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/views/login/store/login.store.dart';
import 'package:emptio/views/redefine_password/redefine_password.view.dart';
import 'package:emptio/views/register/register.view.dart';
import 'package:emptio/views/splash/splash.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginStore loginStore = LoginStore();

  late ReactionDisposer errorDisposer;
  late ReactionDisposer loggedDisposer;
  late ReactionDisposer emailSentDisposer;

  @override
  initState() {
    super.initState();

    errorDisposer = reaction((_) => loginStore.error, (String error) {
      if (error.isNotEmpty) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
      }
    });

    loggedDisposer = reaction((_) => loginStore.logged, (bool logged) {
      if (logged) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => SplashView()),
            (route) => false);
      }
    });

    emailSentDisposer = reaction((_) => loginStore.emailSent, (bool emailSent) {
      if (emailSent) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => RedefinePasswordView(
              email: loginStore.email!,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    errorDisposer();
    loggedDisposer();
    emailSentDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50, right: 25, bottom: 15, left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'emptio',
                  child: SvgPicture.asset(
                    AppAssets.svgLogo,
                  ),
                ),
                SizedBox(height: 50),
                Observer(builder: (_) {
                  return TextField(
                    enabled: !loginStore.loading,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: AppColors.orange),
                      hintText: 'E-mail',
                      errorText: loginStore.emailError,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: loginStore.setEmail,
                  );
                }),
                SizedBox(height: 25),
                Observer(builder: (_) {
                  return TextField(
                    enabled: !loginStore.loading,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key, color: AppColors.orange),
                      suffixIcon: IconButton(
                        onPressed: loginStore.toggleVisible,
                        icon: Icon(
                          loginStore.visible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.grey,
                        ),
                        splashRadius: 2,
                      ),
                      hintText: 'Senha',
                      errorText: loginStore.passwordError,
                    ),
                    textInputAction: TextInputAction.done,
                    obscureText: !loginStore.visible,
                    onEditingComplete: () => node.unfocus(),
                    onChanged: loginStore.setPassword,
                  );
                }),
                SizedBox(height: 10),
                Observer(builder: (_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: loginStore.forgotPaswordValid
                            ? loginStore.forgotPassword
                            : loginStore.loading
                                ? null
                                : () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Digite seu E-mail!"),
                                    ));
                                  },
                        child: Text(
                          'Esqueceu sua senha?',
                          style: TextStyle(
                            color: AppColors.orange,
                          ),
                        ),
                      ),
                      if (loginStore.forgotPasswordLoading)
                        CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                    ],
                  );
                }),
                SizedBox(height: 50),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Observer(builder: (_) {
                    return ElevatedButton(
                      onPressed:
                          loginStore.loginValid ? loginStore.login : null,
                      child: loginStore.loginLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : Text(
                              'Cadastrar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    );
                  }),
                ),
                SizedBox(height: 30),
                Observer(builder: (_) {
                  return TextButton(
                    onPressed: loginStore.loading
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RegisterView(),
                              ),
                            );
                          },
                    child: Text(
                      'Não tem uma conta?',
                      style: TextStyle(
                        color: AppColors.lightGrey,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
