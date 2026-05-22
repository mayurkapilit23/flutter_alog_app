import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/rule.dart';
import 'algorithm_event.dart';
import 'algorithm_state.dart';

class AlgorithmBloc extends Bloc<AlgorithmEvent, AlgorithmState> {
  AlgorithmBloc() : super(AlgorithmState.initial()) {
    on<LoadAlgorithm>(_onLoadAlgorithm);
    on<ChangeRule>(_onChangeRule);
  }

  void _onLoadAlgorithm(LoadAlgorithm event, Emitter<AlgorithmState> emit) {
    final primes = _computePrimes(100);
    final fibs = _computeFibonacci(100);
    
    final ruleCounts = <Rule, int>{};
    for (final rule in Rule.values) {
      int count = 0;
      for (int i = 1; i <= 100; i++) {
        if (rule.matches(i, primes, fibs)) count++;
      }
      ruleCounts[rule] = count;
    }

    emit(AlgorithmState(
      activeRule: Rule.odd,
      primes: primes,
      fibs: fibs,
      ruleCounts: ruleCounts,
    ));
  }

  void _onChangeRule(ChangeRule event, Emitter<AlgorithmState> emit) {
    emit(state.copyWith(activeRule: event.rule));
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
}
