import 'package:expense_tracker_app/data/app_data.dart';

class ExpenseModel {
  int? expenseId;
  int userId;
  int expenseType;
  int expenseCategoryId;
  String expenseTitle;
  String expenseDescription;
  String expenseDate;
  num expenseAmount;
  num expenseBalance;

  ExpenseModel({
    this.expenseId,
    required this.expenseCategoryId,
    required this.expenseAmount,
    required this.expenseBalance,
    required this.expenseDate,
    required this.expenseDescription,
    required this.expenseTitle,
    required this.expenseType,
    required this.userId,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        expenseId: map[AppDataBase.COLUMN_EXPENSE_ID],
        expenseCategoryId: map[AppDataBase.COLUMN_EXPENSE_CATOGRY],
        expenseAmount: map[AppDataBase.COLUMN_EXPENSE_AMOUNT],
        expenseBalance: map[AppDataBase.COLUMN_EXPENSE_BALENCE],
        expenseDate: map[AppDataBase.COLUMN_EXPENSE_DATE],
        expenseDescription: map[AppDataBase.COLUMN_EXPENSE_DESCRIPTION],
        expenseTitle: map[AppDataBase.COLUMN_EXPENSE_TITLE],
        expenseType: map[AppDataBase.COLUMN_EXPENSE_PAYMENT_TYPE],
        userId: map[AppDataBase.COLUMN_USER_ID]);
  }

  /// to map // send
  Map<String, dynamic> toMap() {
    return {
      AppDataBase.COLUMN_EXPENSE_TITLE: expenseTitle,
      AppDataBase.COLUMN_EXPENSE_DESCRIPTION: expenseDescription,
      AppDataBase.COLUMN_EXPENSE_AMOUNT: expenseAmount,
      AppDataBase.COLUMN_EXPENSE_BALENCE: expenseBalance,
      AppDataBase.COLUMN_EXPENSE_CATOGRY: expenseCategoryId,
      AppDataBase.COLUMN_EXPENSE_PAYMENT_TYPE: expenseType,
      AppDataBase.COLUMN_EXPENSE_DATE: expenseDate,
      AppDataBase.COLUMN_USER_ID: userId,
    };
  }
}
