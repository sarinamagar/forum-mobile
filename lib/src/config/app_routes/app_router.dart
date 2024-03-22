import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/config/app_routes/no_route_found.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:forum/src/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:forum/src/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:forum/src/features/authentication/presentation/screens/signin_screen.dart';
import 'package:forum/src/features/authentication/presentation/screens/signup_screen.dart';
import 'package:forum/src/features/authentication/presentation/screens/verify_account_screen.dart';
import 'package:forum/src/features/forum/presentation/screens/create_forum_screen.dart';
import 'package:forum/src/features/forum/presentation/screens/forums_screen.dart';
import 'package:forum/src/features/forum/presentation/screens/topic_forums_screen.dart';
import 'package:forum/src/features/forum/presentation/screens/view_forum_screen.dart';
import 'package:forum/src/features/forum/presentation/viewmodels/forum_viewmodel.dart';
import 'package:forum/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:forum/src/features/home/presentation/screens/home_screen.dart';
import 'package:forum/src/features/post/presentation/bloc/post_bloc.dart';
import 'package:forum/src/features/post/presentation/screens/add_comment_screen.dart';
import 'package:forum/src/features/post/presentation/screens/add_post_screen.dart';
import 'package:forum/src/features/post/presentation/screens/view_post_screen.dart';
import 'package:forum/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:forum/src/features/profile/presentation/screens/update_user_screen.dart';
import 'package:forum/src/features/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:forum/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:forum/src/features/splash/presentation/screens/splash_screen.dart';
import 'package:forum/src/features/splash/presentation/screens/welcome_screen.dart';
import 'package:forum/src/features/topic/presentation/viewmodels/topic_viewmodel.dart';

class AppRouter {
  AppRouter._();
  static final _authBloc = sl<AuthenticationBloc>();
  static final _postBloc = sl<PostBloc>();
  static final _forumBloc = sl<ForumViewModel>();
  static final _profileBloc = sl<ProfileViewModel>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.root:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<SplashBloc>(),
            child: const SplashScreen(),
          ),
        );
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<SplashBloc>(),
            child: const SplashScreen(),
          ),
        );
      case AppRoutes.welcome:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthenticationBloc>(
            create: (context) => _authBloc,
            child: const WelcomeScreen(),
          ),
        );
      case AppRoutes.signUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthenticationBloc>.value(
            value: _authBloc,
            child: const SignupScreen(),
          ),
        );
      case AppRoutes.verifyAccount:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthenticationBloc>.value(
            value: _authBloc,
            child: VerifyAccountScreen(email: settings.arguments as String),
          ),
        );
      case AppRoutes.signIn:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthenticationBloc>.value(
            value: _authBloc,
            child: const SigninScreen(),
          ),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthenticationBloc>.value(
            value: _authBloc,
            child: const ForgotPasswordScreen(),
          ),
        );
      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthenticationBloc>.value(
            value: _authBloc,
            child: ResetPasswordScreen(
              email: settings.arguments as String,
            ),
          ),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<HomeBloc>()..add(HomeLoadPosts()),
              ),
              BlocProvider(create: (context) => sl<PostBloc>()),
            ],
            child: HomeScreen(user: settings.arguments as User),
          ),
        );
      case AppRoutes.viewPost:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostBloc>.value(
            value: _postBloc,
            child: ViewPostScreen(
              postScreensArgs: settings.arguments as PostScreensArgs,
            ),
          ),
        );
      case AppRoutes.addPost:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostBloc>.value(
            value: _postBloc,
            child: AddPostScreen(user: settings.arguments as User),
          ),
        );
      case AppRoutes.addComment:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostBloc>.value(
            value: _postBloc,
            child: AddCommentScreen(
              postScreensArgs: settings.arguments as PostScreensArgs,
            ),
          ),
        );
      case AppRoutes.forums:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<TopicViewModel>()..add(TopicLoadTopics()),
            child: ForumScreen(user: settings.arguments as User),
          ),
        );

      case AppRoutes.topicForums:
        return MaterialPageRoute(
          builder: (context) => TopicForumScreen(
              forumScreensArgs: settings.arguments as ForumScreensArgs),
        );
      case AppRoutes.viewForum:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<ForumViewModel>.value(
                value: _forumBloc,
              ),
              BlocProvider(create: (context) => sl<PostBloc>()),
            ],
            child: ViewForumScreen(
              forumScreensArgs: settings.arguments as ForumScreensArgs,
            ),
          ),
        );
      case AppRoutes.createForum:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ForumViewModel>.value(
            value: _forumBloc,
            child: CreateForumScreen(user: settings.arguments as User),
          ),
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<ProfileViewModel>.value(
                value: _profileBloc,
              ),
              BlocProvider(create: (context) => sl<PostBloc>()),
            ],
            child: ProfileScreen(user: settings.arguments as User),
          ),
        );
      case AppRoutes.updateProfile:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ProfileViewModel>.value(
            value: _profileBloc,
            child: UpdateUserScreen(user: settings.arguments as User),
          ),
        );
      case AppRoutes.noRoute:
        return MaterialPageRoute(
          builder: (context) => const NoRouteFound(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NoRouteFound(),
        );
    }
  }
}
