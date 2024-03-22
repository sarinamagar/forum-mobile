import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/core/constants/app_colors.dart';

class PostTypeIcon extends StatelessWidget {
  final String icon;
  final double padding;
  final double height;
  final Function()? onPressed;
  const PostTypeIcon({
    super.key,
    required this.icon,
    this.onPressed,
    this.padding = 8.0,
    this.height = 22,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: SvgPicture.asset(
          icon,
          colorFilter: const ColorFilter.mode(
            AppColors.whiteWith40Opacity,
            BlendMode.srcIn,
          ),
          height: height,
          width: height,
        ),
      ),
    );
  }
}
