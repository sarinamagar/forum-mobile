import 'package:flutter/material.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/features/post/presentation/widgets/button/post/post_button.dart';

class ForumRules extends StatelessWidget {
  final String title;
  final double font;
  const ForumRules({super.key, required this.title, this.font = 15});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: AppColors.cursed,
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(14),
            ),
          ),
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 0.3,
                            color: AppColors.white.withOpacity(0.6)),
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          color: AppColors.jupiter,
                          icon: const Icon(
                            Icons.close_outlined,
                            size: 28,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          "Forum rules",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTablet ? 20 : 16,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    AppStrings.rulesTitle,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.charcoal,
                        fontSize: isTablet ? 17 : 13),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      RuleTile(
                          number: '1',
                          rule:
                              'Questions must be clear and direct and may not use the body textbox'),
                      RuleTile(
                          number: '2',
                          rule: 'No personal or professional advice requests'),
                      RuleTile(number: '3', rule: 'Open ended questions only'),
                      RuleTile(number: '4', rule: 'No personal info'),
                    ],
                  ),
                  PostButton(
                    title: AppStrings.understand,
                    verticalPadding: 8,
                    horizontalPadding: 144,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        );
      },
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.blue,
              fontSize: isTablet ? 22 : font,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class RuleTile extends StatelessWidget {
  final String number;
  final String rule;

  const RuleTile({
    required this.number,
    required this.rule,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return ListTile(
      title: Text(
        'Rule $number - $rule',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: isTablet ? 20 : null),
      ),
    );
  }
}
