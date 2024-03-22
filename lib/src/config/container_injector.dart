import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:forum/src/core/network/connectivity_checker.dart';
import 'package:forum/src/core/network/hive_service.dart';
import 'package:forum/src/core/network/http_service.dart';
import 'package:forum/src/features/authentication/auth_injector.dart';
import 'package:forum/src/features/forum/forum_injector.dart';
import 'package:forum/src/features/home/home_injector.dart';
import 'package:forum/src/features/post/post_injector.dart';
import 'package:forum/src/features/profile/profile_injector.dart';
import 'package:forum/src/features/splash/presentation/splash_injector.dart';
import 'package:forum/src/features/topic/topic_injector.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> initApp() async {
  _initCore();
  initSplash();
  initAuth();
  initHome();
  initPost();
  initTopic();
  initForum();
  initProfile();
}

void _initCore() {
  sl.registerSingleton<Dio>(Dio());
  // add connectivity
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  // add checkInternetConnectivity
  sl.registerLazySingleton<BaseCheckInternetConnectivity>(
    () => CheckInternetConnectivity(connectivity: sl()),
  );
  sl.registerLazySingleton<HiveService>(() => HiveService());
  sl.registerLazySingleton<HttpService>(() => HttpService(Dio()));
}
