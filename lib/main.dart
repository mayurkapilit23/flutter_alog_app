import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/algorithm_task/bloc/algorithm_bloc.dart';
import 'features/algorithm_task/bloc/algorithm_event.dart';
import 'features/algorithm_task/presentation/screens/algorithm_screen.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(const AlgorithmApp());
}

class AlgorithmApp extends StatelessWidget {
  const AlgorithmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Algorithm Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.seedColor,
          brightness: Brightness.dark,
        ),
        fontFamily: 'monospace',
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => AlgorithmBloc()..add(const LoadAlgorithm()),
        child: const AlgorithmScreen(),
      ),
    );
  }
}
