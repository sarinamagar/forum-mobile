import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';

import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/utils/number_utils.dart';

class CommentButton extends StatefulWidget {
  final PostScreensArgs postScreensArgs;
  CommentButton({
    Key? key,
    required this.postScreensArgs,
  }) : super(key: key);

  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  List<Comment> comments = [];
  late Post post;

  @override
  void initState() {
    super.initState();
    post = widget.postScreensArgs.post;
    comments = post.comments!.map((e) => e).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isTablet ? 12 : 4.0),
      padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 10 : 6.0, vertical: isTablet ? 8.0 : 6.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.3,
          color: AppColors.white.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(isTablet ? 28 : 22),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppIcons.comment,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteWith40Opacity,
              BlendMode.srcIn,
            ),
            height: isTablet ? 26 : 16.0,
            width: 22.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 10 : 5.0),
            child: Text(
              ("${formatNumber(comments.length)} Comments"),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: isTablet ? 18 : null,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
