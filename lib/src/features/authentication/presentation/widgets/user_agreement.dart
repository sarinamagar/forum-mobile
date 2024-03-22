import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';

RichText userAgreement(BuildContext context) {
  final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      children: [
        TextSpan(
          text: AppStrings.userAgreement1,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.anchor,
                fontSize: isTablet ? 20 : null,
              ),
        ),
        TextSpan(
          text: AppStrings.userAgreement,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.red,
                fontSize: isTablet ? 20 : null,
              ),
        ),
        TextSpan(
          text: AppStrings.userAgreement2,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.anchor,
                fontSize: isTablet ? 20 : null,
              ),
        ),
        TextSpan(
          text: AppStrings.privacyPolicy,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.red,
                fontSize: isTablet ? 20 : null,
              ),
        ),
      ],
    ),
  );
}
