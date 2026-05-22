import 'package:equatable/equatable.dart';
import '../models/rule.dart';

class AlgorithmState extends Equatable {
  final Rule activeRule;
  final Set<int> primes;
  final Set<int> fibs;
  final Map<Rule, int> ruleCounts;

  const AlgorithmState({
    required this.activeRule,
    required this.primes,
    required this.fibs,
    required this.ruleCounts,
  });

  factory AlgorithmState.initial() {
    return const AlgorithmState(
      activeRule: Rule.odd,
      primes: {},
      fibs: {},
      ruleCounts: {},
    );
  }

  int get highlightedCount => ruleCounts[activeRule] ?? 0;

  AlgorithmState copyWith({
    Rule? activeRule,
    Set<int>? primes,
    Set<int>? fibs,
    Map<Rule, int>? ruleCounts,
  }) {
    return AlgorithmState(
      activeRule: activeRule ?? this.activeRule,
      primes: primes ?? this.primes,
      fibs: fibs ?? this.fibs,
      ruleCounts: ruleCounts ?? this.ruleCounts,
    );
  }

  bool matchesRule(int n) => activeRule.matches(n, primes, fibs);

  @override
  List<Object?> get props => [activeRule, primes, fibs, ruleCounts];
}
