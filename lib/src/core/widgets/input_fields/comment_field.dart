import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';

class CommentField extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onPressed;

  const CommentField({Key? key, required this.controller, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return TextField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      cursorColor: AppColors.blue,
      textAlignVertical: TextAlignVertical.center,
      decoration: const InputDecoration(
        fillColor: AppColors.black,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: AppStrings.comment,
        hintStyle: TextStyle(color: AppColors.steel),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.steel,
            fontWeight: FontWeight.w400,
            fontSize: isTablet ? 22 : 15,
          ),
    );
  }
}
