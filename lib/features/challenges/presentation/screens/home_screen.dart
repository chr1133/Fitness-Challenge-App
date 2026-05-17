import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/challenge_bloc.dart';
import '../bloc/challenge_event.dart';
import '../bloc/challenge_state.dart';
import '../widgets/challenge_card.dart';
import 'add_challenge_screen.dart';
import 'edit_challenge_screen.dart';

const kBrown = Color(0xFF795548);
const kCream = Color(0xFFFFF8F0);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: kCream,
        title: const Text('Delete Challenge'),
        content: const Text('Are you sure you want to delete this challenge?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: kBrown)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ChallengeBloc>().add(DeleteChallenge(id));
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      appBar: AppBar(
        title: const Text('💪 Fitness Challenge App'),
        backgroundColor: kBrown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<ChallengeBloc, ChallengeState>(
        listener: (context, state) {
          if (state is ChallengeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ChallengeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: kBrown),
            );
          }

          if (state is ChallengeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ChallengeBloc>().add(FetchChallenges()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBrown,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ChallengeLoaded) {
            if (state.challenges.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.fitness_center, size: 64, color: kBrown),
                    SizedBox(height: 12),
                    Text(
                      'No challenges yet.\nTap + to add one!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              color: kBrown,
              onRefresh: () async =>
                  context.read<ChallengeBloc>().add(FetchChallenges()),
              child: ListView.builder(
                itemCount: state.challenges.length,
                itemBuilder: (context, index) {
                  final challenge = state.challenges[index];
                  return ChallengeCard(
                    challenge: challenge,
                    onEdit: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            EditChallengeScreen(challenge: challenge),
                      ),
                    ),
                    onDelete: () => _confirmDelete(context, challenge.id),
                  );
                },
              ),
            );
          }

          return const Center(child: Text('Press + to add a challenge!'));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddChallengeScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add Challenge'),
        backgroundColor: kBrown,
        foregroundColor: Colors.white,
      ),
    );
  }
}
