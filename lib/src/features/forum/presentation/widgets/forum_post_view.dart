import 'package:flutter/material.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/features/forum/presentation/widgets/forum_post_head.dart';
import 'package:forum/src/features/post/presentation/widgets/post/post_body.dart';
import 'package:forum/src/features/post/presentation/widgets/post/post_foot.dart';
import 'package:forum/src/features/post/presentation/widgets/post/post_head.dart';

class ForumPostView extends StatelessWidget {
  final PostScreensArgs screensArgs;
  const ForumPostView({super.key, required this.screensArgs});

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
          ForumPostHead(screenArgs: screensArgs),
          PostBody(screensArgs: screensArgs),
          PostFoot(screenArgs: screensArgs),
        ],
      ),
    );
  }
}
