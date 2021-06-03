import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/views/login/store/login.store.dart';
import 'package:emptio/views/register/register.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatelessWidget {
  final LoginStore loginStore = LoginStore();

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
                Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Observer(builder: (_) {
                    return ElevatedButton(
                      onPressed:
                          loginStore.loginValid ? loginStore.login : null,
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterView()),
                    );
                  },
                  child: Text(
                    'Não tem uma conta?',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
