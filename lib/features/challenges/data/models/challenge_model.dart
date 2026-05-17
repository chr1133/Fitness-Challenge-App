import 'package:equatable/equatable.dart';

class ChallengeModel extends Equatable {
  final String id;
  final String title;
  final String difficulty;
  final String duration;
  final bool completed;
  final String description;

  const ChallengeModel({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.duration,
    required this.completed,
    required this.description,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      difficulty: json['difficulty'] ?? '',
      duration: json['duration'] ?? '',
      completed: json['completed'] ?? false,
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'difficulty': difficulty,
      'duration': duration,
      'completed': completed,
      'description': description,
    };
  }

  ChallengeModel copyWith({
    String? id,
    String? title,
    String? difficulty,
    String? duration,
    bool? completed,
    String? description,
  }) {
    return ChallengeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      difficulty: difficulty ?? this.difficulty,
      duration: duration ?? this.duration,
      completed: completed ?? this.completed,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, difficulty, duration, completed, description];
}
