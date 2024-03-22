import 'package:flutter/material.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/utils/date_time_utils.dart';

class ForumPostHead extends StatelessWidget {
  final PostScreensArgs screenArgs;

  const ForumPostHead({Key? key, required this.screenArgs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: isTablet ? 18 : 12,
            child: ClipOval(
              child: (screenArgs.post.publisher.userInfo.avatarUrl != null)
                  ? Image.network(
                      screenArgs.post.publisher.userInfo.avatarUrl!,
                      width: isTablet ? 48 : 32,
                      height: isTablet ? 48 : 32,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      AppImages.appLogo,
                      width: isTablet ? 48 : 32,
                      height: isTablet ? 48 : 32,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 6),
          Row(
            children: [
              Text(
                "u/${screenArgs.post.publisher.userInfo.username}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.gray,
                      fontWeight: FontWeight.w500,
                      fontSize: isTablet ? 18 : null,
                    ),
              ),
              const SizedBox(width: 6),
              Text(
                dateTimeUtil(DateTime.parse(screenArgs.post.postDate)),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.steel, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.more_vert,
            size: isTablet ? 32 : 22,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
