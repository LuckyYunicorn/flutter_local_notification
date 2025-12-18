import 'package:bloc/bloc.dart';
import 'package:flutter_notification/bloc/investment/investment_event.dart';
import 'package:flutter_notification/bloc/investment/investment_state.dart';

class InvestmentBloc extends Bloc<InvestmentEvent,InvestmentState>{
  InvestmentBloc() : super(InvestmentState()){
    on<FetchInvestment>(_fetchInvestment);
  }

  Future<void> _fetchInvestment(FetchInvestment event, Emitter<InvestmentState> emit)async{

  }
}