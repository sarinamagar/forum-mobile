import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/features/topic/domain/entities/topic.dart';
import 'package:forum/src/features/topic/presentation/viewmodels/topic_viewmodel.dart';

class TopicDropdown extends StatefulWidget {
  final void Function(String) onTopicSelected;
  const TopicDropdown({Key? key, required this.onTopicSelected})
      : super(key: key);

  @override
  State<TopicDropdown> createState() => _ForumDropdownState();
}

class _ForumDropdownState extends State<TopicDropdown> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return BlocProvider(
      create: (context) => sl<TopicViewModel>()..add(TopicLoadTopics()),
      child: BlocBuilder<TopicViewModel, TopicState>(
        builder: (context, state) {
          if (state is TopicsLoadingSuccess && state.topics.isNotEmpty) {
            return DropdownButton<String>(
              hint: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      AppImages.profileImage,
                      width: isTablet ? 38 : 26,
                      height: isTablet ? 38 : 26,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Select ${AppStrings.topic}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0,
                          fontSize: isTablet ? 20 : null,
                        ),
                  ),
                ],
              ),
              value: _selectedOption,
              onChanged: (String? newValue) {
                final selectedTopic =
                    state.topics.firstWhere((topic) => topic.name == newValue);
                setState(() {
                  _selectedOption = newValue;
                  widget.onTopicSelected(selectedTopic.id!);
                });
              },
              dropdownColor: Colors.black,
              elevation: 0,
              underline: Container(),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.white,
              ),
              items: state.topics.map<DropdownMenuItem<String>>((Topic topic) {
                return DropdownMenuItem<String>(
                  value: topic.name,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          AppImages.profileImage,
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          topic.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
                                  fontSize: isTablet ? 16 : null),
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
