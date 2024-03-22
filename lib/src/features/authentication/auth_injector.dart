import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/features/authentication/data/datasources/remote/auth_datasource.dart';
import 'package:forum/src/features/authentication/data/datasources/remote/auth_datasource_impl.dart';
import 'package:forum/src/features/authentication/data/repositories/auth_remote_repository.dart';
import 'package:forum/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:forum/src/features/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:forum/src/features/authentication/domain/usecases/send_reset_otp_usecase.dart';
import 'package:forum/src/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:forum/src/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:forum/src/features/authentication/domain/usecases/verify_account_usecase.dart';
import 'package:forum/src/features/authentication/presentation/bloc/authentication_bloc.dart';

void initAuth() {
  // add remote auth datasource
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(dio: sl()),
  );
  // add local auth datasource
  // sl.registerLazySingleton<AuthLocalDataSource>(
  //     () => AuthLocalDataSourceImpl(hive: sl()));

  // add remote auth repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRemoteRepositoryImpl(authDataSource: sl(), hiveService: sl()),
  );
  // sl.registerLazySingleton<AuthRepository>(
  //     () => AuthLocalRepositoryImpl(authLocalDataSource: sl()));

  // add remote auth usecases
  sl.registerLazySingleton<SignUpUsecase>(
      () => SignUpUsecase(authRepository: sl()));
  sl.registerLazySingleton<VerifyAccountUsecase>(
      () => VerifyAccountUsecase(authRepository: sl()));
  sl.registerLazySingleton<SignInUsecase>(
      () => SignInUsecase(authRepository: sl()));
  sl.registerLazySingleton<SendResetOtpUsecase>(
      () => SendResetOtpUsecase(authRepository: sl()));

  sl.registerLazySingleton<ResetPasswordUsecase>(
      () => ResetPasswordUsecase(authRepository: sl()));

  // add auth bloc
  sl.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(
      signUpUsecase: sl(),
      verifyAccountUsecase: sl(),
      signInUsecase: sl(),
      sendResetOtpUsecase: sl(),
      resetPasswordUsecase: sl(),
    ),
  );
}
