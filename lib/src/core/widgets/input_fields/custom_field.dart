import 'package:flutter/material.dart';
import 'package:forum/src/core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textController;
  final String label;
  final int maxLine;
  final FormFieldValidator<String>? validator;
  const CustomTextField({
    super.key,
    required this.textController,
    required this.label,
    this.maxLine = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      keyboardType: TextInputType.text,
      validator: validator,
      maxLines: maxLine,
      decoration: InputDecoration(
        labelText: label,
        hintText: label,
        alignLabelWithHint: true,
      ),
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: AppColors.white, fontSize: 15),
    );
  }
}
