import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorPlaceholder extends StatelessWidget {
  final String error;
  final Function()? retry;

  const ErrorPlaceholder({
    Key? key,
    required this.error,
    required this.retry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppAssets.svgIcError),
        SizedBox(height: 15),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 25),
        ElevatedButton(
          onPressed: retry,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.red),
          ),
          child: Text('Tentar novamente'),
        ),
      ],
    );
  }
}
