import 'package:flutter/material.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/widgets/button/custom_rounded_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool isTablet = constraints.maxWidth >= tabletBreakpoint;
          return Container(
            width: context.width,
            height: context.mainHeight,
            padding: EdgeInsets.all(isTablet ? 40 : 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: isTablet ? 150 : 80,
                  image: const AssetImage(AppImages.appLogo),
                ),
                SizedBox(height: isTablet ? 100 : 50),
                CustomRoundedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.signUp);
                  },
                  title: AppStrings.signUp,
                ),
                SizedBox(height: isTablet ? 20 : 8),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.signIn);
                  },
                  child: Text(
                    AppStrings.login,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: isTablet ? 24 : null,
                        ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
