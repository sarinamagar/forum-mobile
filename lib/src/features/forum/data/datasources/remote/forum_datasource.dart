import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/features/forum/data/dto/create_forum/create_forum_request_dto.dart';
import 'package:forum/src/features/forum/data/dto/join_forum/join_forum_request_dto.dart';
import 'package:forum/src/features/forum/data/models/remote/forum_api_model.dart';

abstract class ForumDataSource {
  Future<List<ForumApiModel>> loadUserForums(String userID);
  Future<List<ForumApiModel>> loadJoinedForums(String userID);
  Future<ForumApiModel> fetchForumById(String forumID);
  Future<List<ForumApiModel>> fetchForums(List<Map<String, dynamic>> forumIDs);
  Future<List<ForumApiModel>> loadForums();
  Future<List<ForumApiModel>> topicForums(String topicID);
  Future<List<PostApiModel>> forumPosts(String forumID);
  Future<ForumApiModel> createForum(CreateForumRequestDto dto);
  Future<ForumApiModel> joinForum(JoinForumRequestDto dto);
}
