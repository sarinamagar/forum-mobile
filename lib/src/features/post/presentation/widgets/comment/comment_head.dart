import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/utils/date_time_utils.dart';

class CommentHead extends StatelessWidget {
  final User user;
  final String createdAt;

  const CommentHead({super.key, required this.user, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: isTablet ? 18 : 14,
            child: ClipOval(
              child: user.userInfo.avatarUrl != null
                  ? Image.network(
                      user.userInfo.avatarUrl!,
                      width: isTablet ? 46 : 32,
                      height: isTablet ? 46 : 32,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      AppImages.appLogo,
                      width: isTablet ? 46 : 32,
                      height: isTablet ? 46 : 32,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            "r/${user.userInfo.username}",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.gray,
                  fontWeight: FontWeight.w500,
                  fontSize: isTablet ? 18 : null,
                ),
          ),
          const SizedBox(width: 6),
          Text(
            dateTimeUtil(DateTime.parse(createdAt)),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.steel,
                  fontWeight: FontWeight.w500,
                  fontSize: isTablet ? 15 : null,
                ),
          ),
        ],
      ),
    );
  }
}
