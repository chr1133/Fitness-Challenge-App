import 'package:equatable/equatable.dart';
import '../../data/models/challenge_model.dart';

abstract class ChallengeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChallengeInitial extends ChallengeState {}

class ChallengeLoading extends ChallengeState {}

class ChallengeLoaded extends ChallengeState {
  final List<ChallengeModel> challenges;
  ChallengeLoaded(this.challenges);

  @override
  List<Object?> get props => [challenges];
}

class ChallengeError extends ChallengeState {
  final String message;
  ChallengeError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChallengeOperationSuccess extends ChallengeState {
  final String message;
  ChallengeOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
