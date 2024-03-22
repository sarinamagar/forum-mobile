import 'package:flutter/material.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/constants/media_query_values.dart';

class PostBody extends StatefulWidget {
  final PostScreensArgs screensArgs;
  const PostBody({Key? key, required this.screensArgs}) : super(key: key);

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.screensArgs.post.caption,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: isTablet ? 22 : 15,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          if (widget.screensArgs.post.description != null)
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.screensArgs.post.description ?? '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.charcoal, fontSize: isTablet ? 18 : 13),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (widget.screensArgs.post.postMediaUrl!.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.4,
                  color: AppColors.charcoal,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  widget.screensArgs.post.postMediaUrl!,
                  width: double.infinity,
                  height: isTablet
                      ? context.heightOfScreenOnly / 1.45
                      : context.heightOfScreenOnly / 2.15,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return const Center(
                      child: Text(
                        AppStrings.loadError,
                        style: TextStyle(
                          color: AppColors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
