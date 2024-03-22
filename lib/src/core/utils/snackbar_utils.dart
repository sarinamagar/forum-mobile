import 'package:flutter/material.dart';
import 'package:forum/src/core/constants/app_colors.dart';

class SnackBarUtils {
  static void showSuccessBar(
      {required BuildContext context, required String message}) {
    final _theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.red,
        content: Text(
          message,
          style: _theme.textTheme.bodySmall!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static void showErrorBar(
      {required BuildContext context, required String message}) {
    final _theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.steel,
        content: Text(
          message,
          style: _theme.textTheme.bodySmall!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
