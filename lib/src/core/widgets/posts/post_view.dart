import 'package:flutter/material.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/features/post/presentation/widgets/post/post_body.dart';
import 'package:forum/src/features/post/presentation/widgets/post/post_foot.dart';
import 'package:forum/src/features/post/presentation/widgets/post/post_head.dart';

class PostView extends StatelessWidget {
  final PostScreensArgs screensArgs;
  final bool details;
  const PostView({super.key, required this.screensArgs, required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: BoxDecoration(
        border: Border(
          bottom:
              BorderSide(width: 0.3, color: AppColors.white.withOpacity(0.6)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PostHead(screenArgs: screensArgs, details: details),
          PostBody(screensArgs: screensArgs),
          PostFoot(screenArgs: screensArgs),
        ],
      ),
    );
  }
}
