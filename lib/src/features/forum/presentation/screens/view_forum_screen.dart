import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/features/forum/presentation/viewmodels/forum_viewmodel.dart';
import 'package:forum/src/features/forum/presentation/widgets/forum_app_bar_icon.dart';
import 'package:forum/src/features/forum/presentation/widgets/forum_post_view.dart';
import 'package:forum/src/features/forum/presentation/widgets/join_forum_button.dart';
import 'package:forum/src/features/post/presentation/widgets/post/forum_rules.dart';

class ViewForumScreen extends StatelessWidget {
  final ForumScreensArgs forumScreensArgs;
  const ViewForumScreen({super.key, required this.forumScreensArgs});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    List<Post> posts = [];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          iconTheme: const IconThemeData(color: AppColors.jupiter),
          titleSpacing: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  forumScreensArgs.forum?.coverUrl ??
                      'https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          leading: ForumAppBarIcon(
            icon: Icons.arrow_back_rounded,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            ForumAppBarIcon(
              svgIcon: AppIcons.search,
              height: isTablet ? 42 : 38,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ForumAppBarIcon(
              svgIcon: AppIcons.share,
              height: isTablet ? 42 : 38,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ForumAppBarIcon(
              icon: Icons.more_vert_outlined,
              height: isTablet ? 42 : null,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => sl<ForumViewModel>()
          ..add(ForumLoadPosts(forumID: forumScreensArgs.forum!.id!)),
        child:
            BlocBuilder<ForumViewModel, ForumState>(builder: (context, state) {
          if (state is ForumPostsLoading) {
            return const Center(
              child: CupertinoActivityIndicator(
                color: AppColors.white,
                animating: true,
              ),
            );
          }
          if (state is JoinForumSuccess) {
            forumScreensArgs.forum!.members!.add(forumScreensArgs.userInfo!);
          }
          if (state is ForumPostsLoadingSuccess) {
            posts = state.posts;
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.piano,
                          radius: isTablet ? 28 : 20,
                          child: forumScreensArgs.forum!.iconUrl != null
                              ? ClipOval(
                                  child: Image.network(
                                    forumScreensArgs.forum!.iconUrl!,
                                    width: isTablet ? 64 : 32,
                                    height: isTablet ? 64 : 32,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipOval(
                                  child: Image.asset(
                                    AppImages.appLogo,
                                    width: isTablet ? 64 : 32,
                                    height: isTablet ? 64 : 32,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              forumScreensArgs.forum!.forumName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0,
                                    fontSize: isTablet ? 24 : 15,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  "${forumScreensArgs.forum!.members!.length} members",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: AppColors.anchor,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0,
                                        fontSize: isTablet ? 18 : null,
                                      ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: isTablet ? 20 : 14,
                                  height: isTablet ? 20 : 14,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                    border: Border.all(
                                      color: AppColors.piano,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${forumScreensArgs.forum!.members!.length - 1} online",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: AppColors.anchor,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0,
                                        fontSize: isTablet ? 18 : null,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (!forumScreensArgs.forum!.members!.any((member) =>
                            member.userInfo.uid ==
                            forumScreensArgs.userInfo!.userInfo.uid))
                          JoinForumButton(
                            userID: forumScreensArgs.userInfo!.userInfo.uid!,
                            forumID: forumScreensArgs.forum!.id!,
                            title: AppStrings.join,
                            verticalPadding: 8,
                            horizontalPadding: 10,
                          ),
                        if (forumScreensArgs.forum!.members!.any((member) =>
                            member.userInfo.uid ==
                            forumScreensArgs.userInfo!.userInfo.uid))
                          const JoinedForumButton(
                            title: AppStrings.joined,
                            verticalPadding: 6,
                            horizontalPadding: 0,
                          )
                      ],
                    ),
                  ),
                  Text(
                    forumScreensArgs.forum!.description!,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                          fontSize: isTablet ? 18 : null,
                        ),
                  ),
                  const SizedBox(height: 4),
                  ForumRules(
                    title: AppStrings.seeMore,
                    font: isTablet ? 18 : 12.5,
                  ),
                  const Divider(thickness: 0.3, color: AppColors.gray),
                  if (posts.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.viewPost,
                            arguments: PostScreensArgs(
                              post: posts[index],
                              personInfo: forumScreensArgs.userInfo!,
                            ),
                          );
                        },
                        child: ForumPostView(
                          screensArgs: PostScreensArgs(
                            post: posts[index],
                            personInfo: forumScreensArgs.userInfo!,
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      itemCount: posts.length,
                    )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
