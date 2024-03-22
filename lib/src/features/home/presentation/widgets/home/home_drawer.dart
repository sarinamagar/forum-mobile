import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';

import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/functions/build_toast.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/forum/presentation/viewmodels/forum_viewmodel.dart';
import 'package:forum/src/features/topic/presentation/viewmodels/topic_viewmodel.dart';

class HomeDrawer extends StatelessWidget {
  final User user;
  const HomeDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TopicViewModel>()
            ..add(LoadUserForum(userID: user.userInfo.uid!)),
        ),
        BlocProvider(
          create: (context) => sl<ForumViewModel>()
            ..add(LoadJoinedForum(userID: user.userInfo.uid!)),
        ),
      ],
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          child: Drawer(
            backgroundColor: AppColors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Text(
                        AppStrings.visited,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.gray,
                              fontWeight: FontWeight.w500,
                              fontSize: isTablet ? 20 : 15,
                              letterSpacing: 0,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        "See all",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.gray,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                              fontSize: isTablet ? 20 : null,
                            ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.piano,
                            radius: isTablet ? 22 : 13,
                            child: user.userInfo.avatarUrl != null
                                ? ClipOval(
                                    child: Image.network(
                                      user.userInfo.avatarUrl!,
                                      width: isTablet ? 48 : 32,
                                      height: isTablet ? 48 : 32,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ClipOval(
                                    child: Image.asset(
                                      AppImages.appLogo,
                                      width: 32,
                                      height: 32,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "r/travel",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.jupiter,
                                  letterSpacing: 0,
                                  fontSize: isTablet ? 18 : null,
                                ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.2,
                        color: AppColors.shadow,
                      ),
                    ),
                  ),
                  child: ExpansionTile(
                    visualDensity: VisualDensity.compact,
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: AppColors.gray,
                    ),
                    initiallyExpanded: false,
                    collapsedBackgroundColor: AppColors.black,
                    title: Text(
                      AppStrings.mod,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.gray,
                            fontWeight: FontWeight.w500,
                            fontSize: isTablet ? 20 : 15,
                            letterSpacing: 0,
                          ),
                    ),
                    children: <Widget>[
                      BlocConsumer<TopicViewModel, TopicState>(
                        listener: (context, state) {
                          if (state is UserForumsFailed) {
                            buildToast(
                                toastType: ToastType.error, msg: state.message);
                          }
                        },
                        builder: (context, state) {
                          if (state is UserForumsLoading) {
                            return const Center(
                              child: CupertinoActivityIndicator(
                                color: AppColors.white,
                                animating: true,
                              ),
                            );
                          }
                          if (context
                              .read<TopicViewModel>()
                              .userForums
                              .isNotEmpty) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: context
                                  .read<TopicViewModel>()
                                  .userForums
                                  .length,
                              itemBuilder: (context, index) {
                                return ForumTile(
                                  forum: context
                                      .read<TopicViewModel>()
                                      .userForums[index],
                                );
                              },
                            );
                          } else {
                            return const DrawerTile(
                                iconName: AppIcons.forumUnselected,
                                title: AppStrings.createForum);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.7,
                        color: AppColors.shadow,
                      ),
                      top: BorderSide(
                        width: 0.7,
                        color: AppColors.shadow,
                      ),
                    ),
                  ),
                  child: ExpansionTile(
                    visualDensity: VisualDensity.compact,
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: AppColors.gray,
                    ),
                    initiallyExpanded: false,
                    collapsedBackgroundColor: AppColors.black,
                    title: Text(
                      "${AppStrings.your} ${AppStrings.forums}",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.gray,
                            fontWeight: FontWeight.w500,
                            fontSize: isTablet ? 20 : 15,
                            letterSpacing: 0,
                          ),
                    ),
                    children: <Widget>[
                      BlocConsumer<ForumViewModel, ForumState>(
                        listener: (context, state) {
                          if (state is JoinedForumsFailed) {
                            buildToast(
                                toastType: ToastType.error, msg: state.message);
                          }
                        },
                        builder: (context, state) {
                          if (state is JoinedForumsLoading) {
                            return const Center(
                              child: CupertinoActivityIndicator(
                                color: AppColors.white,
                                animating: true,
                              ),
                            );
                          }
                          if (context
                              .read<ForumViewModel>()
                              .joinedForums
                              .isNotEmpty) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: context
                                  .read<ForumViewModel>()
                                  .joinedForums
                                  .length,
                              itemBuilder: (context, index) {
                                return ForumTile(
                                  forum: context
                                      .read<ForumViewModel>()
                                      .joinedForums[index],
                                );
                              },
                            );
                          } else {
                            return const DrawerTile(
                                iconName: AppIcons.forumUnselected,
                                title: AppStrings.createForum);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                DrawerTile(
                  iconName: AppIcons.forumUnselected,
                  title: AppStrings.createForum,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.createForum,
                      arguments: user,
                    );
                  },
                ),
                DrawerTile(
                  iconName: AppIcons.homeUnselected,
                  title: AppStrings.all,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForumTile extends StatelessWidget {
  final Forum forum;
  const ForumTile({Key? key, required this.forum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(AppRoutes.topicForums);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.piano,
              radius: isTablet ? 20 : 12,
              child: forum.iconUrl != null
                  ? ClipOval(
                      child: Image.network(
                        forum.iconUrl!,
                        width: isTablet ? 48 : 32,
                        height: isTablet ? 48 : 32,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipOval(
                      child: Image.asset(
                        AppImages.appLogo,
                        width: isTablet ? 48 : 32,
                        height: isTablet ? 48 : 32,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(width: 10),
            Text(
              forum.forumName!,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.whiteWith40Opacity,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0,
                  fontSize: isTablet ? 18 : null),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String iconName;
  final String title;
  final Function()? onPressed;
  const DrawerTile(
      {super.key, required this.iconName, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            SvgPicture.asset(
              iconName,
              height: isTablet ? 30 : 22.0,
              width: 20.0,
              colorFilter: const ColorFilter.mode(
                AppColors.shadow,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.anchor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                    fontSize: isTablet ? 18 : null,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
