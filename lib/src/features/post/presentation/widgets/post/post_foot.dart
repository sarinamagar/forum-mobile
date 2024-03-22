import 'package:flutter/material.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/features/post/presentation/widgets/button/post/comment_button.dart';
import 'package:forum/src/features/post/presentation/widgets/button/post/share_button.dart';
import 'package:forum/src/features/post/presentation/widgets/button/post/vote_buttons.dart';

class PostFoot extends StatefulWidget {
  final PostScreensArgs screenArgs;
  const PostFoot({Key? key, required this.screenArgs}) : super(key: key);

  @override
  State<PostFoot> createState() => _PostFootState();
}

class _PostFootState extends State<PostFoot> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        children: [
          VoteButton(postScreensArgs: widget.screenArgs),
          CommentButton(postScreensArgs: widget.screenArgs),
          Spacer(),
          ShareButton(shares: widget.screenArgs.post.shares),
        ],
      ),
    );
  }
}
