import 'package:equatable/equatable.dart';
import '../models/rule.dart';

abstract class AlgorithmEvent extends Equatable {
  const AlgorithmEvent();

  @override
  List<Object?> get props => [];
}

class LoadAlgorithm extends AlgorithmEvent {
  const LoadAlgorithm();
}

class ChangeRule extends AlgorithmEvent {
  final Rule rule;

  const ChangeRule(this.rule);

  @override
  List<Object?> get props => [rule];
}
