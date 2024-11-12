part of 'industry_bloc_bloc.dart';

abstract class IndustryEvent {}

class LoadIndustries extends IndustryEvent {}

class RefreshIndustries extends IndustryEvent {}

// blocs/industry/industry_state.dart
abstract class IndustryState {}

class IndustryInitial extends IndustryState {}

class IndustryLoading extends IndustryState {}

class IndustryLoaded extends IndustryState {
  final List<Industry> industries;

  IndustryLoaded(this.industries);
}

class IndustryError extends IndustryState {
  final String message;

  IndustryError(this.message);
}
