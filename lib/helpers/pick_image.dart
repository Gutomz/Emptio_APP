import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage {
  final _picker = ImagePicker();

  Future<File?> pickFromCamera() async {
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    final File? file = pickedFile != null ? File(pickedFile.path) : null;

    return file;
  }

  Future<File?> pickFromGallery() async {
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final File? file = pickedFile != null ? File(pickedFile.path) : null;

    return file;
  }

  Future<File?> showPicker(context, bool canRemove) async {
    File? _file;

    _file = await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Galeria'),
                  onTap: () async {
                    File? file = await pickFromGallery();
                    Navigator.of(context).pop(file);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () async {
                    File? file = await pickFromCamera();
                    Navigator.of(context).pop(file);
                  },
                ),
                if (canRemove)
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Remover'),
                    onTap: () async {
                      Navigator.of(context).pop(null);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );

    return _file;
  }
}
