import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/widgets/button/custom_rounded_button.dart';
import 'package:forum/src/core/widgets/input_fields/email_field.dart';
import 'package:forum/src/features/authentication/presentation/bloc/authentication_bloc.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  late final TextEditingController _emailController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
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
              child: EmailField(emailController: _emailController),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is SendResetOtpLoading) {
                    return const CupertinoActivityIndicator(
                      color: AppColors.white,
                      animating: true,
                    );
                  } else {
                    return CustomRoundedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthenticationBloc>().add(
                              AuthSendResetOtp(email: _emailController.text));
                        }
                      },
                      title: AppStrings.continueBtn,
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
