import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  final FormFieldValidator<String>? validator;
  const PasswordField(
      {Key? key, required this.passwordController, this.validator})
      : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return TextFormField(
      controller: widget.passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscurePassword,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: AppStrings.password,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.charcoal,
              fontSize: isTablet ? 18 : 14,
            ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
          child: Icon(
            obscurePassword
                ? Icons.remove_red_eye_outlined
                : Icons.remove_red_eye,
            color: AppColors.steel,
            size: isTablet ? 40 : null,
          ),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.white,
            fontSize: isTablet ? 25 : 15,
          ),
    );
  }
}
