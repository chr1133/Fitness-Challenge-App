import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/challenge_repository.dart';
import 'challenge_event.dart';
import 'challenge_state.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  final ChallengeRepository _repository = ChallengeRepository();

  ChallengeBloc() : super(ChallengeInitial()) {
    on<FetchChallenges>(_onFetchChallenges);
    on<AddChallenge>(_onAddChallenge);
    on<UpdateChallenge>(_onUpdateChallenge);
    on<DeleteChallenge>(_onDeleteChallenge);
  }

  Future<void> _onFetchChallenges(
    FetchChallenges event,
    Emitter<ChallengeState> emit,
  ) async {
    emit(ChallengeLoading());
    try {
      final challenges = await _repository.fetchChallenges();
      emit(ChallengeLoaded(challenges));
    } catch (e) {
      emit(ChallengeError(e.toString()));
    }
  }

  Future<void> _onAddChallenge(
    AddChallenge event,
    Emitter<ChallengeState> emit,
  ) async {
    emit(ChallengeLoading());
    try {
      await _repository.addChallenge(event.challenge);
      final challenges = await _repository.fetchChallenges();
      emit(ChallengeLoaded(challenges));
    } catch (e) {
      emit(ChallengeError(e.toString()));
    }
  }

  Future<void> _onUpdateChallenge(
    UpdateChallenge event,
    Emitter<ChallengeState> emit,
  ) async {
    emit(ChallengeLoading());
    try {
      await _repository.updateChallenge(event.challenge);
      final challenges = await _repository.fetchChallenges();
      emit(ChallengeLoaded(challenges));
    } catch (e) {
      emit(ChallengeError(e.toString()));
    }
  }

  Future<void> _onDeleteChallenge(
    DeleteChallenge event,
    Emitter<ChallengeState> emit,
  ) async {
    emit(ChallengeLoading());
    try {
      await _repository.deleteChallenge(event.id);
      final challenges = await _repository.fetchChallenges();
      emit(ChallengeLoaded(challenges));
    } catch (e) {
      emit(ChallengeError(e.toString()));
    }
  }
}
