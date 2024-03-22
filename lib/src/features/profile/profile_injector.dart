import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/features/profile/data/datasources/remote/profile_data_source.dart';
import 'package:forum/src/features/profile/data/datasources/remote/profile_data_source_impl.dart';
import 'package:forum/src/features/profile/data/repositories/profile_remote_repository.dart';
import 'package:forum/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:forum/src/features/profile/domain/usecases/update_user_usecase.dart';
import 'package:forum/src/features/profile/domain/usecases/user_posts_usecase.dart';
import 'package:forum/src/features/profile/presentation/viewmodels/profile_viewmodel.dart';

void initProfile() {
  sl.registerLazySingleton<ProfileDataSource>(
      () => ProfileDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRemoteRepository(profileDataSource: sl()));
  sl.registerLazySingleton<UserPostUsecase>(
      () => UserPostUsecase(profileRepository: sl()));
  sl.registerLazySingleton<UpdateUserUsecase>(
      () => UpdateUserUsecase(profileRepository: sl()));
  sl.registerFactory<ProfileViewModel>(
    () => ProfileViewModel(userPostUsecase: sl(), updateUserUsecase: sl()),
  );
}
