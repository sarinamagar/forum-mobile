import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_fonts.dart';
import 'package:forum/src/core/constants/app_strings.dart';

class OrSeperator extends StatelessWidget {
  const OrSeperator({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;

    return Row(
      children: [
        Expanded(
          child: Container(
            color: AppColors.blackWith50Opacity,
            height: isTablet ? 2.5 : 1.4,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            AppStrings.or,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.steel,
                  fontSize: isTablet ? 18 : FontSize.light,
                ),
          ),
        ),
        Expanded(
          child: Container(
            color: AppColors.blackWith50Opacity,
            height: isTablet ? 2.5 : 1.4,
          ),
        ),
      ],
    );
  }
}
