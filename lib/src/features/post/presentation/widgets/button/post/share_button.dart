import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/utils/number_utils.dart';

class ShareButton extends StatelessWidget {
  final int shares;
  const ShareButton({super.key, required this.shares});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.0),
      padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 10 : 4.0, vertical: isTablet ? 8.0 : 1.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.3,
          color: AppColors.white.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppIcons.share,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteWith40Opacity,
              BlendMode.srcIn,
            ),
            height: isTablet ? 32 : 24.0,
            width: 22.0,
          ),
          if (shares != 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                formatNumber(shares),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: isTablet ? 18 : null,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
