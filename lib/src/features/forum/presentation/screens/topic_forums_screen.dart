import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/functions/build_toast.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/forum/presentation/viewmodels/forum_viewmodel.dart';
import 'package:forum/src/features/forum/presentation/widgets/forum_card.dart';

class TopicForumScreen extends StatelessWidget {
  final ForumScreensArgs forumScreensArgs;
  const TopicForumScreen({super.key, required this.forumScreensArgs});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.jupiter),
        titleSpacing: 0,
        title: Text(
          forumScreensArgs.topic!.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: isTablet ? 24 : 17,
                letterSpacing: 0,
              ),
        ),
      ),
      body: BlocProvider(
        create: (context) => sl<ForumViewModel>()
          ..add(TopicForums(topicID: forumScreensArgs.topic!.id!)),
        child: BlocConsumer<ForumViewModel, ForumState>(
          listener: (context, state) {
            if (state is TopicForumsFailed) {
              buildToast(toastType: ToastType.error, msg: state.message);
            }
          },
          buildWhen: (previous, current) {
            return current is TopicForumsSuccess ||
                current is TopicForumsLoading;
          },
          builder: (context, state) {
            if (state is TopicForumsLoading) {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.white,
                  animating: true,
                ),
              );
            }
            if (state is TopicForumsSuccess) {
              final List<Forum> topicForums = state.forums;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.separated(
                  itemCount: topicForums.length,
                  itemBuilder: (context, index) {
                    return ForumCard(
                        forum: topicForums[index],
                        user: forumScreensArgs.userInfo!);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 4);
                  },
                ),
              );
            } else {
              return Center(
                child: Image(
                  width: context.width / 2,
                  height: context.height / 2,
                  image: const AssetImage(AppImages.appLogo),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
