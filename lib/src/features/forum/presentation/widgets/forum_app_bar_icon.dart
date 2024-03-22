import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forum/src/core/constants/app_colors.dart';

class ForumAppBarIcon extends StatelessWidget {
  final IconData? icon;
  final String? svgIcon;
  final double? height;
  final double? width;
  final Function()? onPressed;

  const ForumAppBarIcon({
    Key? key,
    this.icon,
    this.svgIcon,
    this.onPressed,
    this.height = 28,
    this.width = 26,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.black.withOpacity(0.4),
      ),
      child: Center(
        child: svgIcon != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  svgIcon!,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                  height: height,
                  width: width,
                ),
              )
            : IconButton(
                color: AppColors.jupiter,
                icon: Icon(
                  icon,
                  size: 28,
                ),
                onPressed: onPressed,
              ),
      ),
    );
  }
}
