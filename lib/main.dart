import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/challenges/presentation/bloc/challenge_bloc.dart';
import 'features/challenges/presentation/bloc/challenge_event.dart';
import 'features/challenges/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChallengeBloc()..add(FetchChallenges()),
      child: MaterialApp(
        title: 'Fitness Challenge App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF795548)),
          scaffoldBackgroundColor: Color(0xFFFFF8F0),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
