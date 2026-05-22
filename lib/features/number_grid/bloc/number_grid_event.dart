import 'package:equatable/equatable.dart';
import '../models/rule.dart';

abstract class NumberGridEvent extends Equatable {
  const NumberGridEvent();

  @override
  List<Object?> get props => [];
}

class LoadNumberGrid extends NumberGridEvent {
  const LoadNumberGrid();
}

class ChangeRule extends NumberGridEvent {
  final Rule rule;

  const ChangeRule(this.rule);

  @override
  List<Object?> get props => [rule];
}
