import 'package:dio/dio.dart';
import '../models/challenge_model.dart';
import '../../../../core/constants/api_constants.dart';

class ChallengeService {
  final Dio _dio = Dio();
  final String baseUrl = ApiConstants.baseUrl;

  // READ
  Future<List<ChallengeModel>> fetchChallenges() async {
    final response = await _dio.get(baseUrl);
    final List<dynamic> data = response.data;
    return data.map((json) => ChallengeModel.fromJson(json)).toList();
  }

  // CREATE
  Future<ChallengeModel> addChallenge(ChallengeModel challenge) async {
    final response = await _dio.post(
      baseUrl,
      data: challenge.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return ChallengeModel.fromJson(response.data);
  }

  // UPDATE
  Future<ChallengeModel> updateChallenge(ChallengeModel challenge) async {
    final response = await _dio.put(
      '$baseUrl/${challenge.id}',
      data: challenge.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return ChallengeModel.fromJson(response.data);
  }

  // DELETE
  Future<void> deleteChallenge(String id) async {
    await _dio.delete('$baseUrl/$id');
  }
}
