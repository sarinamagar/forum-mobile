import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/functions/build_toast.dart';
import 'package:forum/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:forum/src/features/authentication/presentation/widgets/forms/acc_verify_form.dart';
import 'package:forum/src/features/authentication/presentation/widgets/build_auth_appbar.dart';
import 'package:forum/src/features/authentication/presentation/widgets/build_auth_message.dart';
import 'package:forum/src/features/authentication/presentation/widgets/otp_message.dart';

class VerifyAccountScreen extends StatelessWidget {
  final String email;
  const VerifyAccountScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAuthAppbar(
        authRoute: AppRoutes.noRoute,
        authMethod: AppStrings.help,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is VerifyAccountError) {
            buildToast(toastType: ToastType.error, msg: state.message);
          }
          if (state is VerifyAccountSuccess) {
            buildToast(toastType: ToastType.success, msg: AppStrings.verified);
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.signIn,
              (route) => false,
            );
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
                buildAuthMessage(
                  context,
                  AppStrings.verifyAccountTitle,
                ),
                const SizedBox(height: 10),
                otpMessage(context, AppStrings.verifyAccountInfo),
                const SizedBox(height: 30),
                AccountVerificationForm(
                  email: email,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
