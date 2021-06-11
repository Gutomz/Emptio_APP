import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyPlaceholder extends StatelessWidget {
  final TextStyle _spanStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  final String title;
  final String subTitleBefore;
  final String subTitleAfter;
  final String asset;

  EmptyPlaceholder({
    Key? key,
    required this.title,
    required this.subTitleBefore,
    required this.subTitleAfter,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(asset),
        SizedBox(height: 15),
        Text(title, style: _spanStyle),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(subTitleBefore, style: _spanStyle),
            SizedBox(width: 5),
            SizedBox(
              width: 25,
              height: 25,
              child: FloatingActionButton(
                heroTag: 'none',
                onPressed: null,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
            SizedBox(width: 5),
            Text(subTitleAfter, style: _spanStyle),
          ],
        ),
      ],
    );
  }
}
