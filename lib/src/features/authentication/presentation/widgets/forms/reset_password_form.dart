import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/utils/form_validator_util.dart';
import 'package:forum/src/core/widgets/button/custom_rounded_button.dart';
import 'package:forum/src/core/widgets/input_fields/custom_field.dart';
import 'package:forum/src/core/widgets/input_fields/password_field.dart';
import 'package:forum/src/features/authentication/data/dto/reset_password/reset_password_request_dto.dart';
import 'package:forum/src/features/authentication/presentation/bloc/authentication_bloc.dart';

class ResetPasswordForm extends StatefulWidget {
  final String email;
  const ResetPasswordForm({super.key, required this.email});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  late final TextEditingController _passwordController;
  late final TextEditingController _otpController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        height: context.height / 1.35,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  PasswordField(
                    passwordController: _passwordController,
                    validator: (val) {
                      return FormValidator.validatePassword(val);
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    textController: _otpController,
                    label: AppStrings.otp,
                    validator: (val) {
                      return FormValidator.validateOTP(val);
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is ResetPasswordLoading) {
                    return const CupertinoActivityIndicator(
                      color: AppColors.white,
                      animating: true,
                    );
                  } else {
                    return CustomRoundedButton(
                      title: AppStrings.continueBtn,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ResetPasswordRequestDto dto = ResetPasswordRequestDto(
                            email: widget.email,
                            password: _passwordController.text,
                            token: _otpController.text,
                          );
                          context
                              .read<AuthenticationBloc>()
                              .add(AuthResetPassword(dto: dto));
                        }
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
