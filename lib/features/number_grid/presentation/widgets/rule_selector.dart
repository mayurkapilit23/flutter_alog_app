import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/number_grid_bloc.dart';
import '../../bloc/number_grid_event.dart';
import '../../bloc/number_grid_state.dart';
import '../../models/rule.dart';
import '../../../../core/constants/app_colors.dart';

class RuleSelector extends StatelessWidget {
  const RuleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberGridBloc, NumberGridState>(
      buildWhen: (previous, current) => previous.activeRule != current.activeRule,
      builder: (context, state) {
        final activeRule = state.activeRule;
        return SizedBox(
          height: 52,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            itemCount: Rule.values.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final rule = Rule.values[i];
              final isActive = rule == activeRule;
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context.read<NumberGridBloc>().add(ChangeRule(rule));
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive
                          ? rule.color.withOpacity(0.15)
                          : AppColors.borderMuted,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isActive
                            ? rule.color.withOpacity(0.7)
                            : AppColors.borderHighlight,
                        width: isActive ? 1.5 : 0.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        if (isActive) ...[
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: rule.color,
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          rule.label,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                            color: isActive ? rule.color : AppColors.textTertiary,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
