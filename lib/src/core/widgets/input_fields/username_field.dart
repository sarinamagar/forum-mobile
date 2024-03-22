import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/utils/form_validator_util.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController usernameController;

  const UsernameField({super.key, required this.usernameController});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return TextFormField(
      controller: usernameController,
      keyboardType: TextInputType.name,
      validator: (val) {
        return FormValidator.validateName(val);
      },
      decoration: InputDecoration(
        labelText: AppStrings.username,
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
