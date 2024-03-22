import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/features/forum/domain/usecases/load_user_forums_usecase.dart';
import 'package:forum/src/features/topic/data/datasources/local/topic_local_datasource.dart';
import 'package:forum/src/features/topic/data/datasources/local/topic_local_datasource_impl.dart';
import 'package:forum/src/features/topic/data/datasources/remote/topic_datasource.dart';
import 'package:forum/src/features/topic/data/datasources/remote/topic_datasource_impl.dart';
import 'package:forum/src/features/topic/data/repositories/topic_remote_repository.dart';
import 'package:forum/src/features/topic/domain/repositories/topic_repository.dart';
import 'package:forum/src/features/topic/domain/usecases/load_topics_usecase.dart';
import 'package:forum/src/features/topic/presentation/viewmodels/topic_viewmodel.dart';

void initTopic() {
  sl.registerLazySingleton<TopicDataSource>(
      () => TopicDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<TopicLocalDataSource>(
      () => TopicLocalDatasourceImpl());
  sl.registerLazySingleton<TopicRepository>(() => TopicRemoteRepository(
      topicDataSource: sl(),
      checkInternetConnectivity: sl(),
      topicLocalDataSource: sl()));
  sl.registerLazySingleton<LoadTopicUsecase>(
      () => LoadTopicUsecase(topicRepository: sl()));
  sl.registerLazySingleton<LoadUserForumsUsecase>(
      () => LoadUserForumsUsecase(forumRepository: sl()));
  sl.registerFactory<TopicViewModel>(() => TopicViewModel(
        loadTopicUsecase: sl(),
        loadUserForumsUsecase: sl(),
      ));
}
