import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/views/redefine_password/store/redefine_password.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RedefinePasswordView extends StatelessWidget {
  final RedefinePasswordStore redefinePasswordStore = RedefinePasswordStore();

  RedefinePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: AppBar(
        title: Text('Redefinir Senha'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Hero(
            tag: 'emptio',
            child: SvgPicture.asset(
              AppAssets.svgIcLogo,
              width: 25,
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50, right: 25, bottom: 15, left: 25),
            child: Column(
              children: [
                Text(
                  'Utilize o código enviado ao seu e-mail para concluir a redefinição da senha',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Observer(builder: (_) {
                  return TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.confirmation_number,
                        color: AppColors.orange,
                      ),
                      hintText: 'Código',
                      errorText: redefinePasswordStore.codeError,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: redefinePasswordStore.setCode,
                  );
                }),
                SizedBox(height: 25),
                Observer(builder: (_) {
                  return TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key, color: AppColors.orange),
                      suffixIcon: IconButton(
                        onPressed: redefinePasswordStore.togglePasswordVisible,
                        icon: Icon(
                          redefinePasswordStore.passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.grey,
                        ),
                        splashRadius: 2,
                      ),
                      hintText: 'Nova Senha',
                      errorText: redefinePasswordStore.passwordError,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      node.nextFocus();
                      node.nextFocus();
                    },
                    obscureText: !redefinePasswordStore.passwordVisible,
                    onChanged: redefinePasswordStore.setPassword,
                  );
                }),
                SizedBox(height: 25),
                Observer(builder: (_) {
                  return TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.shield, color: AppColors.orange),
                      suffixIcon: IconButton(
                        onPressed:
                            redefinePasswordStore.toggleConfirmPasswordVisible,
                        icon: Icon(
                          redefinePasswordStore.confirmPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.grey,
                        ),
                        splashRadius: 2,
                      ),
                      hintText: 'Confirmar Senha',
                      errorText: redefinePasswordStore.confirmPasswordError,
                    ),
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => node.unfocus(),
                    obscureText: !redefinePasswordStore.confirmPasswordVisible,
                    onChanged: redefinePasswordStore.setConfirmPassword,
                  );
                }),
                SizedBox(height: 50),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Observer(builder: (_) {
                    return ElevatedButton(
                      onPressed: redefinePasswordStore.redefinePasswordValid
                          ? () {}
                          : null,
                      child: Text(
                        'Redefinir Senha',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
