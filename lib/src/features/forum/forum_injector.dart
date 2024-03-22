import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/features/forum/data/datasources/local/forum_local_datasource.dart';
import 'package:forum/src/features/forum/data/datasources/local/forum_local_datasource_impl.dart';
import 'package:forum/src/features/forum/data/datasources/remote/forum_datasource.dart';
import 'package:forum/src/features/forum/data/datasources/remote/forum_datasource_impl.dart';
import 'package:forum/src/features/forum/data/repositories/forum_remote_repository.dart';
import 'package:forum/src/features/forum/domain/repositories/forum_repository.dart';
import 'package:forum/src/features/forum/domain/usecases/create_forum_usecase.dart';
import 'package:forum/src/features/forum/domain/usecases/forum_posts_usecase.dart';
import 'package:forum/src/features/forum/domain/usecases/join_forum_usecase.dart';
import 'package:forum/src/features/forum/domain/usecases/load_forums_usecase.dart';
import 'package:forum/src/features/forum/domain/usecases/load_joined_forums_usecase.dart';
import 'package:forum/src/features/forum/domain/usecases/topic_forums_usecase.dart';
import 'package:forum/src/features/forum/presentation/viewmodels/forum_viewmodel.dart';

void initForum() {
  sl.registerLazySingleton<ForumDataSource>(
      () => ForumDatasourceImpl(dio: sl()));
  sl.registerLazySingleton<ForumLocalDataSource>(
      () => ForumLocalDatasourceImpl());
  sl.registerLazySingleton<ForumRepository>(() => ForumRemoteRepository(
      forumDataSource: sl(),
      checkInternetConnectivity: sl(),
      forumLocalDataSource: sl()));
  sl.registerLazySingleton<LoadJoinedForumsUsecase>(
      () => LoadJoinedForumsUsecase(forumRepository: sl()));
  sl.registerLazySingleton<LoadForumsUsecase>(
      () => LoadForumsUsecase(forumRepository: sl()));
  sl.registerLazySingleton<TopicForumsUsecase>(
      () => TopicForumsUsecase(forumRepository: sl()));
  sl.registerLazySingleton<ForumPostsUsecase>(
      () => ForumPostsUsecase(forumRepository: sl()));
  sl.registerLazySingleton<CreateForumUsecase>(
      () => CreateForumUsecase(forumRepository: sl()));
  sl.registerLazySingleton<JoinForumUsecase>(
      () => JoinForumUsecase(forumRepository: sl()));
  sl.registerFactory<ForumViewModel>(
    () => ForumViewModel(
      loadJoinedForumsUsecase: sl(),
      loadForumsUsecase: sl(),
      topicForumsUsecase: sl(),
      forumPostsUsecase: sl(),
      createForumUsecase: sl(),
      joinForumUsecase: sl(),
    ),
  );
}
