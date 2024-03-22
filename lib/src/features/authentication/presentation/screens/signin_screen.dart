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
import 'package:forum/src/features/authentication/presentation/widgets/forms/signin_form.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;

    return Scaffold(
      appBar: const BuildAuthAppbar(
        authRoute: AppRoutes.signUp,
        authMethod: AppStrings.signUp,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthSignInError) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
          if (state is AuthSignInSuccess) {
            buildToast(toastType: ToastType.success, msg: AppStrings.loggedIn);
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.home, (route) => false,
                arguments: state.user);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: context.width,
              height: context.height,
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: isTablet ? 25 : null),
                  buildAuthMessage(
                    context,
                    AppStrings.loginTitle,
                  ),
                  const SizedBox(height: 25),
                  const ContinueWithGoogle(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: isTablet ? 24 : 14),
                    child: const OrSeperator(),
                  ),
                  const SignInForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
