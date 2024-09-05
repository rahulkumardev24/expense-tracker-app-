import 'package:expense_tracker_app/bloc/expense_event.dart';
import 'package:expense_tracker_app/bloc/expense_state.dart';
import 'package:expense_tracker_app/data/app_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  AppDataBase appDataBase  ;
  ExpenseBloc({required this.appDataBase}) : super(ExpenseInitialState()) {


    /// Event
    on<AddNewExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      bool check = await appDataBase.addExpense(newExpense: event.newExpense) ;
      if(check) {
        var data = await appDataBase.getAllExpense() ;
        emit(ExpenseLoadedState(mData: data)) ;
      }else {
        emit(ExpenseErrorState(errorMessage: "Expense is not added!!")) ;
      }

    });
  }
}
