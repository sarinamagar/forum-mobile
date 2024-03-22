// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/core/app.dart';

import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/features/forum/data/dto/join_forum/join_forum_request_dto.dart';
import 'package:forum/src/features/forum/presentation/viewmodels/forum_viewmodel.dart';

class JoinForumButton extends StatelessWidget {
  final String title;
  final double bottomPadding;
  final double verticalPadding;
  final double horizontalPadding;
  final String userID;
  final String forumID;
  const JoinForumButton({
    Key? key,
    required this.title,
    this.bottomPadding = 16,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.userID,
    required this.forumID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        color: AppColors.midnight,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        elevation: 4,
        child: InkWell(
          onTap: () {
            context.read<ForumViewModel>().add(JoinForum(
                dto: JoinForumRequestDto(forumID: forumID, userID: userID)));
          },
          splashColor: AppColors.steel,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: verticalPadding, horizontal: horizontalPadding),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class JoinedForumButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final double bottomPadding;
  final double verticalPadding;
  final double horizontalPadding;
  const JoinedForumButton({
    super.key,
    this.onPressed,
    this.bottomPadding = 16,
    required this.title,
    required this.verticalPadding,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 12 : 8, vertical: isTablet ? 4 : 0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.3,
          color: AppColors.white.withOpacity(0.8),
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Material(
        color: AppColors.black,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        elevation: 4,
        child: InkWell(
          onTap: onPressed,
          splashColor: AppColors.steel,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: verticalPadding, horizontal: horizontalPadding),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: isTablet ? 13 : null,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
