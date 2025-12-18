import 'package:equatable/equatable.dart';
import 'package:flutter_notification/model/posts_model.dart';

class InvestmentState extends Equatable {
  final InvestmentModel? investmentModel;

  const InvestmentState({this.investmentModel});

  InvestmentState copyWith({InvestmentModel? investmentModel}) {
    return InvestmentState(
      investmentModel: investmentModel ?? this.investmentModel,
    );
  }

  @override
  List<Object?> get props => [investmentModel];
}
