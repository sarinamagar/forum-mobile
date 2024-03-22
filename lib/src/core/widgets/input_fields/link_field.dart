import 'package:flutter/material.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';

class LinkField extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onPressed;

  const LinkField({Key? key, required this.controller, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      cursorColor: AppColors.blue,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: AppColors.black,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: AppStrings.linkPlaceholder,
        hintStyle: const TextStyle(color: AppColors.steel),
        suffixIcon: IconButton(
            icon: Icon(Icons.close, color: AppColors.steel),
            onPressed: onPressed),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
    );
  }
}
