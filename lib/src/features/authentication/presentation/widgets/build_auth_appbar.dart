import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';

class BuildAuthAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String authRoute;
  final String authMethod;
  final double topPadding;

  const BuildAuthAppbar({
    Key? key,
    required this.authRoute,
    required this.authMethod,
    this.topPadding = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;

    return Container(
      color: AppColors.black,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: AppBar(
        flexibleSpace: Center(
          child: Image(
            image: const AssetImage(AppImages.appLogo),
            height: isTablet ? 150 : 50,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 6),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(authRoute, (route) => true);
              },
              child: Text(authMethod,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.white,
                        fontSize: isTablet ? 24 : null,
                      )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
