import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/features/home/presentation/widgets/home/home_app_bar_actions.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;
  final String title;
  const HomeAppBar({
    Key? key,
    required this.user,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            color: AppColors.jupiter,
            icon: Icon(
              Icons.menu_sharp,
              size: isTablet ? 36 : 28,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: isTablet ? 25 : 15,
            ),
      ),
      titleSpacing: isTablet ? 20 : 0,
      actions: [
        HomeActions(user: user),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
