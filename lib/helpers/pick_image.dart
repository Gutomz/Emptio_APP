import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage {
  final _picker = ImagePicker();

  Future<File?> pickFromCamera() async {
    final PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    final File? file = pickedFile != null ? File(pickedFile.path) : null;

    return file;
  }

  Future<File?> pickFromGallery() async {
    final PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final File? file = pickedFile != null ? File(pickedFile.path) : null;

    return file;
  }

  Future<File?> showPicker(BuildContext context,
      {bool canRemove = false}) async {
    final File? _file = await showModalBottomSheet<File?>(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galeria'),
                onTap: () => _onGalleryTap(context),
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () => _onCameraTap(context),
              ),
              if (canRemove)
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Remover'),
                  onTap: () => _onRemoveTap(context),
                ),
            ],
          ),
        );
      },
    );

    return _file;
  }

  Future<void> _onGalleryTap(BuildContext context) async {
    final File? file = await pickFromGallery();
    Navigator.of(context).pop(file);
  }

  Future<void> _onCameraTap(BuildContext context) async {
    final File? file = await pickFromCamera();
    Navigator.of(context).pop(file);
  }

  Future<void> _onRemoveTap(BuildContext context) async {
    Navigator.of(context).pop(null);
  }
}
