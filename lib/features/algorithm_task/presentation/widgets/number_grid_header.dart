import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/algorithm_bloc.dart';
import '../../bloc/algorithm_state.dart';
import '../../../../core/constants/app_colors.dart';

class NumberGridHeader extends StatelessWidget {
  const NumberGridHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlgorithmBloc, AlgorithmState>(
      buildWhen: (previous, current) => previous.activeRule != current.activeRule,
      builder: (context, state) {
        final activeRule = state.activeRule;
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Number Grid',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '1 → 100  ·  ${activeRule.label} highlighted',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textTertiary,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: activeRule.color,
                  boxShadow: [
                    BoxShadow(
                      color: activeRule.color.withOpacity(0.6),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
