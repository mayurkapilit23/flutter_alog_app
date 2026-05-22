import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/number_grid/bloc/number_grid_bloc.dart';
import 'features/number_grid/bloc/number_grid_event.dart';
import 'features/number_grid/presentation/screens/number_grid_screen.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(const NumberGridApp());
}

class NumberGridApp extends StatelessWidget {
  const NumberGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Grid',
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
        create: (context) => NumberGridBloc()..add(const LoadNumberGrid()),
        child: const NumberGridScreen(),
      ),
    );
  }
}
