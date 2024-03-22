import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/profile/data/dto/update_user_request_dto.dart';

abstract class ProfileRepository {
  Future<Either<Failure, List<Post>>> userPosts(String userID);
  Future<Either<Failure, User>> updateUser(UpdateUserRequestDto dto);
}
