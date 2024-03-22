import 'package:flutter/material.dart';
import 'package:forum/src/core/constants/app_colors.dart';

RichText otpMessage(BuildContext context, String message) {
  final _theme = Theme.of(context);
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: message,
      style: _theme.textTheme.bodyMedium!.copyWith(
        color: AppColors.anchor,
        fontSize: 15.2,
      ),
    ),
  );
}
