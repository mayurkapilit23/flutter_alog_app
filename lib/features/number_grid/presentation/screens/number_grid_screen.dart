import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/number_grid_bloc.dart';
import '../../bloc/number_grid_state.dart';
import '../widgets/number_grid.dart';
import '../widgets/number_grid_header.dart';
import '../widgets/rule_selector.dart';
import '../widgets/stats_bar.dart';
import '../../../../core/constants/app_colors.dart';

class NumberGridScreen extends StatefulWidget {
  const NumberGridScreen({super.key});

  @override
  State<NumberGridScreen> createState() => _NumberGridScreenState();
}

class _NumberGridScreenState extends State<NumberGridScreen>
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
    return BlocListener<NumberGridBloc, NumberGridState>(
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
                child: NumberGrid(animationController: _controller),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
