import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/features/profile/presentation/widgets/about_widget.dart';

class AboutScreen extends StatelessWidget {
  final User user;
  const AboutScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: AboutWidget(user: user),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          child: Text(
            user.userInfo.bio ?? "2002",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.jupiter,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0,
                ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.following,
                      height: isTablet ? 32 : 25.0,
                      width: isTablet ? 32 : 25.0,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      "${user.followers} ${AppStrings.followers}",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.jupiter,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                            fontSize: isTablet ? 20 : null,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.follow,
                      height: 22.0,
                      width: 22.0,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      "${user.following} ${AppStrings.following}",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.jupiter,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                            fontSize: isTablet ? 20 : null,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
