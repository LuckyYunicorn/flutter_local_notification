import 'package:equatable/equatable.dart';

sealed class InvestmentEvent extends Equatable {
  const InvestmentEvent();
  @override
  List<Object?> get props => [];
}

class FetchInvestment extends InvestmentEvent {}
