import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/features/home/presentation/bloc/home_bloc.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({Key? key});
  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        int currentIndex = 0;
        if (state is ScreenModuleChanged) {
          currentIndex = state.index;
        }
        return BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.black,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.charcoal,
          selectedLabelStyle: TextStyle(
            fontSize: isTablet ? 16 : 11,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: isTablet ? 16 : 11,
            fontWeight: FontWeight.w500,
          ),
          onTap: (index) {
            context.read<HomeBloc>().add(ChangeScreenModule(index));
          },
          items: [
            _bottomNavIcon(AppIcons.homeUnselected, AppIcons.homeSelected,
                AppStrings.home),
            _bottomNavIcon(AppIcons.forumUnselected, AppIcons.forumSelected,
                AppStrings.forums),
            _bottomNavIcon(AppIcons.create, AppIcons.create, AppStrings.create),
            _bottomNavIcon(AppIcons.chatUnselected, AppIcons.chatSelected,
                AppStrings.chat),
            _bottomNavIcon(AppIcons.notificationUnselected,
                AppIcons.notificationSelected, AppStrings.inbox),
          ],
        );
      },
    );
  }
}

BottomNavigationBarItem _bottomNavIcon(
    String unselectedIconPath, String selectedIconPath, String label) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(
      unselectedIconPath,
      height: 24.0,
      width: 24.0,
      colorFilter: const ColorFilter.mode(
        AppColors.shadow,
        BlendMode.srcIn,
      ),
    ),
    activeIcon: SvgPicture.asset(
      selectedIconPath,
      height: 24.0,
      width: 24.0,
      colorFilter: const ColorFilter.mode(
        AppColors.jupiter,
        BlendMode.srcIn,
      ),
    ),
    label: label,
  );
}
