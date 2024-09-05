import 'package:expense_tracker_app/model/expense_model.dart';

abstract class ExpenseState {}

class ExpenseInitialState extends ExpenseState {}

class ExpenseLoadingState extends ExpenseState {}

class ExpenseLoadedState extends ExpenseState {
  List<ExpenseModel> mData;
  ExpenseLoadedState({required this.mData});
}

class ExpenseErrorState extends ExpenseState {
  String errorMessage;
  ExpenseErrorState({required this.errorMessage});
}
