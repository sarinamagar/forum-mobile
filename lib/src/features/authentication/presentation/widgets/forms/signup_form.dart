import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/utils/form_validator_util.dart';
import 'package:forum/src/core/widgets/button/custom_rounded_button.dart';
import 'package:forum/src/core/widgets/input_fields/email_field.dart';
import 'package:forum/src/core/widgets/input_fields/password_field.dart';
import 'package:forum/src/core/widgets/input_fields/username_field.dart';
import 'package:forum/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';
import 'package:forum/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:forum/src/features/authentication/presentation/widgets/user_agreement.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _usernameController;
  late final TextEditingController _confirmPassController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _confirmPassController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Form(
      key: _formKey,
      child: SizedBox(
        height: isTablet ? context.height / 1.30 : context.height / 1.48,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  EmailField(emailController: _emailController),
                  const SizedBox(height: 10),
                  UsernameField(usernameController: _usernameController),
                  const SizedBox(height: 10),
                  PasswordField(
                    passwordController: _passwordController,
                    validator: (val) {
                      return FormValidator.validatePassword(val);
                    },
                  ),
                  const SizedBox(height: 10),
                  PasswordField(
                    passwordController: _confirmPassController,
                    validator: (val) {
                      return FormValidator.validateConfirmPassword(
                        val,
                        _passwordController.text,
                      );
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  userAgreement(context),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state is AuthenticationSignUpLoading) {
                        return const CupertinoActivityIndicator(
                          color: AppColors.white,
                          animating: true,
                        );
                      } else {
                        return CustomRoundedButton(
                          title: AppStrings.continueBtn,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              SignUpRequestDto dto = SignUpRequestDto(
                                email: _emailController.text,
                                username: _usernameController.text,
                                password: _passwordController.text,
                              );
                              context
                                  .read<AuthenticationBloc>()
                                  .add(AuthSignUp(dto: dto));
                            }
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
