import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:forum/src/core/constants/app_boxes.dart';
import 'package:forum/src/core/domain/mappers/local/forum_mappers.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/http/api_endpoints.dart';
import 'package:forum/src/core/http/handle_error_response.dart';
import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/features/forum/data/datasources/remote/forum_datasource.dart';
import 'package:forum/src/features/forum/data/dto/create_forum/create_forum_request_dto.dart';
import 'package:forum/src/features/forum/data/dto/join_forum/join_forum_request_dto.dart';
import 'package:forum/src/features/forum/data/models/local/forum_hive_model.dart';
import 'package:forum/src/features/forum/data/models/remote/forum_api_model.dart';

class ForumDatasourceImpl implements ForumDataSource {
  final Dio dio;

  ForumDatasourceImpl({required this.dio});

  @override
  Future<List<ForumApiModel>> loadUserForums(String userID) async {
    try {
      final response = await dio.get("${ApiEndpoints.loadUserForums}$userID");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<ForumApiModel> forums = List<ForumApiModel>.from(
          data.map((forum) => ForumApiModel.fromJson(forum)),
        );
        return forums;
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<List<ForumApiModel>> loadJoinedForums(String userID) async {
    try {
      final response = await dio.get("${ApiEndpoints.fetchUserByID}$userID");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final forumsData = data['forums'];
        List<ForumApiModel> forumModels = await fetchForums(forumsData);
        return forumModels;
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<ForumApiModel> fetchForumById(String forumID) async {
    try {
      final response = await dio.get("${ApiEndpoints.fetchForumById}$forumID");
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data['data'];
        print("Data $data");
        ForumApiModel forumApiModel = ForumApiModel.fromJson(data);
        return forumApiModel;
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<List<ForumApiModel>> fetchForums(List<dynamic> forumIDs) async {
    List<Future<ForumApiModel>> futures = [];
    for (var idMap in forumIDs) {
      String forumID = idMap['_id'];
      futures.add(fetchForumById(forumID));
    }
    List<ForumApiModel> forums = await Future.wait(futures);
    return forums;
  }

  @override
  Future<List<ForumApiModel>> loadForums() async {
    try {
      final response = await dio.get(ApiEndpoints.loadForums);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<ForumApiModel> forums = List<ForumApiModel>.from(
          data.map((data) => ForumApiModel.fromJson(data)),
        );
        if (forums.isNotEmpty) {
          await AppBoxes.forumBox.addAll(
              List<ForumHiveModel>.from(forums.map((e) => e.fromApi())));
        }
        return forums;
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<List<ForumApiModel>> topicForums(String topicID) async {
    try {
      final response = await dio.get("${ApiEndpoints.topicForums}$topicID");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<ForumApiModel> forums = List<ForumApiModel>.from(
          data.map((forum) => ForumApiModel.fromJson(forum)),
        );
        return forums;
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<List<PostApiModel>> forumPosts(String forumID) async {
    try {
      final response = await dio.get("${ApiEndpoints.forumPost}$forumID");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<PostApiModel> posts = List<PostApiModel>.from(
          data.map((post) => PostApiModel.fromJson(post)),
        );
        return posts;
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<ForumApiModel> createForum(CreateForumRequestDto dto) async {
    try {
      FormData forumData = FormData();
      String iconName = dto.icon != null ? dto.icon!.path.split('/').last : '';
      String coverName =
          dto.cover != null ? dto.cover!.path.split('/').last : '';
      forumData.fields.add(MapEntry('forum', jsonEncode(dto.toJson())));
      if (dto.icon != null) {
        forumData.files.add(MapEntry(
          'icon',
          await MultipartFile.fromFile(
            dto.icon!.path,
            filename: iconName,
          ),
        ));
      }
      if (dto.cover != null) {
        forumData.files.add(MapEntry(
          'cover',
          await MultipartFile.fromFile(
            dto.cover!.path,
            filename: coverName,
          ),
        ));
      }
      var res = await dio.post(ApiEndpoints.createForum, data: forumData);
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        String forumID = data['_id'];
        ForumApiModel forumApiModel = await fetchForumById(forumID);
        return forumApiModel;
      } else {
        throw Failure(
            message: res.statusMessage.toString(),
            statusCode: res.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<ForumApiModel> joinForum(JoinForumRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.join, data: dto.toJson());
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        String forumID = data['_id'];
        ForumApiModel forumApiModel = await fetchForumById(forumID);
        return forumApiModel;
      } else {
        throw Failure(
            message: res.statusMessage.toString(),
            statusCode: res.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }
}
