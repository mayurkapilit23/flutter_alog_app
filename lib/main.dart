// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/number_grid_bloc.dart';
import 'bloc/number_grid_event.dart';
import 'bloc/number_grid_state.dart';

void main() {
  runApp(const NumberGridApp());
}

// ─── App root ───────────────────────────────────────────────────────────────

class NumberGridApp extends StatelessWidget {
  const NumberGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Grid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A1A2E),
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

// ─── Rule enum ───────────────────────────────────────────────────────────────

enum Rule {
  odd('Odd', '01 03 05…', Color(0xFF4FC3F7)),
  even('Even', '02 04 06…', Color(0xFF81C784)),
  prime('Prime', '02 03 05 07…', Color(0xFFFFB74D)),
  fibonacci('Fibonacci', '01 01 02 03 05…', Color(0xFFF06292));

  const Rule(this.label, this.hint, this.color);
  final String label;
  final String hint;
  final Color color;
}

// ─── Main screen ─────────────────────────────────────────────────────────────

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

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocListener<NumberGridBloc, NumberGridState>(
      listenWhen: (previous, current) => previous.activeRule != current.activeRule,
      listener: (context, state) {
        _controller.reset();
        _controller.forward();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D1A),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildRuleSelector(),
              _buildStatsBar(),
              Expanded(child: _buildGrid()),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ───────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return BlocBuilder<NumberGridBloc, NumberGridState>(
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
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '1 → 100  ·  ${activeRule.label} highlighted',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white38,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Dot indicator for active rule color
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

  // ── Rule selector chips ──────────────────────────────────────────────────

  Widget _buildRuleSelector() {
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
              return GestureDetector(
                onTap: () {
                  context.read<NumberGridBloc>().add(ChangeRule(rule));
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: isActive
                        ? rule.color.withOpacity(0.15)
                        : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isActive
                          ? rule.color.withOpacity(0.7)
                          : Colors.white.withOpacity(0.08),
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
                          color: isActive ? rule.color : Colors.white38,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // ── Stats bar ────────────────────────────────────────────────────────────

  Widget _buildStatsBar() {
    return BlocBuilder<NumberGridBloc, NumberGridState>(
      buildWhen: (previous, current) =>
          previous.activeRule != current.activeRule ||
          previous.highlightedCount != current.highlightedCount,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _StatChip(
                  label: 'Highlighted',
                  value: '${state.highlightedCount}',
                  color: state.activeRule.color,
                ),
                const SizedBox(width: 8),
                const _StatChip(label: 'Total', value: '100', color: Colors.white24),
                const SizedBox(width: 8),
                _StatChip(
                  label: 'Pattern',
                  value: state.activeRule.hint,
                  color: Colors.white24,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Grid ─────────────────────────────────────────────────────────────────

  Widget _buildGrid() {
    return BlocBuilder<NumberGridBloc, NumberGridState>(
      buildWhen: (previous, current) => previous.activeRule != current.activeRule,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(14, 4, 14, 16),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: 100,
            itemBuilder: (context, index) {
              final number = index + 1;
              final isHighlighted = state.matchesRule(number);

              // Staggered reveal animation
              final delay = index * 0.008;
              final animation = CurvedAnimation(
                parent: _controller,
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
                      child: _GridCell(
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

// ─── Grid cell widget ─────────────────────────────────────────────────────────

class _GridCell extends StatelessWidget {
  const _GridCell({
    required this.number,
    required this.isHighlighted,
    required this.highlightColor,
  });

  final int number;
  final bool isHighlighted;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isHighlighted
            ? highlightColor.withOpacity(0.18)
            : Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isHighlighted
              ? highlightColor.withOpacity(0.5)
              : Colors.white.withOpacity(0.06),
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
            color: isHighlighted ? highlightColor : Colors.white24,
            letterSpacing: -0.3,
          ),
        ),
      ),
    );
  }
}

// ─── Stat chip ────────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withOpacity(0.07), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white30,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color == Colors.white24 ? Colors.white54 : color,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
