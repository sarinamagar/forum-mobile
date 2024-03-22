import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';

class DescriptionField extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const DescriptionField(
      {Key? key, required this.controller, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
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
            fontSize: isTablet ? 22 : null,
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w400,
              fontSize: isTablet ? 25 : 15,
            ),
      ),
    );
  }
}
