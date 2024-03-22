import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/constants/app_permissions.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/functions/build_toast.dart';
import 'package:forum/src/core/functions/open_gallery.dart';
import 'package:forum/src/core/widgets/input_fields/description_field.dart';
import 'package:forum/src/core/widgets/input_fields/title_field.dart';
import 'package:forum/src/features/forum/data/dto/create_forum/create_forum_request_dto.dart';
import 'package:forum/src/features/forum/presentation/screens/select_image.dart';
import 'package:forum/src/features/forum/presentation/viewmodels/forum_viewmodel.dart';
import 'package:forum/src/features/forum/presentation/widgets/topic_dropdown.dart';
import 'package:forum/src/features/post/presentation/widgets/button/post/post_button.dart';

class CreateForumScreen extends StatefulWidget {
  final User user;
  const CreateForumScreen({super.key, required this.user});

  @override
  State<CreateForumScreen> createState() => _CreateForumScreenState();
}

class _CreateForumScreenState extends State<CreateForumScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  File? _icon;
  File? _cover;
  bool switchValue = false;
  String? _selectedTopicId;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onTopicSelected(String topicId) {
    setState(() {
      _selectedTopicId = topicId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: AppColors.jupiter,
          icon: Icon(
            Icons.close_outlined,
            size: isTablet ? 32 : 28,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        titleSpacing: isTablet ? 12 : 0,
        title: Text(
          AppStrings.createForum,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: isTablet ? 20 : null,
              ),
        ),
        actions: [
          PostButton(
            title: AppStrings.create,
            verticalPadding: 8,
            horizontalPadding: 10,
            onPressed: () {
              context.read<ForumViewModel>().add(CreateForum(
                    dto: CreateForumRequestDto(
                      forumName: _titleController.text,
                      description: _descriptionController.text,
                      createdBy: widget.user.userInfo.uid ?? "",
                      topics: _selectedTopicId,
                      isNSFW: switchValue,
                      icon: _icon,
                      cover: _cover,
                    ),
                  ));
            },
          )
        ],
      ),
      body: BlocConsumer<ForumViewModel, ForumState>(
        listener: (context, state) {
          if (state is CreatingForum) {
            const CircularProgressIndicator();
          }
          if (state is CreateForumSuccess) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.forumSuccess,
            );
            Navigator.of(context).pushNamed(
              AppRoutes.viewForum,
              arguments: ForumScreensArgs(
                userInfo: widget.user,
                forum: state.forum,
              ),
            );
          }
          if (state is CreateForumFailed) {
            buildToast(
              toastType: ToastType.success,
              msg: state.message,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopicDropdown(onTopicSelected: _onTopicSelected),
                  TitleField(
                    controller: _titleController,
                    title: AppStrings.forumName,
                  ),
                  SizedBox(height: isTablet ? 20 : 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.forumNSFW,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: isTablet ? 20 : null,
                                ),
                      ),
                      Switch(
                        trackColor: MaterialStateProperty.all(
                            AppColors.blackWith50Opacity),
                        activeColor: AppColors.anchor,
                        inactiveThumbColor: AppColors.charcoal,
                        value: switchValue,
                        onChanged: (value) {
                          setState(() {
                            switchValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                  DescriptionField(
                    controller: _descriptionController,
                    title: AppStrings.forumDes,
                  ),
                  SizedBox(height: isTablet ? 10 : 0),
                  SelectImage(
                    title: "${AppStrings.select} ${AppStrings.icon}",
                    icon: AppIcons.icon,
                    onPressed: () async {
                      AppPermissions.checkCameraPermission();
                      _icon = await openGallery();
                      setState(() {});
                    },
                  ),
                  SizedBox(height: isTablet ? 10 : 0),
                  SelectImage(
                    title: "${AppStrings.select} ${AppStrings.banner}",
                    icon: AppIcons.gallery,
                    onPressed: () async {
                      AppPermissions.checkCameraPermission();
                      _cover = await openGallery();
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
