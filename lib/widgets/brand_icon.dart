import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BrandIcon extends StatelessWidget {
  final double iconHeight = 60;
  final double iconWidth = 60;
  final String image;
  final Color backgroundColor;
  final VoidCallback onTap;

  BrandIcon({super.key, required this.image, required this.onTap, required this.backgroundColor,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: iconWidth,
      height: iconHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(image),
      ),
    );
  }
}
