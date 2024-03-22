import 'package:flutter/material.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/utils/date_time_utils.dart';
import 'package:forum/src/features/forum/presentation/widgets/forum_app_bar_icon.dart';
import 'package:forum/src/features/forum/presentation/widgets/join_forum_button.dart';
import 'package:forum/src/features/profile/presentation/screens/about_screen.dart';
import 'package:forum/src/features/profile/presentation/screens/post_screen.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              iconTheme: const IconThemeData(color: AppColors.jupiter),
              expandedHeight: context.height / 2.8,
              floating: false,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  ((constraints.maxHeight - kToolbarHeight) /
                          (MediaQuery.of(context).size.height * 0.9))
                      .clamp(0.0, 1.0);

                  return FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.blue,
                                Colors.black.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 75,
                          left: 10,
                          child: CircleAvatar(
                            backgroundColor: AppColors.black,
                            radius: isTablet ? 100 : 60,
                            child: user.userInfo.avatarUrl != null
                                ? ClipOval(
                                    child: Image.network(
                                      user.userInfo.avatarUrl!,
                                      width: isTablet ? 200 : 152,
                                      height: isTablet ? 200 : 152,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ClipOval(
                                    child: Image.asset(
                                      AppImages.appLogo,
                                      width: isTablet ? 250 : 152,
                                      height: isTablet ? 250 : 152,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        Positioned(
                          top: isTablet ? 320 : 205.0,
                          left: 12.0,
                          child: JoinedForumButton(
                            title: AppStrings.edit,
                            verticalPadding: 10,
                            horizontalPadding: 8,
                            onPressed: () async {
                              await Navigator.of(context).pushNamed(
                                AppRoutes.updateProfile,
                                arguments: user,
                              );
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              Navigator.of(context).pushNamed(AppRoutes.profile,
                                  arguments: user);
                            },
                          ),
                        ),
                        Positioned(
                          top: isTablet ? 370 : 250.0,
                          left: 15.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.userInfo.username!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: AppColors.white,
                                      fontSize: isTablet ? 28 : null,
                                    ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    user.userInfo.username!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: AppColors.white,
                                          fontSize: isTablet ? 18 : 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 10 : 4),
                                    child: const Icon(
                                      Icons.circle,
                                      color: AppColors.white,
                                      size: 6,
                                    ),
                                  ),
                                  Text(
                                    "${user.karma.toString()} karma",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontSize: isTablet ? 18 : 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 10 : 4),
                                    child: const Icon(
                                      Icons.circle,
                                      color: AppColors.white,
                                      size: 6,
                                    ),
                                  ),
                                  Text(
                                    extractCreatedDate(
                                        user.userInfo.createdAt!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontSize: isTablet ? 18 : 12,
                                            fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  user.userInfo.bio ?? "2002",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: AppColors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    collapseMode: CollapseMode.pin,
                  );
                },
              ),
              actions: [
                ForumAppBarIcon(
                  svgIcon: AppIcons.search,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ForumAppBarIcon(
                  svgIcon: AppIcons.share,
                  height: 32,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ForumAppBarIcon(
                  icon: Icons.more_vert_outlined,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            SliverFillRemaining(
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          AppStrings.post,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTablet ? 20 : null,
                                  ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          AppStrings.about,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.charcoal,
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTablet ? 20 : null,
                                  ),
                        ),
                      ),
                    ],
                    dividerColor: AppColors.black,
                    indicatorColor: AppColors.blue,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ProfilePostScreen(user: user),
                        AboutScreen(user: user)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
