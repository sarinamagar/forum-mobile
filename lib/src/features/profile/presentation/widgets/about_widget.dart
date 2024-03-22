import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/utils/date_time_utils.dart';

class AboutWidget extends StatelessWidget {
  final User user;
  const AboutWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.karma,
              width: isTablet ? 48 : 32,
              height: isTablet ? 48 : 32,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.karma.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      fontSize: isTablet ? 20 : null),
                ),
                Text(
                  "Karma",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.anchor,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                      fontSize: isTablet ? 16 : null),
                ),
              ],
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(right: 6, left: 2),
          color: AppColors.graphite,
          width: 1.4,
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.age,
              width: isTablet ? 48 : 32,
              height: isTablet ? 48 : 32,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateTimeUtil(DateTime.parse(user.userInfo.createdAt!)),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      fontSize: isTablet ? 20 : null),
                ),
                Text(
                  "Forum age",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.anchor,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                      fontSize: isTablet ? 16 : null),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
