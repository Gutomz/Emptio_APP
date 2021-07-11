import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/simple_confirm_dialog.widget.dart';
import 'package:emptio/common/widgets/underlined_text_field.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/helpers/pick_image.dart';
import 'package:emptio/models/profile_user.model.dart';
import 'package:emptio/views/edit_profile/store/edit_profile.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditProfileView extends StatelessWidget {
  final TextEditingController _nameInputController;
  final TextEditingController _emailInputController;
  final TextEditingController _descriptionInputController;
  final EditProfileStore _store;
  final PickImage picker = PickImage();

  EditProfileView({
    Key? key,
    required ProfileUserModel profileUser,
  })  : _nameInputController = TextEditingController(text: profileUser.name),
        _emailInputController = TextEditingController(text: profileUser.email),
        _descriptionInputController =
            TextEditingController(text: profileUser.description),
        _store = EditProfileStore(user: profileUser),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar perfil'),
        leading: IconButton(
          onPressed: () => _onPressClose(context),
          icon: Icon(Icons.close),
        ),
        actions: [
          Observer(
            builder: (context) {
              if (_store.hasChanges) {
                return Tooltip(
                  message: "Salvar alterações",
                  child: IconButton(
                    onPressed: () => _onPressSaveProfile(context),
                    icon: _store.loading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.orange,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(Icons.check),
                  ),
                );
              }

              return Container();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
          child: Column(
            children: [
              Hero(
                tag: _store.user.sId,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(45),
                  child: Observer(
                    builder: (context) {
                      if (_store.photo != null || _store.removePhoto) {
                        return ImageBuilder.fromFile(
                          _store.photo,
                          size: 90,
                          borderRadius: 45,
                          icon: Icons.person,
                          iconSize: 52,
                          backgroundColor: AppColors.orange,
                          foregroundColor: Colors.white,
                          hideBorder: true,
                        );
                      }

                      return ImageBuilder.fromString(
                        _store.user.photo,
                        size: 90,
                        borderRadius: 45,
                        icon: Icons.person,
                        iconSize: 52,
                        backgroundColor: AppColors.orange,
                        foregroundColor: Colors.white,
                        hideBorder: true,
                      );
                    },
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _selectImage(
                  context,
                  !_store.removePhoto &&
                      (_store.photo != null || _store.user.photo != null),
                ),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(AppColors.orange),
                  overlayColor: MaterialStateProperty.all(Colors.orange[50]),
                ),
                child: Text("Alterar foto"),
              ),
              Observer(builder: (_) {
                return UnderlinedTextField(
                  controller: _nameInputController,
                  label: "Nome",
                  enabled: !_store.loading,
                  textCapitalization: TextCapitalization.words,
                  onChanged: _store.setName,
                );
              }),
              SizedBox(height: 15),
              UnderlinedTextField(
                controller: _emailInputController,
                label: "Email",
                enabled: false,
                onChanged: _store.setEmail,
              ),
              SizedBox(height: 30),
              Observer(builder: (_) {
                return TextField(
                  controller: _descriptionInputController,
                  enabled: !_store.loading,
                  maxLength: _store.maxDescriptionLength,
                  minLines: 5,
                  maxLines: 7,
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    labelStyle: TextStyle(color: AppColors.blue),
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onChanged: _store.setDescription,
                );
              }),
              SizedBox(height: 50),
              Observer(builder: (_) {
                return OutlinedButton(
                  onPressed: _store.loading
                      ? null
                      : () => _onPressChangePassword(context),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(AppColors.orange),
                    side: MaterialStateProperty.all(
                        BorderSide(color: AppColors.orange)),
                    overlayColor: MaterialStateProperty.all<Color>(
                        AppColors.orange.withOpacity(0.1)),
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(
                        double.infinity,
                        50,
                      ),
                    ),
                  ),
                  child: Text("Alterar Senha"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage(BuildContext context, bool canRemove) async {
    final image = await picker.showPicker(context, canRemove: canRemove);
    _store.setPhoto(image);
  }

  Future<void> _onPressSaveProfile(BuildContext context) async {
    await _store.saveProfile();
  }

  void _onPressChangePassword(BuildContext context) {
    // TODO - Navigate to edit password view
  }

  Future<void> _onPressClose(BuildContext context) async {
    if (_store.hasChanges) {
      final bool? response = await showDialog<bool>(
        context: context,
        builder: (context) => SimpleConfirmDialog(
            title: "Cancelar Alteração",
            content: "Deseja desconsiderar as alterações feitas?",
            acceptText: "Sim",
            rejectText: "não"),
      );

      if (response == null && response == false) {
        return;
      }
    }

    Navigator.of(context).pop();
  }
}
