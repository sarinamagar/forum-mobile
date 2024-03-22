import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_strings.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/features/forum/presentation/viewmodels/forum_viewmodel.dart';
import 'package:forum/src/features/forum/presentation/widgets/more_like_card.dart';
import 'package:forum/src/features/forum/presentation/widgets/topic_chart.dart';
import 'package:forum/src/features/home/presentation/widgets/home/home_app_bar.dart';
import 'package:forum/src/features/home/presentation/widgets/home/home_drawer.dart';
import 'package:forum/src/features/home/presentation/widgets/home/home_end_drawer.dart';
import 'package:forum/src/features/topic/presentation/viewmodels/topic_viewmodel.dart';

class ForumScreen extends StatelessWidget {
  final User user;
  const ForumScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<TopicViewModel>()..add(TopicLoadTopics()),
        ),
        BlocProvider(
          create: (context) => sl<ForumViewModel>()..add(LoadForums()),
        ),
      ],
      child: Scaffold(
        appBar: HomeAppBar(user: user, title: AppStrings.forums),
        drawer: HomeDrawer(user: user),
        endDrawer: HomeEndDrawer(user: user),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 10, vertical: isTablet ? 20 : 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MoreLikeCard(user: user),
                  const SizedBox(height: 14),
                  TopicChart(user: user),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
