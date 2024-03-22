import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';

class HomeActions extends StatelessWidget {
  final User user;
  final Widget? filterIcon;
  final Widget? dropIcon;
  final VoidCallback? firstIconOnPressed;
  final VoidCallback? secondIconOnPressed;

  const HomeActions({
    Key? key,
    required this.user,
    this.filterIcon,
    this.dropIcon,
    this.firstIconOnPressed,
    this.secondIconOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Row(
      children: [
        SvgPicture.asset(
          AppIcons.search,
          height: isTablet ? 32 : 22.0,
          width: isTablet ? 32 : 24.0,
          colorFilter: const ColorFilter.mode(
            AppColors.jupiter,
            BlendMode.srcIn,
          ),
        ),
        if (filterIcon != null)
          GestureDetector(
            onTap: firstIconOnPressed,
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 4),
              child: filterIcon,
            ),
          ),
        if (dropIcon != null)
          GestureDetector(
            onTap: secondIconOnPressed,
            child: Container(
              margin: const EdgeInsets.only(left: 4, right: 2),
              child: dropIcon,
            ),
          ),
        GestureDetector(
          onTap: () {
            Scaffold.of(context).openEndDrawer();
          },
          child: Container(
            margin: EdgeInsets.only(left: isTablet ? 20 : 8, right: 4),
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.piano,
                  radius: isTablet ? 36 : 16,
                  child: user.userInfo.avatarUrl != null
                      ? ClipOval(
                          child: Image.network(
                            user.userInfo.avatarUrl!,
                            width: isTablet ? 52 : 32,
                            height: isTablet ? 52 : 32,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipOval(
                          child: Image.asset(
                            AppImages.appLogo,
                            width: isTablet ? 52 : 32,
                            height: isTablet ? 52 : 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                if (user.userInfo.status == "online")
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: isTablet ? 32 : 10,
                      height: isTablet ? 18 : 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        border: Border.all(
                          color: AppColors.piano,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
