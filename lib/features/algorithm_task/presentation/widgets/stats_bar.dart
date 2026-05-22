import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/algorithm_bloc.dart';
import '../../bloc/algorithm_state.dart';
import '../../../../core/constants/app_colors.dart';
import 'stat_chip.dart';

class StatsBar extends StatelessWidget {
  const StatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlgorithmBloc, AlgorithmState>(
      buildWhen: (previous, current) =>
          previous.activeRule != current.activeRule ||
          previous.ruleCounts != current.ruleCounts,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                StatChip(
                  label: 'Highlighted',
                  value: '${state.highlightedCount}',
                  color: state.activeRule.color,
                ),
                const SizedBox(width: 8),
                const StatChip(
                  label: 'Total',
                  value: '100',
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 8),
                StatChip(
                  label: 'Pattern',
                  value: state.activeRule.hint,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
