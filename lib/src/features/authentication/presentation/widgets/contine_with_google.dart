import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';

class ContinueWithGoogle extends StatelessWidget {
  const ContinueWithGoogle({Key? key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.blackWith40Opacity,
        minimumSize: Size(
          double.infinity,
          isTablet ? 55 : 45.0,
        ),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.googleIcon,
            height: isTablet ? 34.0 : 22.0,
            width: isTablet ? 28.0 : 22.0,
          ),
          SizedBox(width: isTablet ? 290 : 78.0),
          Text(
            AppStrings.loginWithGoogle,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  fontSize: isTablet ? 20 : null,
                ),
          ),
        ],
      ),
    );
  }
}
