import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class GridCell extends StatelessWidget {
  const GridCell({
    super.key,
    required this.number,
    required this.isHighlighted,
    required this.highlightColor,
  });

  final int number;
  final bool isHighlighted;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: isHighlighted
            ? highlightColor.withOpacity(0.18)
            : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isHighlighted
              ? highlightColor.withOpacity(0.5)
              : AppColors.borderSubtle,
          width: isHighlighted ? 1.2 : 0.5,
        ),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: highlightColor.withOpacity(0.2),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: number >= 100 ? 9 : 11,
            fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w400,
            color: isHighlighted ? highlightColor : AppColors.textMuted,
            letterSpacing: -0.3,
          ),
        ),
      ),
    );
  }
}
