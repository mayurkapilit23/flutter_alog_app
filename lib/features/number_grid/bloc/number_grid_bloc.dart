import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/rule.dart';
import 'number_grid_event.dart';
import 'number_grid_state.dart';

class NumberGridBloc extends Bloc<NumberGridEvent, NumberGridState> {
  NumberGridBloc() : super(NumberGridState.initial()) {
    on<LoadNumberGrid>(_onLoadNumberGrid);
    on<ChangeRule>(_onChangeRule);
  }

  void _onLoadNumberGrid(LoadNumberGrid event, Emitter<NumberGridState> emit) {
    final primes = _computePrimes(100);
    final fibs = _computeFibonacci(100);
    final initialRule = state.activeRule;
    final highlightedCount = _calculateHighlightedCount(initialRule, primes, fibs);

    emit(NumberGridState(
      activeRule: initialRule,
      primes: primes,
      fibs: fibs,
      highlightedCount: highlightedCount,
    ));
  }

  void _onChangeRule(ChangeRule event, Emitter<NumberGridState> emit) {
    final rule = event.rule;
    final highlightedCount = _calculateHighlightedCount(rule, state.primes, state.fibs);

    emit(state.copyWith(
      activeRule: rule,
      highlightedCount: highlightedCount,
    ));
  }

  Set<int> _computePrimes(int max) {
    final sieve = List.filled(max + 1, true);
    sieve[0] = sieve[1] = false;
    for (int i = 2; i * i <= max; i++) {
      if (sieve[i]) {
        for (int j = i * i; j <= max; j += i) {
          sieve[j] = false;
        }
      }
    }
    return {
      for (int i = 2; i <= max; i++)
        if (sieve[i]) i,
    };
  }

  Set<int> _computeFibonacci(int max) {
    final fibs = <int>{};
    int a = 1, b = 1;
    while (a <= max) {
      fibs.add(a);
      final temp = a + b;
      a = b;
      b = temp;
    }
    return fibs;
  }

  int _calculateHighlightedCount(Rule rule, Set<int> primes, Set<int> fibs) {
    int count = 0;
    for (int i = 1; i <= 100; i++) {
      bool matches = false;
      switch (rule) {
        case Rule.odd:
          matches = i % 2 != 0;
          break;
        case Rule.even:
          matches = i % 2 == 0;
          break;
        case Rule.prime:
          matches = primes.contains(i);
          break;
        case Rule.fibonacci:
          matches = fibs.contains(i);
          break;
      }
      if (matches) count++;
    }
    return count;
  }
}
