import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/features/post/data/datasources/remote/post_datasource.dart';
import 'package:forum/src/features/post/data/datasources/remote/post_datasource_impl.dart';
import 'package:forum/src/features/post/data/repositories/post_remote_repository.dart';
import 'package:forum/src/features/post/domain/repositories/post_repository.dart';
import 'package:forum/src/features/post/domain/usecases/add_comment_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/add_post_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/add_reply_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/downvote_comment_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/downvote_post_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/get_comment_by_id_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/get_post_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/upvote_comment_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/upvote_post_usecase.dart';
import 'package:forum/src/features/post/presentation/bloc/post_bloc.dart';

void initPost() {
  sl.registerLazySingleton<PostDataSource>(() => PostDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<PostRepository>(
      () => PostRemoteRepository(postDataSource: sl()));
  sl.registerLazySingleton(() => GetPostUsecase(postRepository: sl()));
  sl.registerLazySingleton(() => GetCommentByIdUsecase(postRepository: sl()));
  sl.registerLazySingleton(() => AddPostUsecase(postRepository: sl()));
  sl.registerLazySingleton(() => AddCommentUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => AddReplyUsecase(postRepository: sl()));
  sl.registerLazySingleton(() => UpvotePostUsecase(postRepository: sl()));
  sl.registerLazySingleton(() => DownvotePostUsecase(postRepository: sl()));
  sl.registerLazySingleton(() => UpvoteCommentUsecase(postRepository: sl()));
  sl.registerLazySingleton(() => DownvoteCommentUsecase(postRepository: sl()));
  sl.registerFactory<PostBloc>(() => PostBloc(
      getPostUsecase: sl(),
      getCommentByIdUsecase: sl(),
      addPostUsecase: sl(),
      addCommentUseCase: sl(),
      addReplyUseCase: sl(),
      upvotePostUsecase: sl(),
      downvotePostUsecase: sl(),
      upvoteCommentUsecase: sl(),
      downvoteCommentUsecase: sl()));
}
