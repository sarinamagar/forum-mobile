import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/utils/number_utils.dart';
import 'package:forum/src/features/post/data/dto/add_votes/add_vote_request_dto.dart';
import 'package:forum/src/features/post/presentation/bloc/post_bloc.dart';

class VoteButton extends StatefulWidget {
  final PostScreensArgs postScreensArgs;
  const VoteButton({super.key, required this.postScreensArgs});

  @override
  State<VoteButton> createState() => _VoteButtonState();
}

class _VoteButtonState extends State<VoteButton> {
  late String action;
  List<User> upvotes = [];
  List<User> downvotes = [];
  late Post post;
  late User user;
  late int votes;

  @override
  void initState() {
    super.initState();
    post = widget.postScreensArgs.post;
    user = widget.postScreensArgs.personInfo;
    upvotes = post.upvotes!.map((e) => e).toList();
    downvotes = post.downvotes!.map((e) => e).toList();
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
      padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 10 : 6.0, vertical: isTablet ? 8.0 : 6.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: isTablet ? 2 : 1.3,
          color: AppColors.white.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(isTablet ? 28 : 22),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              AddVoteRequestDto dto = AddVoteRequestDto(
                  userID: widget.postScreensArgs.personInfo.userInfo.uid!,
                  postID: widget.postScreensArgs.post.id!);
              context.read<PostBloc>().add(UpvotePost(dto: dto));
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
              height: isTablet ? 26 : 16.0,
              width: isTablet ? 32 : 22.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 10 : 5.0),
            child: Text(
              formatNumber(votes),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: isTablet ? 20 : null,
                  ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: isTablet ? 12 : 6, left: 2),
            color: AppColors.graphite,
            width: 1.4,
            height: isTablet ? 28 : 16.0,
          ),
          GestureDetector(
            onTap: () {
              AddVoteRequestDto dto = AddVoteRequestDto(
                  userID: widget.postScreensArgs.personInfo.userInfo.uid!,
                  postID: widget.postScreensArgs.post.id!);
              if (action == "none" || action == "upvoted") {
                context.read<PostBloc>().add(DownvotePost(dto: dto));
                if (action == "upvoted") {
                  votes -= 2;
                } else {
                  votes -= 1;
                }
                setState(() {
                  action = "downvoted";
                });
              } else {
                context.read<PostBloc>().add(DownvotePost(dto: dto));
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
              height: isTablet ? 26 : 16.0,
              width: 22.0,
            ),
          ),
        ],
      ),
    );
  }
}
