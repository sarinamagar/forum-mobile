import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/constants/app_permissions.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/functions/build_toast.dart';
import 'package:forum/src/core/functions/open_gallery.dart';
import 'package:forum/src/core/widgets/input_fields/custom_field.dart';
import 'package:forum/src/features/post/presentation/widgets/button/post/post_button.dart';
import 'package:forum/src/features/profile/data/dto/update_user_request_dto.dart';
import 'package:forum/src/features/profile/presentation/viewmodels/profile_viewmodel.dart';

class UpdateUserScreen extends StatefulWidget {
  final User user;
  const UpdateUserScreen({super.key, required this.user});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  late final TextEditingController _aboutController;
  late String gender;
  File? _avatar;

  @override
  void initState() {
    super.initState();
    _aboutController = TextEditingController();
    gender = widget.user.userInfo.gender ?? Gender.preferNotSay.name;
  }

  @override
  void dispose() {
    _aboutController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: AppColors.jupiter,
          icon: const Icon(
            Icons.close_outlined,
            size: 28,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "${AppStrings.edit} Profile",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
        ),
        actions: [
          PostButton(
            title: AppStrings.post,
            verticalPadding: 8,
            horizontalPadding: 14,
            onPressed: () {
              context.read<ProfileViewModel>().add(
                    UpdateUser(
                      dto: UpdateUserRequestDto(
                        userID: widget.user.userInfo.uid!,
                        bio: _aboutController.text,
                        gender: gender,
                        avatar: _avatar,
                      ),
                    ),
                  );
            },
          )
        ],
      ),
      body: BlocConsumer<ProfileViewModel, ProfileState>(
        listener: (context, state) {
          if (state is UpdatingUser) {
            const CircularProgressIndicator();
          }
          if (state is UpdateUserSuccess) {
            buildToast(
              toastType: ToastType.success,
              msg: AppStrings.postSuccessfully,
            );
            Navigator.of(context).pop();
          }
          if (state is UpdateUserFailed) {
            buildToast(
              toastType: ToastType.success,
              msg: state.message,
            );
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.black,
                        radius: 60,
                        child: widget.user.userInfo.avatarUrl != null &&
                                _avatar == null
                            ? ClipOval(
                                child: Image.network(
                                  widget.user.userInfo.avatarUrl!,
                                  width: 152,
                                  height: 152,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : _avatar != null
                                ? ClipOval(
                                    child: Image.file(
                                      _avatar!,
                                      width: 152,
                                      height: 152,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ClipOval(
                                    child: Image.asset(
                                      AppImages.appLogo,
                                      width: 112,
                                      height: 112,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            AppPermissions.checkCameraPermission();
                            _avatar = await openGallery();
                            setState(() {});
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.cursed,
                              border: Border.all(
                                color: AppColors.piano,
                                width: 2,
                              ),
                            ),
                            child: SvgPicture.asset(
                              AppIcons.edit,
                              colorFilter: const ColorFilter.mode(
                                AppColors.whiteWith40Opacity,
                                BlendMode.srcIn,
                              ),
                              height: 8,
                              width: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.profile,
                            height: 24.0,
                            width: 24.0,
                            colorFilter: const ColorFilter.mode(
                              AppColors.whiteWith40Opacity,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            AppStrings.gender,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.whiteWith40Opacity,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    DropdownButton<String>(
                      value: gender,
                      onChanged: (newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },
                      dropdownColor: Colors.black,
                      elevation: 0,
                      underline: Container(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.white,
                      ),
                      items: Gender.values.map((gender) {
                        return DropdownMenuItem<String>(
                          value: gender.name,
                          child: Text(
                            capitalize(gender.toString().split('.').last),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.whiteWith40Opacity,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
                                ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  textController: _aboutController,
                  label: "${AppStrings.about} You - optional",
                  maxLine: 5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
