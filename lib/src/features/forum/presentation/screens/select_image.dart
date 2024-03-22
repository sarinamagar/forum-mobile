import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/features/post/presentation/widgets/post/post_type_icon.dart';

class SelectImage extends StatelessWidget {
  final String title;
  final String icon;
  final Function()? onPressed;
  const SelectImage(
      {super.key, required this.title, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            PostTypeIcon(
              icon: icon,
              padding: 0,
              height: isTablet ? 32 : 24,
              onPressed: () {},
            ),
            const SizedBox(width: 14),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.gray,
                    fontWeight: FontWeight.w500,
                    fontSize: isTablet ? 22 : 16,
                    letterSpacing: 0,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
