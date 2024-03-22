import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';

class ReplyButton extends StatelessWidget {
  final Function()? onPressed;
  final String commentId;

  const ReplyButton({super.key, this.onPressed, required this.commentId});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        child: Row(
          children: [
            SvgPicture.asset(
              AppIcons.reply,
              colorFilter: const ColorFilter.mode(
                AppColors.gray,
                BlendMode.srcIn,
              ),
              height: isTablet ? 32 : 22.0,
              width: 22.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                AppStrings.reply,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.gray,
                      fontWeight: FontWeight.w500,
                      fontSize: isTablet ? 16 : null,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
