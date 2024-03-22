import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';

class CustomRoundedButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double bottomPadding;
  final double buttonWidth;

  const CustomRoundedButton({
    super.key,
    required this.title,
    this.onPressed,
    this.bottomPadding = 16,
    this.buttonWidth = 145,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;

    return Container(
      margin: EdgeInsets.only(bottom: bottomPadding),
      child: Material(
        color: AppColors.whiteWith40Opacity,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        elevation: 4,
        child: InkWell(
          onTap: onPressed,
          splashColor: AppColors.steel,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: isTablet ? 200 : buttonWidth),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Text(
              title,
              style: _theme.textTheme.titleMedium!
                  .copyWith(fontSize: isTablet ? 24 : null),
            ),
          ),
        ),
      ),
    );
  }
}
