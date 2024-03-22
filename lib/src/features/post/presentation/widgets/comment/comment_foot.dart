import 'package:flutter/material.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/features/post/presentation/widgets/button/comment/comment_vote_button.dart';
import 'package:forum/src/features/post/presentation/widgets/button/comment/reply_button.dart';

class CommentFoot extends StatelessWidget {
  final Comment comment;
  final PostScreensArgs postScreensArgs;
  const CommentFoot({
    Key? key,
    required this.comment,
    required this.postScreensArgs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.more_vert,
          size: isTablet ? 30 : 20,
          color: AppColors.gray,
        ),
        ReplyButton(
          commentId: comment.id!,
          onPressed: () async {
            await Navigator.of(context).pushNamed(
              AppRoutes.addComment,
              arguments: PostScreensArgs(
                post: postScreensArgs.post,
                personInfo: postScreensArgs.personInfo,
                comment: comment,
              ),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushNamed(
              AppRoutes.viewPost,
              arguments: PostScreensArgs(
                post: postScreensArgs.post,
                personInfo: postScreensArgs.personInfo,
              ),
            );
          },
        ),
        CommentVoteButtom(
          comment: comment,
          user: postScreensArgs.personInfo,
        ),
      ],
    );
  }
}
