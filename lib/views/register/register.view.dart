import 'dart:io';

import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/helpers/pick_image.dart';
import 'package:emptio/views/home/home.view.dart';
import 'package:emptio/views/register/store/register.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterStore registerStore = RegisterStore();

  final PickImage picker = PickImage();

  late ReactionDisposer errorDisposer;
  late ReactionDisposer loggedDisposer;

  @override
  initState() {
    super.initState();

    errorDisposer = reaction((_) => registerStore.error, (String error) {
      if (error.isNotEmpty) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
      }
    });

    loggedDisposer = reaction((_) => registerStore.logged, (bool logged) {
      if (logged) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => HomeView()),
            (route) => false);
      }
    });
  }

  @override
  void dispose() {
    errorDisposer();
    loggedDisposer();
    super.dispose();
  }

  buildImage(File? _image) {
    if (_image == null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        width: 100,
        height: 100,
        child: Icon(
          Icons.camera_alt,
          color: AppColors.grey,
          size: 30,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.file(
          _image,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  _selectImage(BuildContext context, File? _current) async {
    File? image = await picker.showPicker(context, _current != null);
    registerStore.setPhoto(image);
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: AppBar(
        title: Text('Cadastro'),
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
                Observer(builder: (_ctx) {
                  return CircleAvatar(
                    radius: 53,
                    backgroundColor: AppColors.darkOrange,
                    child: buildImage(registerStore.photo),
                  );
                }),
                Observer(builder: (_ctx) {
                  return TextButton(
                    onPressed: registerStore.loading
                        ? null
                        : () => _selectImage(_ctx, registerStore.photo),
                    child: Text(
                      registerStore.photo != null
                          ? 'Alterar imagem'
                          : 'Selecionar imagem',
                      style: TextStyle(
                        color: registerStore.loading
                            ? AppColors.grey
                            : AppColors.orange,
                      ),
                    ),
                  );
                }),
                SizedBox(height: 50),
                Observer(builder: (_) {
                  return TextField(
                    enabled: !registerStore.loading,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: AppColors.orange),
                      hintText: 'Name',
                      errorText: registerStore.nameError,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: registerStore.setName,
                  );
                }),
                SizedBox(height: 25),
                Observer(builder: (_) {
                  return TextField(
                    enabled: !registerStore.loading,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: AppColors.orange),
                      hintText: 'E-mail',
                      errorText: registerStore.emailError,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: registerStore.setEmail,
                  );
                }),
                SizedBox(height: 25),
                Observer(builder: (_) {
                  return TextField(
                    enabled: !registerStore.loading,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key, color: AppColors.orange),
                      suffixIcon: IconButton(
                        onPressed: registerStore.togglePasswordVisible,
                        icon: Icon(
                          registerStore.passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.grey,
                        ),
                        splashRadius: 2,
                      ),
                      hintText: 'Senha',
                      errorText: registerStore.passwordError,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      node.nextFocus();
                      node.nextFocus();
                    },
                    obscureText: !registerStore.passwordVisible,
                    onChanged: registerStore.setPassword,
                  );
                }),
                SizedBox(height: 25),
                Observer(builder: (_) {
                  return TextField(
                    enabled: !registerStore.loading,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.shield, color: AppColors.orange),
                      suffixIcon: IconButton(
                        onPressed: registerStore.toggleConfirmPasswordVisible,
                        icon: Icon(
                          registerStore.confirmPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.grey,
                        ),
                        splashRadius: 2,
                      ),
                      hintText: 'Confirmar Senha',
                      errorText: registerStore.confirmPasswordError,
                    ),
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => node.unfocus(),
                    obscureText: !registerStore.confirmPasswordVisible,
                    onChanged: registerStore.setConfirmPassword,
                  );
                }),
                SizedBox(height: 50),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Observer(builder: (_) {
                    return ElevatedButton(
                      onPressed: registerStore.isFormValid
                          ? registerStore.register
                          : null,
                      child: registerStore.loading
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
