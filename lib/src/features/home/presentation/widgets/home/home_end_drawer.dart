import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:forum/src/features/home/presentation/widgets/home/status_button.dart';
import 'package:forum/src/features/profile/presentation/widgets/about_widget.dart';

class HomeEndDrawer extends StatelessWidget {
  final User user;
  const HomeEndDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Drawer(
          backgroundColor: AppColors.black,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.black,
                radius: isTablet ? 160 : 120,
                child: user.userInfo.avatarUrl != null
                    ? ClipOval(
                        child: Image.network(
                          user.userInfo.avatarUrl!,
                          width: isTablet ? 218 : 152,
                          height: isTablet ? 218 : 152,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipOval(
                        child: Image.asset(
                          AppImages.appLogo,
                          width: 112,
                          height: 112,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "u/${user.userInfo.username}",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: isTablet ? 25 : 16,
                        ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.whiteWith40Opacity,
                    size: isTablet ? 35 : 25,
                  ),
                ],
              ),
              StatusButton(
                  status: context.read<HomeBloc>().status,
                  userId: user.userInfo.uid!),
              const SizedBox(height: 8),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.6,
                        color: AppColors.graphite,
                      ),
                    ),
                  ),
                  child: AboutWidget(
                    user: user,
                  )),
              const SizedBox(height: 10),
              EndDrawerTile(
                iconName: AppIcons.profile,
                title: AppStrings.profile,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.profile, arguments: user);
                },
              ),
              EndDrawerTile(
                iconName: AppIcons.forumUnselected,
                title: AppStrings.createForum,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.createForum,
                    arguments: user,
                  );
                },
              ),
              const EndDrawerTile(
                  iconName: AppIcons.bookmark, title: AppStrings.saved),
              const EndDrawerTile(
                  iconName: AppIcons.history, title: AppStrings.history),
              const Spacer(),
              const EndDrawerTile(
                  iconName: AppIcons.settings, title: AppStrings.settings),
            ],
          ),
        ),
      ),
    );
  }
}

class EndDrawerTile extends StatelessWidget {
  final String iconName;
  final String title;
  final Function()? onPressed;
  const EndDrawerTile(
      {super.key, required this.iconName, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            SvgPicture.asset(
              iconName,
              height: isTablet ? 35 : 24.0,
              width: 24.0,
              colorFilter: const ColorFilter.mode(
                AppColors.shadow,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: isTablet ? 15 : 10),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.anchor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                    fontSize: isTablet ? 20 : null,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
