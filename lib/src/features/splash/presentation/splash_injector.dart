import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/features/splash/data/datasources/local/local_splash_data_source.dart';
import 'package:forum/src/features/splash/data/datasources/local/local_splash_data_source_impl.dart';
import 'package:forum/src/features/splash/data/datasources/remote/remote_splash_data_source.dart';
import 'package:forum/src/features/splash/data/datasources/remote/remote_splash_data_source_impl.dart';
import 'package:forum/src/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:forum/src/features/splash/domain/repositories/splash_repository.dart';
import 'package:forum/src/features/splash/domain/usecases/get_current_user_usecase.dart';
import 'package:forum/src/features/splash/presentation/bloc/splash_bloc.dart';

void initSplash() {
  sl.registerLazySingleton<LocalSplashDataSource>(
    () => LocalSplashDataSourceImpl(),
  );
  sl.registerLazySingleton<RemoteSplashDataSource>(
      () => RemoteSplashDataSourceImpl(dio: sl(), localSplashDataSource: sl()));

  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(
      remoteSplashDataSource: sl(),
      checkInternetConnectivity: sl(),
      localSplashDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(splashRepository: sl()),
  );
  sl.registerFactory<SplashBloc>(() => SplashBloc(getCurrentUser: sl()));
}
