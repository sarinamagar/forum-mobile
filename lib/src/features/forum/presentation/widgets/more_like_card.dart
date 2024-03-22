import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/functions/build_toast.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/forum/presentation/viewmodels/forum_viewmodel.dart';
import 'package:forum/src/features/forum/presentation/widgets/forum_card.dart';

class MoreLikeCard extends StatefulWidget {
  final User user;
  const MoreLikeCard({Key? key, required this.user});

  @override
  State<MoreLikeCard> createState() => _MoreLikeCardState();
}

class _MoreLikeCardState extends State<MoreLikeCard> {
  int currentIndex = -1;
  int previousIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return BlocConsumer<ForumViewModel, ForumState>(
      listener: (context, state) {
        if (state is ForumsLoadingFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
      },
      buildWhen: (previous, current) {
        return current is ForumsLoadingSuccess || current is ForumLoading;
      },
      builder: (context, state) {
        List<Forum> forums = context.read<ForumViewModel>().forums;
        forums = forums.take(6).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "More like MyPeopleNeedMe",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: isTablet ? 24 : 16,
                      ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.white,
                    size: 15,
                  ),
                ),
              ],
            ),
            if (forums.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  height: isTablet ? 260 : 220,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: (forums.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      final startIndex = index * 2;
                      final endIndex = startIndex + 2;
                      return Column(
                        children: forums
                            .sublist(startIndex, endIndex)
                            .map((item) => SizedBox(
                                  width: isTablet
                                      ? MediaQuery.of(context).size.width * 0.48
                                      : MediaQuery.of(context).size.width * 0.8,
                                  child:
                                      ForumCard(forum: item, user: widget.user),
                                ))
                            .toList(),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 16);
                    },
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
