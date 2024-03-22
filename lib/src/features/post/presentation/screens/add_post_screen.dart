import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:forum/src/core/widgets/input_fields/link_field.dart';
import 'package:forum/src/core/widgets/input_fields/title_field.dart';
import 'package:forum/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:forum/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:forum/src/features/post/presentation/bloc/post_bloc.dart';
import 'package:forum/src/features/post/presentation/widgets/button/post/post_button.dart';
import 'package:forum/src/features/post/presentation/widgets/post/forum_dropdown.dart';
import 'package:forum/src/features/post/presentation/widgets/post/forum_rules.dart';
import 'package:forum/src/features/post/presentation/widgets/post/post_type_icon.dart';

class AddPostScreen extends StatefulWidget {
  final User user;
  const AddPostScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _linkController;
  bool _showLinkField = false;
  File? _selectedImage;
  String? _selectedForumId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _linkController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void _onForumSelected(String forumId) {
    setState(() {
      _selectedForumId = forumId;
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
            context.read<HomeBloc>().add(const ChangeScreenModule(0));
          },
        ),
        actions: [
          PostButton(
            title: AppStrings.post,
            verticalPadding: 8,
            horizontalPadding: 14,
            onPressed: () {
              context.read<PostBloc>().add(
                    UploadPost(
                      dto: AddPostRequestDto(
                        caption: _titleController.text,
                        description: _descriptionController.text,
                        publisher: widget.user.userInfo.uid ?? "",
                        postLink: _linkController.text,
                        media: _selectedImage,
                        forumID: _selectedForumId,
                      ),
                    ),
                  );
            },
          )
        ],
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostUploading) {
            const CircularProgressIndicator();
          }
          if (state is PostUploadingSuccess) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.postSuccessfully,
            );
            context.read<HomeBloc>().add(const ChangeScreenModule(0));
          }
          if (state is PostUploadingFailed) {
            buildToast(
              toastType: ToastType.success,
              msg: state.message,
            );
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ForumDropdown(
                      onForumSelected: _onForumSelected,
                      userID: widget.user.userInfo.uid!,
                    ),
                    const ForumRules(title: AppStrings.rules),
                  ],
                ),
                SizedBox(height: isTablet ? 20 : 0),
                TitleField(
                  controller: _titleController,
                  title: AppStrings.titlePlaceholder,
                ),
                SizedBox(height: isTablet ? 20 : 0),
                if (_showLinkField)
                  LinkField(
                    controller: _linkController,
                    onPressed: () {
                      setState(() {
                        _showLinkField = !_showLinkField;
                      });
                    },
                  ),
                if (_selectedImage != null)
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height / 4,
                    child: Row(
                      children: [
                        Image(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 1.12,
                          fit: BoxFit.cover,
                          image: FileImage(_selectedImage!),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                DescriptionField(
                  controller: _descriptionController,
                  title: AppStrings.descPlaceholder,
                ),
                const Spacer(),
                Row(
                  children: [
                    PostTypeIcon(
                      icon: AppIcons.link,
                      height: isTablet ? 34 : 22,
                      onPressed: () {
                        setState(() {
                          _showLinkField = !_showLinkField;
                        });
                      },
                    ),
                    PostTypeIcon(
                      icon: AppIcons.gallery,
                      height: isTablet ? 34 : 22,
                      onPressed: () async {
                        AppPermissions.checkCameraPermission();
                        _selectedImage = await openGallery();
                        setState(() {});
                      },
                    ),
                    PostTypeIcon(
                      icon: AppIcons.youtube,
                      height: isTablet ? 34 : 22,
                    ),
                    PostTypeIcon(
                      icon: AppIcons.poll,
                      height: isTablet ? 34 : 22,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
