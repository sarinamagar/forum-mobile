import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/utils/form_validator_util.dart';
import 'package:forum/src/core/widgets/button/custom_rounded_button.dart';
import 'package:forum/src/core/widgets/input_fields/custom_field.dart';
import 'package:forum/src/features/authentication/data/dto/verify_account/verify_acc_request_dto.dart';
import 'package:forum/src/features/authentication/presentation/bloc/authentication_bloc.dart';

class AccountVerificationForm extends StatefulWidget {
  final String email;
  const AccountVerificationForm({super.key, required this.email});

  @override
  State<AccountVerificationForm> createState() =>
      _AccountVerificationFormState();
}

class _AccountVerificationFormState extends State<AccountVerificationForm> {
  late final TextEditingController _otpController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        height: context.height / 1.42,
        child: Column(
          children: [
            Expanded(
              child: CustomTextField(
                textController: _otpController,
                label: AppStrings.otp,
                validator: (val) {
                  return FormValidator.validateOTP(val);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is VerifyAccountLoading) {
                    return const CupertinoActivityIndicator(
                      color: AppColors.white,
                      animating: true,
                    );
                  } else {
                    return CustomRoundedButton(
                      title: AppStrings.verify,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          VerifyAccRequestDto dto = VerifyAccRequestDto(
                            email: widget.email,
                            token: _otpController.text,
                          );
                          context
                              .read<AuthenticationBloc>()
                              .add(AuthVerifyAccount(dto: dto));
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
