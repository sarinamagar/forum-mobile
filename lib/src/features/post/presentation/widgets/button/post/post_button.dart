import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';

class PostButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final double bottomPadding;
  final double verticalPadding;
  final double horizontalPadding;
  const PostButton({
    super.key,
    this.onPressed,
    this.bottomPadding = 16,
    required this.title,
    required this.verticalPadding,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        // color: AppColors.charcoal,
        color: AppColors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        elevation: 4,
        child: InkWell(
          onTap: onPressed,
          splashColor: AppColors.steel,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: verticalPadding, horizontal: horizontalPadding),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    // color: AppColors.blackWith40Opacity,
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: isTablet ? 18 : null,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
