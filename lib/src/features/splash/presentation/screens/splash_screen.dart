import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_constants.dart';
import 'package:forum/src/core/constants/media_query_values.dart';

import '../bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppConstants.animationTime),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();

    _timer = Timer(
      const Duration(milliseconds: AppConstants.navigateTime),
      () => context.read<SplashBloc>().add(StartUpEvent()),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashGetUserSuccessfully && state.user != null) {
          print("User Info ${state.user}");
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.home,
            (route) => false,
            arguments: state.user,
          );
        }
        if ((state is SplashGetUserSuccessfully && state.user == null) ||
            state is SplashGetUserFailed) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.welcome,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Container(
          width: context.width,
          height: context.height,
          margin: const EdgeInsets.only(bottom: 50),
          child: FadeTransition(
            opacity: _animation,
            child: Stack(
              children: [
                _buildSplashImage(),
                // _buildSplashBottomLogo(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Align _buildSplashBottomLogo(BuildContext context) {
  //   return Align(
  //     alignment: Alignment.bottomCenter,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         Text(
  //           AppStrings.from,
  //           style: Theme.of(context)
  //               .textTheme
  //               .titleMedium!
  //               .copyWith(color: AppColors.blackWith40Opacity),
  //         ),
  //         const Image(
  //           width: AppSize.s100,
  //           fit: BoxFit.contain,
  //           image: AssetImage(AppImages.metaLogo),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Align _buildSplashImage() {
    return const Align(
      alignment: Alignment.center,
      child: Image(
        width: 100,
        height: 100,
        fit: BoxFit.contain,
        image: AssetImage(AppImages.appLogo),
      ),
    );
  }
}
