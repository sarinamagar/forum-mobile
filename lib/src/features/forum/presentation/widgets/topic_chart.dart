import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/functions/build_toast.dart';
import 'package:forum/src/features/topic/domain/entities/topic.dart';
import 'package:forum/src/features/topic/presentation/viewmodels/topic_viewmodel.dart';

class TopicChart extends StatelessWidget {
  final User user;
  const TopicChart({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return BlocConsumer<TopicViewModel, TopicState>(
      listener: (context, state) {
        if (state is TopicsLoadingFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
      },
      buildWhen: (previous, current) {
        return current is TopicsLoadingSuccess || current is TopicsLoading;
      },
      builder: (context, state) {
        if (state is TopicsLoading) {
          return const Center(
            child: CupertinoActivityIndicator(
              color: AppColors.white,
              animating: true,
            ),
          );
        }
        if (context.read<TopicViewModel>().topics.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${AppStrings.forums} ${AppStrings.topCharts}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: isTablet ? 24 : 16,
                    ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: context.height / 2,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: context.read<TopicViewModel>().topics.length,
                  itemBuilder: (context, index) {
                    return TopicTile(
                      topic: context.read<TopicViewModel>().topics[index],
                      user: user,
                    );
                  },
                ),
              ),
            ],
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
    );
  }
}

class TopicTile extends StatelessWidget {
  final Topic topic;
  final User user;
  const TopicTile({Key? key, required this.topic, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.topicForums,
          arguments: ForumScreensArgs(topic: topic, userInfo: user),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              topic.name,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.whiteWith40Opacity,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    fontSize: isTablet ? 20 : null,
                  ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.whiteWith40Opacity,
              size: isTablet ? 20 : 15,
            ),
          ],
        ),
      ),
    );
  }
}
