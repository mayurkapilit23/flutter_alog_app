import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/algorithm_bloc.dart';
import '../../bloc/algorithm_state.dart';
import '../widgets/grid_of_numbers.dart';
import '../widgets/number_grid_header.dart';
import '../widgets/rule_selector.dart';
import '../widgets/stats_bar.dart';
import '../../../../core/constants/app_colors.dart';

class AlgorithmScreen extends StatefulWidget {
  const AlgorithmScreen({super.key});

  @override
  State<AlgorithmScreen> createState() => _AlgorithmScreenState();
}

class _AlgorithmScreenState extends State<AlgorithmScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AlgorithmBloc, AlgorithmState>(
      listenWhen: (previous, current) => previous.activeRule != current.activeRule,
      listener: (context, state) {
        _controller.reset();
        _controller.forward();
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: Column(
            children: [
              const NumberGridHeader(),
              const RuleSelector(),
              const StatsBar(),
              Expanded(
                child: GridOfNumbers(animationController: _controller),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
