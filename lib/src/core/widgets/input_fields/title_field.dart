import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/utils/form_validator_util.dart';

class TitleField extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const TitleField({Key? key, required this.controller, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      validator: (val) {
        return FormValidator.validateTitle(val);
      },
      cursorColor: AppColors.blue,
      decoration: InputDecoration(
        fillColor: AppColors.black,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: title,
        hintStyle: TextStyle(
          color: AppColors.steel,
          fontSize: isTablet ? 28 : null,
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w800,
            fontSize: isTablet ? 28 : 20,
          ),
    );
  }
}
