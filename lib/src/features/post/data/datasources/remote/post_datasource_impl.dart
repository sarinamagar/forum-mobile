import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/http/api_endpoints.dart';
import 'package:forum/src/core/http/handle_error_response.dart';
import 'package:forum/src/core/models/remote/post/comment_api_model.dart';
import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/features/post/data/datasources/remote/post_datasource.dart';
import 'package:forum/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_votes/add_vote_request_dto.dart';
import 'package:forum/src/features/post/data/dto/get_comment/comment_id_response_dto.dart';
import 'package:forum/src/features/post/data/dto/get_post/get_post_response_dto.dart';

class PostDataSourceImpl implements PostDataSource {
  final Dio dio;

  PostDataSourceImpl({required this.dio});
  @override
  Future<PostApiModel> getPost(String postId) async {
    try {
      final response = await dio.get("${ApiEndpoints.getPost}$postId");
      if (response.statusCode == 200) {
        print("Get post singular ${response.data}");
        GetPostResponseDto getPostResponseDto =
            GetPostResponseDto.fromJson(response.data);
        return getPostResponseDto.data;
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
  Future<CommentApiModel> getCommentById(String commentID) async {
    try {
      final response =
          await dio.get("${ApiEndpoints.getCommentById}$commentID");
      if (response.statusCode == 200) {
        CommentIdResponseDto getCommentResponseDto =
            CommentIdResponseDto.fromJson(response.data);
        return getCommentResponseDto.data;
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
  Future<PostApiModel> addPost(AddPostRequestDto dto) async {
    try {
      FormData postData = FormData();
      String fileName =
          dto.media != null ? dto.media!.path.split('/').last : '';
      postData.fields.add(MapEntry('post', jsonEncode(dto.toJson())));
      if (dto.media != null) {
        postData.files.add(MapEntry(
          'media',
          await MultipartFile.fromFile(
            dto.media!.path,
            filename: fileName,
          ),
        ));
      }
      var res = await dio.post(ApiEndpoints.getPost, data: postData);
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        String postID = data['_id'];
        PostApiModel postApiModel = await getPost(postID);
        return postApiModel;
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
  Future<CommentApiModel> addComment(AddCommentRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.addComment, data: dto.toJson());
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        String commentID = data['_id'];
        CommentApiModel commentApiModel = await getCommentById(commentID);
        return commentApiModel;
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<CommentApiModel> addReply(AddReplyRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.addReply, data: dto.toJson());
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        String commentID = data['_id'];
        CommentApiModel commentApiModel = await getCommentById(commentID);
        return commentApiModel;
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<bool> upvotePost(AddVoteRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.upvote, data: dto.toJson());
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        return data['userHasUpvoted'];
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<void> downvotePost(AddVoteRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.downvote, data: dto.toJson());
      if (res.statusCode == 200) {
        String success = res.data['message'];
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<bool> upvoteComment(CommentVoteRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.upvoteComment, data: dto.toJson());
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        return data['userHasUpvoted'];
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<void> downvoteComment(CommentVoteRequestDto dto) async {
    try {
      var res =
          await dio.post(ApiEndpoints.downvoteComment, data: dto.toJson());
      if (res.statusCode == 200) {
        String success = res.data['message'];
        print("$success User has downvoted++++++++++++++");
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }
}
