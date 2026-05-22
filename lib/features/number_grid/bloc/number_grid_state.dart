import 'package:equatable/equatable.dart';
import '../models/rule.dart';

class NumberGridState extends Equatable {
  final Rule activeRule;
  final Set<int> primes;
  final Set<int> fibs;
  final int highlightedCount;

  const NumberGridState({
    required this.activeRule,
    required this.primes,
    required this.fibs,
    required this.highlightedCount,
  });

  factory NumberGridState.initial() {
    return const NumberGridState(
      activeRule: Rule.odd,
      primes: {},
      fibs: {},
      highlightedCount: 0,
    );
  }

  NumberGridState copyWith({
    Rule? activeRule,
    Set<int>? primes,
    Set<int>? fibs,
    int? highlightedCount,
  }) {
    return NumberGridState(
      activeRule: activeRule ?? this.activeRule,
      primes: primes ?? this.primes,
      fibs: fibs ?? this.fibs,
      highlightedCount: highlightedCount ?? this.highlightedCount,
    );
  }

  bool matchesRule(int n) {
    switch (activeRule) {
      case Rule.odd:
        return n % 2 != 0;
      case Rule.even:
        return n % 2 == 0;
      case Rule.prime:
        return primes.contains(n);
      case Rule.fibonacci:
        return fibs.contains(n);
    }
  }

  @override
  List<Object?> get props => [activeRule, primes, fibs, highlightedCount];
}
