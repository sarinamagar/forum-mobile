import 'package:dio/dio.dart';
import 'package:forum/src/core/constants/app_boxes.dart';
import 'package:forum/src/core/domain/mappers/local/forum_mappers.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/http/api_endpoints.dart';
import 'package:forum/src/core/http/handle_error_response.dart';
import 'package:forum/src/features/topic/data/datasources/remote/topic_datasource.dart';
import 'package:forum/src/features/topic/data/models/local/topic_hive_model.dart';
import 'package:forum/src/features/topic/data/models/remote/topic_api_model.dart';

class TopicDataSourceImpl implements TopicDataSource {
  final Dio dio;

  TopicDataSourceImpl({required this.dio});
  @override
  Future<List<TopicApiModel>> loadTopics() async {
    try {
      final response = await dio.get(ApiEndpoints.loadTopics);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<TopicApiModel> topics = List<TopicApiModel>.from(
          data.map((topic) => TopicApiModel.fromJson(topic)),
        );
        if (topics.isNotEmpty) {
          await AppBoxes.topicBox.addAll(
              List<TopicHiveModel>.from(topics.map((e) => e.fromApi())));
        }
        return topics;
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }
}
