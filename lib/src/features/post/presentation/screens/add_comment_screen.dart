import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/functions/build_toast.dart';
import 'package:forum/src/core/widgets/input_fields/comment_field.dart';
import 'package:forum/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';
import 'package:forum/src/features/post/presentation/bloc/post_bloc.dart';
import 'package:forum/src/features/post/presentation/widgets/button/post/post_button.dart';

class AddCommentScreen extends StatefulWidget {
  final PostScreensArgs postScreensArgs;
  const AddCommentScreen({super.key, required this.postScreensArgs});

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  late final TextEditingController _commentController;
  @override
  void initState() {
    _commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: AppColors.jupiter,
          icon: const Icon(
            Icons.close_outlined,
            size: 28,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        titleSpacing: 1,
        title: Text(
          AppStrings.addComment,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: isTablet ? 20 : null,
              ),
        ),
        actions: [
          PostButton(
            title: AppStrings.post,
            verticalPadding: isTablet ? 10 : 8,
            horizontalPadding: isTablet ? 16 : 14,
            onPressed: () {
              if (widget.postScreensArgs.comment != null) {
                AddReplyRequestDto dto = AddReplyRequestDto(
                  commentText: _commentController.text,
                  userId: widget.postScreensArgs.personInfo.userInfo.uid!,
                  postId: widget.postScreensArgs.post.id!,
                  commentId: widget.postScreensArgs.comment!.id!,
                );
                context.read<PostBloc>().add(
                      AddReply(dto),
                    );
              } else {
                AddCommentRequestDto dto = AddCommentRequestDto(
                    commentText: _commentController.text,
                    userId: widget.postScreensArgs.personInfo.userInfo.uid!,
                    postId: widget.postScreensArgs.post.id!);
                context.read<PostBloc>().add(
                      AddComment(dto),
                    );
              }
            },
          )
        ],
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostAddingComment || state is CommentAddingReply) {
            const CircularProgressIndicator();
          }
          if (state is PostCommentedSuccess || state is CommentRepliedSuccess) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.commentSuccess,
            );
            Navigator.of(context).pop();
          }
          if (state is PostCommentedFailed) {
            buildToast(
              toastType: ToastType.success,
              msg: state.message,
            );
          }
          if (state is CommentRepliedFailed) {
            buildToast(
              toastType: ToastType.success,
              msg: state.message,
            );
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: context.width,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.graphite,
                        width: 0.8,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 20, top: isTablet ? 20 : 10),
                  child: Text(
                    widget.postScreensArgs.comment?.commentText != null
                        ? "${AppStrings.replied} ${widget.postScreensArgs.comment!.commentText}"
                        : widget.postScreensArgs.post.caption,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.charcoal,
                          fontSize: isTablet ? 22 : 14,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CommentField(controller: _commentController),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
