import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/error/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, User>> fetchUserByID(String userID);
  Future<Either<Failure, List<Post>>> loadPosts();
  Future<Either<Failure, User>> updateStatus(String userID);
  Future<Either<Failure, void>> signOut();
}
