import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/number_grid_bloc.dart';
import '../../bloc/number_grid_state.dart';
import 'grid_cell.dart';

class NumberGrid extends StatelessWidget {
  final AnimationController animationController;

  const NumberGrid({
    super.key,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberGridBloc, NumberGridState>(
      buildWhen: (previous, current) => previous.activeRule != current.activeRule,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(14, 4, 14, 16),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10, crossAxisSpacing: 5, mainAxisSpacing: 5),
            itemCount: 100,
            itemBuilder: (context, index) {
              final number = index + 1;
              final isHighlighted = state.matchesRule(number);

              // Staggered reveal animation
              final delay = index * 0.008;
              final animation = CurvedAnimation(
                parent: animationController,
                curve: Interval(
                  delay.clamp(0.0, 0.8),
                  (delay + 0.3).clamp(0.0, 1.0),
                  curve: Curves.easeOut,
                ),
              );

              return AnimatedBuilder(
                animation: animation,
                builder: (context, _) {
                  return Transform.scale(
                    scale: 0.6 + (0.4 * animation.value),
                    child: Opacity(
                      opacity: animation.value,
                      child: GridCell(
                        number: number,
                        isHighlighted: isHighlighted,
                        highlightColor: state.activeRule.color,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
