import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/features/forum/presentation/screens/forums_screen.dart';
import 'package:forum/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:forum/src/features/home/presentation/widgets/home/home_app_bar.dart';
import 'package:forum/src/features/home/presentation/widgets/home/home_body.dart';
import 'package:forum/src/features/home/presentation/widgets/home/home_bottom_nav_bar.dart';
import 'package:forum/src/features/home/presentation/widgets/home/home_drawer.dart';
import 'package:forum/src/features/home/presentation/widgets/home/home_end_drawer.dart';
import 'package:forum/src/features/post/presentation/screens/add_post_screen.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    print("User Information $user");
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return current is ScreenModuleChanged;
      },
      builder: (context, state) {
        context.read<HomeBloc>().userStatus = user.userInfo.status!;
        return Scaffold(
          appBar: state is ScreenModuleChanged && state.index != 0
              ? null
              : HomeAppBar(
                  user: user,
                  title: "Home",
                ),
          drawer: HomeDrawer(user: user),
          endDrawer: HomeEndDrawer(user: user),
          body: state is! ScreenModuleChanged
              ? HomeBody(user: user)
              : _getHomeBodyModule(state.index),
          bottomNavigationBar: state is ScreenModuleChanged && state.index == 2
              ? null
              : const HomeBottomNavBar(),
        );
      },
    );
  }

  Widget _getHomeBodyModule(int index) {
    switch (index) {
      case 0:
        return HomeBody(user: user);
      case 1:
        return ForumScreen(user: user);
      case 2:
        return AddPostScreen(user: user);
      // case 3:
      //   return const ShoppingScreen();
      // case 4:
      //   return ProfileScreen(personInfo: person.personInfo);
      default:
        return HomeBody(user: user);
    }
  }
}
