import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/mappers/local/post_mappers.dart';
import 'package:forum/src/core/domain/mappers/remote/post_mappers.dart';
import 'package:forum/src/core/domain/mappers/remote/user_mappers.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/core/network/connectivity_checker.dart';
import 'package:forum/src/features/home/data/datasources/local/home_local_datasource.dart';
import 'package:forum/src/features/home/data/datasources/remote/home_datasource.dart';
import 'package:forum/src/features/home/domain/repositories/home_repository.dart';

class HomeRemoteRepository implements HomeRepository {
  final HomeDataSource homeDataSource;
  final BaseCheckInternetConnectivity checkInternetConnectivity;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRemoteRepository({
    required this.homeDataSource,
    required this.checkInternetConnectivity,
    required this.homeLocalDataSource,
  });
  @override
  Future<Either<Failure, List<Post>>> loadPosts() async {
    if (await checkInternetConnectivity.isConnected()) {
      try {
        List<PostApiModel> postsModel = await homeDataSource.loadPosts();
        List<Post> posts = postsModel.map((post) => post.toDomain()).toList();
        return Right(posts);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      final posts = homeLocalDataSource.loadPosts();
      return Right(posts.map((e) => e.toApi().toDomain()).toList());
    }
  }

  @override
  Future<Either<Failure, User>> fetchUserByID(String userID) async {
    try {
      UserApiModel user = await homeDataSource.fetchUserById(userID);
      return Right(user.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateStatus(String userID) async {
    try {
      UserApiModel userApiModel = await homeDataSource.updateStatus(userID);
      return Right(userApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await homeDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
