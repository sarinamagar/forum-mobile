import 'package:flutter/material.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/config/app_routes/app_router.dart';
import 'package:forum/src/config/app_theme/app_theme.dart';

const double tabletBreakpoint = 600;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.generateRoute,
      theme: AppTheme.getApplicationTheme(isDark: false),
    );
  }
}
