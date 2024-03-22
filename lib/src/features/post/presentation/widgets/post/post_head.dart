import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/utils/date_time_utils.dart';
import 'package:forum/src/features/forum/presentation/viewmodels/forum_viewmodel.dart';
import 'package:forum/src/features/forum/presentation/widgets/join_forum_button.dart';

class PostHead extends StatelessWidget {
  final PostScreensArgs screenArgs;
  final bool details;

  const PostHead({Key? key, required this.screenArgs, required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return BlocProvider(
      create: (context) => sl<ForumViewModel>()
        ..add(LoadJoinedForum(userID: screenArgs.personInfo.userInfo.uid!)),
      child: BlocBuilder<ForumViewModel, ForumState>(
        builder: (context, state) {
          if (state is JoinedForumsSuccess) {
            bool isForumJoined = state.forums
                .any((forum) => forum.id == screenArgs.post.forumID?.id);
            return Container(
              margin: const EdgeInsets.only(top: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: isTablet ? 22 : 14,
                    child: ClipOval(
                      child: (screenArgs.post.forumID != null &&
                              screenArgs.post.forumID!.iconUrl != null)
                          ? Image.network(
                              screenArgs.post.forumID!.iconUrl!,
                              width: isTablet ? 48 : 32,
                              height: isTablet ? 48 : 32,
                              fit: BoxFit.cover,
                            )
                          : (screenArgs.post.publisher.userInfo.avatarUrl !=
                                  null)
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
                  SizedBox(width: isTablet ? 14 : 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            screenArgs.post.forumID != null &&
                                    screenArgs.post.forumID!.forumName != null
                                ? "f/${screenArgs.post.forumID!.forumName}"
                                : "u/${screenArgs.post.publisher.userInfo.username}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTablet ? 20 : null),
                          ),
                          SizedBox(width: isTablet ? 14 : 6),
                          Text(
                            dateTimeUtil(
                                DateTime.parse(screenArgs.post.postDate)),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: AppColors.steel,
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTablet ? 18 : null),
                          ),
                        ],
                      ),
                      if (details)
                        Text(
                          "u/${screenArgs.post.publisher.userInfo.username}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: AppColors.steel,
                                  fontSize: isTablet ? 1 : 11,
                                  fontWeight: FontWeight.w400),
                        ),
                    ],
                  ),
                  const Spacer(),
                  if (screenArgs.post.forumID != null &&
                      screenArgs.post.forumID!.forumName != null &&
                      !isForumJoined)
                    JoinForumButton(
                      title: AppStrings.join,
                      verticalPadding: 6,
                      horizontalPadding: 10,
                      userID: screenArgs.personInfo.userInfo.uid!,
                      forumID: screenArgs.post.forumID!.id!,
                    ),
                  Icon(
                    Icons.more_vert,
                    size: isTablet ? 34 : 24,
                    color: AppColors.white,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
