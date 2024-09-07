import 'package:expense_tracker_app/model/expense_model.dart';

class FilterExpenseModel {
  num totalAmount;
  String title;
  List<ExpenseModel> fExpense;

  FilterExpenseModel(
      {required this.title, required this.fExpense, required this.totalAmount});
}
