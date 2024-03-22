import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/features/home/data/datasources/local/home_local_datasource.dart';
import 'package:forum/src/features/home/data/datasources/local/home_local_datasource_impl.dart';
import 'package:forum/src/features/home/data/datasources/remote/home_datasource.dart';
import 'package:forum/src/features/home/data/datasources/remote/home_datasource_impl.dart';
import 'package:forum/src/features/home/data/repositories/home_remote_repository.dart';
import 'package:forum/src/features/home/domain/repositories/home_repository.dart';
import 'package:forum/src/features/home/domain/usecases/fetch_user_by_id_usecase.dart';
import 'package:forum/src/features/home/domain/usecases/load_posts_usecase.dart';
import 'package:forum/src/features/home/domain/usecases/signout_usecase.dart';
import 'package:forum/src/features/home/domain/usecases/update_status_usecase.dart';
import 'package:forum/src/features/home/presentation/bloc/home_bloc.dart';

void initHome() {
  sl.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDatasourceImpl());
  sl.registerLazySingleton<HomeRepository>(() => HomeRemoteRepository(
        homeDataSource: sl(),
        checkInternetConnectivity: sl(),
        homeLocalDataSource: sl(),
      ));
  sl.registerLazySingleton<LoadPostUsecase>(
      () => LoadPostUsecase(homeRepository: sl()));
  sl.registerLazySingleton<FetchUserByIdUsecase>(
      () => FetchUserByIdUsecase(homeRepository: sl()));
  sl.registerLazySingleton<UpdateStatusUsecase>(
      () => UpdateStatusUsecase(homeRepository: sl()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(homeRepository: sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(
        loadPostUsecase: sl(),
        fetchUserByIdUsecase: sl(),
        updateStatusUsecase: sl(),
        signOutUseCase: sl(),
      ));
}
