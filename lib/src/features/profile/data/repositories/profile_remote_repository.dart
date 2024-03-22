import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/mappers/remote/post_mappers.dart';
import 'package:forum/src/core/domain/mappers/remote/user_mappers.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/features/profile/data/datasources/remote/profile_data_source.dart';
import 'package:forum/src/features/profile/data/dto/update_user_request_dto.dart';
import 'package:forum/src/features/profile/domain/repositories/profile_repository.dart';

class ProfileRemoteRepository implements ProfileRepository {
  final ProfileDataSource profileDataSource;

  ProfileRemoteRepository({required this.profileDataSource});
  @override
  Future<Either<Failure, List<Post>>> userPosts(String userID) async {
    try {
      List<PostApiModel> postsModel = await profileDataSource.userPosts(userID);
      List<Post> posts = postsModel.map((post) => post.toDomain()).toList();
      return Right(posts);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(UpdateUserRequestDto dto) async {
    try {
      final UserApiModel userApiModel = await profileDataSource.updateUser(dto);
      return Right(userApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
