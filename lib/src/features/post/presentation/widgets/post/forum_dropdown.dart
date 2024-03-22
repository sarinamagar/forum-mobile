import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/forum/presentation/viewmodels/forum_viewmodel.dart';

class ForumDropdown extends StatefulWidget {
  final String userID;
  final void Function(String) onForumSelected;
  const ForumDropdown(
      {Key? key, required this.onForumSelected, required this.userID})
      : super(key: key);

  @override
  State<ForumDropdown> createState() => _ForumDropdownState();
}

class _ForumDropdownState extends State<ForumDropdown> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return BlocProvider(
      create: (context) =>
          sl<ForumViewModel>()..add(LoadJoinedForum(userID: widget.userID)),
      child: BlocBuilder<ForumViewModel, ForumState>(
        builder: (context, state) {
          if (state is JoinedForumsSuccess && state.forums.isNotEmpty) {
            return DropdownButton<String>(
              hint: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      AppImages.appLogo,
                      width: isTablet ? 38 : 26,
                      height: isTablet ? 38 : 26,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Select ${AppStrings.forum}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0,
                        fontSize: isTablet ? 20 : null),
                  ),
                ],
              ),
              value: _selectedOption,
              onChanged: (String? newValue) {
                final selectedForum = state.forums
                    .firstWhere((forum) => forum.forumName == newValue);
                setState(() {
                  _selectedOption = newValue;
                  widget.onForumSelected(selectedForum.id!);
                });
              },
              dropdownColor: Colors.black,
              elevation: 0,
              underline: Container(),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.white,
                size: isTablet ? 38 : null,
              ),
              items: state.forums.map<DropdownMenuItem<String>>((Forum forum) {
                return DropdownMenuItem<String>(
                  value: forum.forumName,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                        child: (forum.iconUrl != null)
                            ? Image.network(
                                forum.iconUrl!,
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                AppImages.appLogo,
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(width: isTablet ? 12 : 8),
                      Flexible(
                        child: Text(
                          forum.forumName!,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0,
                                    fontSize: isTablet ? 16 : null,
                                  ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
