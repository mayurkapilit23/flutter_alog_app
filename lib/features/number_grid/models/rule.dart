import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

enum Rule {
  odd('Odd', '01 03 05…', AppColors.ruleOdd),
  even('Even', '02 04 06…', AppColors.ruleEven),
  prime('Prime', '02 03 05 07…', AppColors.rulePrime),
  fibonacci('Fibonacci', '01 01 02 03 05…', AppColors.ruleFibonacci);

  const Rule(this.label, this.hint, this.color);
  final String label;
  final String hint;
  final Color color;
}
