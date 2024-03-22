import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/utils/form_validator_util.dart';
import 'package:forum/src/core/widgets/button/custom_rounded_button.dart';
import 'package:forum/src/core/widgets/input_fields/password_field.dart';
import 'package:forum/src/core/widgets/input_fields/username_field.dart';
import 'package:forum/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:forum/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:forum/src/features/authentication/presentation/widgets/user_agreement.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    final _theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Container(
        height: isTablet ? context.height / 1.36 : context.height / 1.48,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UsernameField(usernameController: _usernameController),
                  const SizedBox(height: 10),
                  PasswordField(
                    passwordController: _passwordController,
                    validator: (val) {
                      return FormValidator.validatePassword(val);
                    },
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.forgotPassword,
                        );
                      },
                      child: Text(
                        AppStrings.forgotPassword,
                        style: _theme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.red,
                          fontSize: isTablet ? 20 : null,
                        ),
                      ),
                    ),
                  )
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
                      if (state is AuthSignInLoading) {
                        return const CupertinoActivityIndicator(
                          color: AppColors.white,
                          animating: true,
                        );
                      } else {
                        return CustomRoundedButton(
                          title: AppStrings.continueBtn,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              SignInRequestDto dto = SignInRequestDto(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              );
                              context
                                  .read<AuthenticationBloc>()
                                  .add(AuthSignIn(dto: dto));
                            }
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
