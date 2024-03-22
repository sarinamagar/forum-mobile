import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/utils/number_utils.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/forum/presentation/viewmodels/forum_viewmodel.dart';
import 'package:forum/src/features/forum/presentation/widgets/join_forum_button.dart';

class ForumCard extends StatefulWidget {
  final Forum forum;
  final User user;
  const ForumCard({super.key, required this.forum, required this.user});

  @override
  State<ForumCard> createState() => _ForumCardState();
}

class _ForumCardState extends State<ForumCard> {
  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    bool isForumJoined = false;
    return BlocProvider(
      create: (context) => sl<ForumViewModel>()
        ..add(LoadJoinedForum(userID: widget.user.userInfo.uid!)),
      child: BlocBuilder<ForumViewModel, ForumState>(
        builder: (context, state) {
          if (state is JoinedForumsSuccess) {
            isForumJoined = state.forums.any((f) => f.id == widget.forum.id);
          }
          if (state is JoinForumSuccess) {
            isForumJoined = true;
          }
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.viewForum,
                arguments: ForumScreensArgs(
                  userInfo: widget.user,
                  forum: widget.forum,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: AppColors.blackWith50Opacity,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.piano,
                            radius: isTablet ? 24 : 20,
                            child: widget.forum.iconUrl != null
                                ? ClipOval(
                                    child: Image.network(
                                      widget.forum.iconUrl!,
                                      width: isTablet ? 44 : 32,
                                      height: isTablet ? 44 : 32,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace) {
                                        return Center(
                                          child: Text(
                                            AppStrings.loadError,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: AppColors.red,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0,
                                                  fontSize: isTablet ? 16 : 6,
                                                ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : ClipOval(
                                    child: Image.asset(
                                      AppImages.appLogo,
                                      width: isTablet ? 44 : 32,
                                      height: isTablet ? 44 : 32,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.forum.forumName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0,
                                      fontSize: isTablet ? 19 : 15,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${formatNumber(widget.forum.members!.length)} members",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppColors.anchor,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0,
                                      fontSize: isTablet ? 16 : null,
                                    ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (!isForumJoined)
                            JoinForumButton(
                              userID: widget.user.userInfo.uid!,
                              forumID: widget.forum.id!,
                              title: AppStrings.join,
                              verticalPadding: 6,
                              horizontalPadding: 10,
                            ),
                          if (isForumJoined)
                            const JoinedForumButton(
                              title: AppStrings.joined,
                              verticalPadding: 6,
                              horizontalPadding: 0,
                            )
                        ],
                      ),
                    ),
                    Text(
                      widget.forum.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.anchor,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                            fontSize: isTablet ? 16 : null,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
