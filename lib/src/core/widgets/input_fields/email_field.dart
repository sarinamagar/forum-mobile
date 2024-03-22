import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/utils/form_validator_util.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (val) {
        return FormValidator.validateEmail(val);
      },
      decoration: InputDecoration(
        labelText: AppStrings.email,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.charcoal,
              fontSize: isTablet ? 18 : 14,
            ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.white,
            fontSize: isTablet ? 25 : 15,
          ),
    );
  }
}
