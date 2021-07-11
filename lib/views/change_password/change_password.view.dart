import 'package:emptio/common/widgets/underlined_text_field.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/views/change_password/store/change_password.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class ChangePasswordView extends StatefulWidget {
  ChangePasswordView({Key? key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ChangePasswordStore _store = ChangePasswordStore();

  late ReactionDisposer errorDisposer;

  @override
  void initState() {
    errorDisposer = reaction((_) => _store.error, (String error) {
      if (error.isNotEmpty) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    errorDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Alterar senha"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 15, right: 15),
          child: Column(
            children: [
              Observer(builder: (_) {
                return UnderlinedPasswordTextField(
                  label: "Senha atual",
                  onChanged: _store.setActualPassword,
                  errorText: _store.actualPasswordError,
                  keyboardType: TextInputType.visiblePassword,
                  onEditingComplete: () {
                    node.nextFocus();
                    node.nextFocus();
                  },
                  textInputAction: TextInputAction.next,
                );
              }),
              SizedBox(height: 20),
              Observer(builder: (_) {
                return UnderlinedPasswordTextField(
                  label: "Nova senha",
                  onChanged: _store.setNewPassword,
                  errorText: _store.newPasswordError,
                  keyboardType: TextInputType.visiblePassword,
                  onEditingComplete: () {
                    node.nextFocus();
                    node.nextFocus();
                  },
                  textInputAction: TextInputAction.next,
                );
              }),
              SizedBox(height: 20),
              Observer(builder: (_) {
                return UnderlinedPasswordTextField(
                  label: "Confirmar nova senha",
                  onChanged: _store.setConfirmNewPassword,
                  errorText: _store.confirmNewPasswordError,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                );
              }),
              SizedBox(height: 50),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Observer(builder: (_) {
                  return ElevatedButton(
                    onPressed: _store.isFormValid ? _onFormSubmit : null,
                    child: _store.loading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : Text(
                            'Alterar Senha',
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
    );
  }

  Future<void> _onFormSubmit() async {
    FocusScope.of(context).unfocus();
    final changed = await _store.changePassword();

    if (changed) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Senha alterada com sucesso!"),
        backgroundColor: AppColors.green,
      ));
      Navigator.of(context).pop();
    }
  }
}
