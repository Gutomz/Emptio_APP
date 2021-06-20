import 'package:flutter/material.dart';

class DismissibleBackground extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool secondary;

  const DismissibleBackground({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
    this.secondary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.color,
      child: Align(
        alignment: Alignment(secondary ? 0.85 : -0.85, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              this.icon,
              color: Colors.white,
            ),
            Text(
              this.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
