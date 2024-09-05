 import 'package:expense_tracker_app/model/expense_model.dart';

abstract class ExpenseEvent {}

 class AddNewExpenseEvent extends ExpenseEvent {
  ExpenseModel newExpense ;
  AddNewExpenseEvent({required this.newExpense}) ;
 }