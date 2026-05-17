import '../models/challenge_model.dart';
import '../services/challenge_service.dart';

class ChallengeRepository {
  final ChallengeService _service = ChallengeService();

  Future<List<ChallengeModel>> fetchChallenges() => _service.fetchChallenges();

  Future<ChallengeModel> addChallenge(ChallengeModel challenge) =>
      _service.addChallenge(challenge);

  Future<ChallengeModel> updateChallenge(ChallengeModel challenge) =>
      _service.updateChallenge(challenge);

  Future<void> deleteChallenge(String id) => _service.deleteChallenge(id);
}
