import 'package:expense_tracker_app/bloc/expense_bloc.dart';
import 'package:expense_tracker_app/bloc/expense_event.dart';
import 'package:expense_tracker_app/bloc/expense_state.dart';
import 'package:expense_tracker_app/domain/app_constants.dart';
import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:expense_tracker_app/model/filterExpenseModel.dart';
import 'package:expense_tracker_app/screen/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/Colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// here we get all filter data form filterExpenseModel
  List<FilterExpenseModel> allData = [];
  DateFormat dateFormat = DateFormat.MMMMEEEEd();

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(GetInitialExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/icon.png",
                  height: 80,
                  width: 80,
                ),
                const Text(
                  "Monety",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Icon(
              Icons.search,
              size: 35,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddExpenseScreen()));
          },
          backgroundColor: AppColors.appLight,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 3,
          label: const Row(
            children: [
              Icon(
                Icons.add,
                size: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Expense",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "myFontFirst"),
              )
            ],
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/images/boy.png",
                  height: 50,
                  width: 50,
                ),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Morning",
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                    Text(
                      "Rahul Kumar",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightSky,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "This month",
                          style: TextStyle(fontSize: 20),
                        ),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),

          /// box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.blue,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Expense total",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const Text(
                            "\$3,734",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4),
                                  child: Text(
                                    "+\$240",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "than last month",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 18),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: Image.asset(
                        "assets/images/box.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          /// Expense list
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Expense List",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                if (state is ExpenseLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ExpenseErrorState) {
                  return Center(
                    child: Text("Error : ${state.errorMessage}"),
                  );
                } else if (state is ExpenseLoadedState) {
                  var allExpense = state.mData;
                  filterExpenseDateWise(allExpense);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: allData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: AppColors.lightSky, width: 2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      allData[index].title,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "\$${allData[index].totalAmount}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 1,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: AppColors.lightSky),
                                  ),
                                ),
                              ),

                              /// sub list
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: allData[index].fExpense.length,
                                  itemBuilder: (context, childIndex) {
                                    /// category image path get
                                    String categoryImagePathGet = AppConstants
                                        .appCategory
                                        .where((element) =>
                                            element['id'] ==
                                            allData[index]
                                                .fExpense[childIndex]
                                                .expenseCategoryId)
                                        .toList()[0]['iconPath'];

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: AppColors.lightSky,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                    categoryImagePathGet),
                                              )),
                                          const SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                allData[index]
                                                    .fExpense[childIndex]
                                                    .expenseTitle,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                allData[index]
                                                    .fExpense[childIndex]
                                                    .expenseDescription,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                          const Expanded(child: SizedBox()),
                                          Text(
                                            "${allData[index].fExpense[childIndex].expenseAmount}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: allData[index]
                                                            .fExpense[
                                                                childIndex]
                                                            .expenseType ==
                                                        0
                                                    ? Colors.red
                                                    : Colors.green),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  ///-----------------------------Function-------------------------------------
  ///here we create function for filterExpense Date wise
  void filterExpenseDateWise(List<ExpenseModel> allExpense) {
    allData.clear();

    /// unique Dates
    List<String> uniqueDates = [];
    for (ExpenseModel eachExp in allExpense) {
      var eachDate = dateFormat.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expenseDate)));
      if (!uniqueDates.contains(eachDate)) {
        uniqueDates.add(eachDate);
      }
    }

    /// getting all expenses for all unique dates
    for (String eachDate in uniqueDates) {
      List<ExpenseModel> eachDateExpenses = [];
      num amt = 0;
      for (ExpenseModel eachExp in allExpense) {
        var eachExpDate = dateFormat.format(DateTime.fromMillisecondsSinceEpoch(
            int.parse(eachExp.expenseDate)));
        if (eachExpDate == eachDate) {
          eachDateExpenses.add(eachExp);

          /// debit
          if (eachExp.expenseType == 0) {
            amt -= eachExp.expenseAmount;
          } else {
            /// credit
            amt += eachExp.expenseAmount;
          }
        }
      }

      allData.add(FilterExpenseModel(
          title: eachDate, fExpense: eachDateExpenses, totalAmount: amt));
    }
  }
}
