import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/utils/text_utils.dart';

class FormValidator {
  static String? validateEmail(String? val, [bool supportEmpty = false]) {
    if (supportEmpty && (val == null || val.isEmpty)) {
      return null;
    } else if (val == null) {
      return ("Email ${AppStrings.fieldRequired}");
    } else if (val.isEmpty) {
      return ("Email ${AppStrings.fieldRequired}");
    } else if (TextUtils.validateEmail(val)) {
      return null;
    } else {
      return AppStrings.validEmail;
    }
  }

  static String? validatePassword(String? val, {String? label}) {
    if (val == null) {
      return ("Password ${AppStrings.fieldRequired}");
    } else if (val.isEmpty) {
      return ("Password ${AppStrings.fieldRequired}");
    } else if (val.length >= 6) {
      return null;
    } else {
      return (AppStrings.passwordLength);
    }
  }

  static String? validateConfirmPassword(
    String? val,
    String? newPassword,
  ) {
    if (val == null) {
      return ("Password ${AppStrings.fieldRequired}");
    } else if (val.isEmpty) {
      return ("Password ${AppStrings.fieldRequired}");
    } else if (val.length >= 6) {
      if (val == newPassword) {
        return null;
      } else {
        return AppStrings.passwordMatch;
      }
    } else {
      return (AppStrings.passwordLength);
    }
  }

  static String? validateName(String? val) {
    if (val == null) {
      return ("Username ${AppStrings.fieldRequired}");
    } else if (val.isEmpty) {
      return ("Username ${AppStrings.fieldRequired}");
    } else {
      return null;
    }
  }

  static String? validateOTP(String? val, {String? label}) {
    if (val == null) {
      return ("OTP Token ${AppStrings.fieldRequired}");
    } else if (val.isEmpty) {
      return ("OTP Token ${AppStrings.fieldRequired}");
    } else if (val.length == 8) {
      return null;
    } else {
      return AppStrings.otpLength;
    }
  }

  static String? validateTitle(String? val) {
    if (val == null) {
      return ("Title ${AppStrings.fieldRequired}");
    } else if (val.isEmpty) {
      return ("Title ${AppStrings.fieldRequired}");
    } else {
      return null;
    }
  }
}
