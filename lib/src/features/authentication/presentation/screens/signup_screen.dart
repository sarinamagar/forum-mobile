import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/functions/build_toast.dart';
import 'package:forum/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:forum/src/features/authentication/presentation/widgets/build_auth_appbar.dart';
import 'package:forum/src/features/authentication/presentation/widgets/build_auth_message.dart';
import 'package:forum/src/features/authentication/presentation/widgets/contine_with_google.dart';
import 'package:forum/src/features/authentication/presentation/widgets/or_seperator.dart';
import 'package:forum/src/features/authentication/presentation/widgets/forms/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Scaffold(
      appBar: const BuildAuthAppbar(
        authRoute: AppRoutes.signIn,
        authMethod: AppStrings.login,
        topPadding: 14,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthSignupError) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
          if (state is AuthSignUpSuccess) {
            buildToast(
                toastType: ToastType.success, msg: AppStrings.userCreated);
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.verifyAccount,
              (route) => false,
              arguments: state.user.userInfo.email,
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: context.width,
              height: context.mainHeight,
              alignment: Alignment.center,
              child: Column(
                children: [
                  buildAuthMessage(context, AppStrings.welcomeMsg),
                  const SizedBox(height: 25),
                  const ContinueWithGoogle(),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 14),
                    child: const OrSeperator(),
                  ),
                  const SignupForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
