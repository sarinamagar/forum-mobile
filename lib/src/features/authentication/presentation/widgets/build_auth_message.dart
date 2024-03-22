import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';

Text buildAuthMessage(BuildContext context, String message) {
  final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;

  return Text(
    message,
    style: Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: AppColors.white, fontSize: isTablet ? 32 : 24),
  );
}
