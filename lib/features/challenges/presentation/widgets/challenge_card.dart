import 'package:flutter/material.dart';
import '../../data/models/challenge_model.dart';

class ChallengeCard extends StatelessWidget {
  final ChallengeModel challenge;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ChallengeCard({
    super.key,
    required this.challenge,
    required this.onEdit,
    required this.onDelete,
  });

  Color _difficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text('💪', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          challenge.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _difficultyColor(challenge.difficulty)
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: _difficultyColor(challenge.difficulty)),
                  ),
                  child: Text(
                    '🔥 ${challenge.difficulty}',
                    style: TextStyle(
                      color: _difficultyColor(challenge.difficulty),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Text(
                    '📅 ${challenge.duration}',
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              challenge.description,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  challenge.completed
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: challenge.completed ? Colors.green : Colors.grey,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  challenge.completed ? 'Completed ✅' : 'In Progress...',
                  style: TextStyle(
                    color: challenge.completed ? Colors.green : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
