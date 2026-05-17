import 'package:equatable/equatable.dart';
import '../../data/models/challenge_model.dart';

abstract class ChallengeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchChallenges extends ChallengeEvent {}

class AddChallenge extends ChallengeEvent {
  final ChallengeModel challenge;
  AddChallenge(this.challenge);

  @override
  List<Object?> get props => [challenge];
}

class UpdateChallenge extends ChallengeEvent {
  final ChallengeModel challenge;
  UpdateChallenge(this.challenge);

  @override
  List<Object?> get props => [challenge];
}

class DeleteChallenge extends ChallengeEvent {
  final String id;
  DeleteChallenge(this.id);

  @override
  List<Object?> get props => [id];
}
