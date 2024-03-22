import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';

class CommentNavigateField extends StatelessWidget {
  final Function()? onPressed;
  const CommentNavigateField({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.commentPlaceholder,
                style: TextStyle(
                  color: AppColors.steel,
                  fontSize: isTablet ? 20 : null,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.send_rounded,
                color: AppColors.steel,
              ),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
