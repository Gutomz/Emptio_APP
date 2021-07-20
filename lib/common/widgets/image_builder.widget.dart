import 'dart:io';

import 'package:emptio/core/app_colors.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ImageBuilder {
  static final AuthStore _authStore = GetIt.I<AuthStore>();

  static Widget fromFile(
    File? image, {
    double size = 80,
    double iconSize = 32,
    double elevation = 5,
    double borderRadius = 8,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    IconData icon = Icons.image_not_supported_outlined,
    bool hideBorder = false,
    double borderWidth = 1,
  }) {
    return buildImage(
      image != null ? FileImage(image) : null,
      size: size,
      iconSize: iconSize,
      icon: icon,
      elevation: elevation,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      hideBorder: hideBorder,
      borderWidth: borderWidth,
      borderColor: borderColor,
    );
  }

  static Widget fromString(
    String? image, {
    double size = 80,
    double iconSize = 32,
    double elevation = 0,
    double borderRadius = 8,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    IconData icon = Icons.image_not_supported_outlined,
    bool hideBorder = false,
    double borderWidth = 1,
  }) {
    ImageProvider<Object>? provider;

    if (image != null && _authStore.isLogged) {
      provider = NetworkImage(image);
    }

    return buildImage(
      provider,
      size: size,
      iconSize: iconSize,
      icon: icon,
      elevation: elevation,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      hideBorder: hideBorder,
      borderWidth: borderWidth,
      borderColor: borderColor,
    );
  }

  static Widget buildImage(
    ImageProvider<Object>? image, {
    required double size,
    required double iconSize,
    required double elevation,
    required double borderRadius,
    required IconData icon,
    required bool hideBorder,
    required double borderWidth,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
  }) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          image: image != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: image,
                )
              : null,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: hideBorder == true
              ? null
              : Border.all(
                  color: borderColor ?? AppColors.grey, width: borderWidth),
          color: backgroundColor ?? AppColors.lightGrey.withOpacity(0.2),
        ),
        child: image == null
            ? Icon(
                icon,
                color: foregroundColor ?? AppColors.black,
                size: iconSize,
              )
            : null,
      ),
    );
  }
}
