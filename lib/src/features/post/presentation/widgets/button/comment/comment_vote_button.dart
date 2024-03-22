import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/utils/number_utils.dart';
import 'package:forum/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:forum/src/features/post/presentation/bloc/post_bloc.dart';

class CommentVoteButtom extends StatefulWidget {
  final Comment comment;
  final User user;
  const CommentVoteButtom(
      {super.key, required this.comment, required this.user});

  @override
  State<CommentVoteButtom> createState() => _CommentVoteButtomState();
}

class _CommentVoteButtomState extends State<CommentVoteButtom> {
  late String action;
  List<User> upvotes = [];
  List<User> downvotes = [];
  late Comment comment;
  late User user;
  late int votes;

  @override
  void initState() {
    super.initState();
    comment = widget.comment;
    user = widget.user;

    upvotes = comment.upvotes!.map((e) => e).toList();
    downvotes = comment.downvotes!.map((e) => e).toList();
    votes = upvotes.length - downvotes.length;
    if (upvotes
        .any((upvotedUser) => upvotedUser.userInfo.uid == user.userInfo.uid)) {
      action = "upvoted";
    } else if (downvotes.any(
        (downvotedUser) => downvotedUser.userInfo.uid == user.userInfo.uid)) {
      action = "downvoted";
    } else {
      action = "none";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      child: Row(
        children: [
          BlocBuilder<PostBloc, PostState>(
            buildWhen: (previous, current) {
              return current is UpvoteCommentSuccess;
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  CommentVoteRequestDto dto = CommentVoteRequestDto(
                    userID: widget.user.userInfo.uid!,
                    commentID: comment.id!,
                  );
                  context.read<PostBloc>().add(UpvoteComment(dto: dto));
                  if (action == "none" || action == "downvoted") {
                    if (action == "downvoted") {
                      votes += 2;
                    } else {
                      votes += 1;
                    }
                    setState(() {
                      action = "upvoted";
                    });
                  } else {
                    votes -= 1;
                    setState(() {
                      action = "none";
                    });
                  }
                },
                child: SvgPicture.asset(
                  AppIcons.upvote,
                  colorFilter: action == "upvoted"
                      ? const ColorFilter.mode(
                          AppColors.green,
                          BlendMode.srcIn,
                        )
                      : const ColorFilter.mode(
                          AppColors.gray,
                          BlendMode.srcIn,
                        ),
                  height: isTablet ? 22 : 16.0,
                  width: 22.0,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: BlocBuilder<PostBloc, PostState>(
              buildWhen: (previous, current) {
                return current is UpvoteCommentSuccess;
              },
              builder: (context, state) {
                return Text(
                  formatNumber(votes),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.gray,
                        fontWeight: FontWeight.w500,
                        fontSize: isTablet ? 16 : null,
                      ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 6, left: 2),
            color: AppColors.graphite,
            width: 1.4,
            height: isTablet ? 22 : 16.0,
          ),
          GestureDetector(
            onTap: () {
              CommentVoteRequestDto dto = CommentVoteRequestDto(
                userID: widget.user.userInfo.uid!,
                commentID: comment.id!,
              );
              context.read<PostBloc>().add(DownvoteComment(dto: dto));
              if (action == "none" || action == "upvoted") {
                if (action == "upvoted") {
                  votes -= 2;
                } else {
                  votes -= 1;
                }
                setState(() {
                  action = "downvoted";
                });
              } else {
                votes += 1;
                setState(() {
                  action = "none";
                });
              }
            },
            child: SvgPicture.asset(
              AppIcons.downvote,
              colorFilter: action == "downvoted"
                  ? const ColorFilter.mode(
                      AppColors.red,
                      BlendMode.srcIn,
                    )
                  : const ColorFilter.mode(
                      AppColors.gray,
                      BlendMode.srcIn,
                    ),
              height: isTablet ? 22 : 16.0,
              width: 22.0,
            ),
          ),
        ],
      ),
    );
  }
}
