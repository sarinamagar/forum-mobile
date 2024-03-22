import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/functions/build_toast.dart';
import 'package:forum/src/features/post/presentation/bloc/post_bloc.dart';
import 'package:forum/src/features/post/presentation/widgets/comment/comment_foot.dart';
import 'package:forum/src/features/post/presentation/widgets/comment/comment_head.dart';

class CommentCard extends StatelessWidget {
  final PostScreensArgs postScreensArgs;
  final Comment comment;

  CommentCard({Key? key, required this.comment, required this.postScreensArgs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return BlocProvider(
      create: (context) =>
          sl<PostBloc>()..add(GetCommentById(commentID: comment.id!)),
      child: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is CommentLoadingFailed) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
        },
        child: BlocBuilder<PostBloc, PostState>(
          buildWhen: (previous, current) {
            return current is CommentLoadingSuccess ||
                current is CommentLoading;
          },
          builder: (context, state) {
            if (state is CommentLoadingSuccess) {
              final List<Comment> replies = state.comment.replies ?? [];
              return Container(
                margin: const EdgeInsets.only(left: 8),
                padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 10 : 5, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.cursed,
                  border: Border(
                    left: BorderSide(
                      color: AppColors.graphite,
                      width: isTablet ? 2 : 1.2,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommentHead(
                      user: state.comment.userID,
                      createdAt: state.comment.createdAt!,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 4),
                      child: Text(
                        comment.commentText,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.white,
                              fontSize: isTablet ? 20 : 14,
                            ),
                      ),
                    ),
                    CommentFoot(
                      comment: state.comment,
                      postScreensArgs: postScreensArgs,
                    ),
                    if (replies.isNotEmpty)
                      Column(
                        children: replies.map((reply) {
                          return CommentCard(
                            comment: reply,
                            postScreensArgs: postScreensArgs,
                          );
                        }).toList(),
                      ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
