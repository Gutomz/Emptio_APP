import 'package:emptio/common/widgets/bottom_wave_clipper.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EntryHeaderWidget extends StatelessWidget {
  final double height;

  const EntryHeaderWidget({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Color.fromRGBO(51, 51, 51, 0.75), BlendMode.multiply),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AppAssets.imageMarket),
                ),
              ),
            ),
          ),
          Container(
            height: height,
            child: Center(
              child: Hero(
                tag: 'emptio',
                child: SvgPicture.asset(AppAssets.svgLogo),
              ),
            ),
          ),
        ],
      ),
      clipper: BottomWaveClipper(),
    );
  }
}