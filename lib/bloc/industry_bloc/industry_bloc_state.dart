part of 'industry_bloc_bloc.dart';

sealed class IndustryBlocState extends Equatable {
  const IndustryBlocState();
  
  @override
  List<Object> get props => [];
}

final class IndustryBlocInitial extends IndustryBlocState {}
