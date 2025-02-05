import 'package:expense_tracker_app/bloc/expense_bloc.dart';
import 'package:expense_tracker_app/bloc/expense_event.dart';
import 'package:expense_tracker_app/bloc/expense_state.dart';
import 'package:expense_tracker_app/domain/app_constants.dart';
import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:expense_tracker_app/model/filterExpenseModel.dart';
import 'package:expense_tracker_app/screen/add_expense_screen.dart';
import 'package:expense_tracker_app/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/Colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../domain/app_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FilterExpenseModel> allData = [];
  num balance = 0.0;

  DateFormat dateFormat = DateFormat.MMMMEEEEd();
  DateFormat monthFormat = DateFormat.yMMMM();
  DateFormat yearFormat = DateFormat.y();

  List<String> filterType = ["Date", "Month", "Year", "Category"];
  String selectedFilter = "Date";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(GetInitialExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isLight ? Colors.white : Colors.black,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: isLight ? Colors.black : Colors.white,
                size: 35,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                // Open the drawer when the image is tapped
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Image.asset(
                "assets/images/icon.png",
                height: 80,
                width: 80,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "MoneyMap",
              style: mTextStyle18(
                  fontColor: isLight ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/money.png",
                    height: 100,
                    width: 100,
                  ),
                  const Text(
                    'MoneyMap',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Setting'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()));
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Handle item tap
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddExpenseScreen(
                          balanceTillNow: balance,
                        )));
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Morning",
                          style: mTextStyle15(
                              fontColor:
                                  isLight ? Colors.black87 : Colors.white)),
                      Text(
                        "Rahul Kumar",
                        style: mTextStyle18(
                            fontWeight: FontWeight.bold,
                            fontColor: isLight ? Colors.black : Colors.white),
                      ),
                    ],
                  ),

                  const Expanded(child: SizedBox()),

                  /// ---------------------- filter drop down menu --------------------
                  Container(
                    decoration: BoxDecoration(
                        color: isLight
                            ? AppColors.appEditBox1.withOpacity(0.5)
                            : AppColors.appLight,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: AppColors.appDeep)),
                    child: Row(
                      children: [
                        DropdownMenu(
                          trailingIcon: const Icon(
                            Icons.filter_list_alt,
                            color: AppColors.appEditBox4,
                          ),
                          initialSelection: selectedFilter,
                          onSelected: (value) {
                            selectedFilter = value!;
                            setState(() {});
                          },
                          dropdownMenuEntries: filterType
                              .map((eachType) => DropdownMenuEntry(
                                  value: eachType, label: eachType))
                              .toList(),
                        ),
                      ],
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text("\$$balance",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(fontWeight: FontWeight.bold)),
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
              child: BlocConsumer<ExpenseBloc, ExpenseState>(
                listener: (_, state) {
                  if (state is ExpenseLoadedState) {
                    balance = state.mData.isNotEmpty
                        ? state.mData.last.expenseBalance
                        : 0.0;
                    setState(() {});
                  }
                },
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
                    var allExpense = state.mData.reversed.toList();

                    /// reversed apply for latest data show

                    /// here we apply switch condition for display expense according to date , month , year , category
                    switch (selectedFilter) {
                      case "Date":
                        filterExpenseDateWise(allExpense);
                        break;
                      case "Month":
                        filterExpenseMonthWise(allExpense);
                        break;
                      case "Year":
                        filterExpenseYearWise(allExpense);
                        break;
                      case "Category":
                        filterExpenseCategoryWise(allExpense);
                        break;
                      default:
                        allData.clear();
                        break;
                    }

                    return allExpense.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: allData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColors.lightSky, width: 2),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(allData[index].title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            Text(
                                                "\$${allData[index].totalAmount}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                                width: 2,
                                                color: AppColors.lightSky),
                                          ),
                                        ),
                                      ),

                                      /// sub list
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              allData[index].fExpense.length,
                                          itemBuilder: (context, childIndex) {
                                            /// category image path get
                                            String categoryImagePathGet =
                                                AppConstants.appCategory
                                                    .where((element) =>
                                                        element['id'] ==
                                                        allData[index]
                                                            .fExpense[
                                                                childIndex]
                                                            .expenseCategoryId)
                                                    .toList()[0]['iconPath'];

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color:
                                                            AppColors.lightSky,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Image.asset(
                                                            categoryImagePathGet),
                                                      )),
                                                  const SizedBox(width: 20),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        allData[index]
                                                            .fExpense[
                                                                childIndex]
                                                            .expenseTitle,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        allData[index]
                                                            .fExpense[
                                                                childIndex]
                                                            .expenseDescription,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium,
                                                      ),
                                                    ],
                                                  ),
                                                  const Expanded(
                                                      child: SizedBox()),
                                                  Text(
                                                    "${allData[index].fExpense[childIndex].expenseAmount}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/wallet.png",
                                  height: 100,
                                  width: 100,
                                ),
                                const Text(
                                  "No expense found",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: "myFontFirst",
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black87),
                                ),
                              ],
                            ),
                          );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
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

  /// month wise filter
  void filterExpenseMonthWise(List<ExpenseModel> allExpense) {
    allData.clear();
    List<String> uniqueMonths = [];
    for (ExpenseModel eachExp in allExpense) {
      var eachMonth = monthFormat.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expenseDate)));
      if (!uniqueMonths.contains(eachMonth)) {
        uniqueMonths.add(eachMonth);
      }
    }

    for (String eachMonth in uniqueMonths) {
      List<ExpenseModel> eachMonthExpenses = [];
      num amt = 0;
      for (ExpenseModel eachExp in allExpense) {
        var eachExpMonth = monthFormat.format(
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(eachExp.expenseDate)));
        if (eachExpMonth == eachMonth) {
          eachMonthExpenses.add(eachExp);
          if (eachExp.expenseType == 0) {
            amt -= eachExp.expenseAmount;
          } else {
            amt += eachExp.expenseAmount;
          }
        }
      }
      allData.add(FilterExpenseModel(
        title: eachMonth,
        fExpense: eachMonthExpenses,
        totalAmount: amt,
      ));
    }
  }

  /// year-wise filter
  void filterExpenseYearWise(List<ExpenseModel> allExpense) {
    allData.clear();

    List<String> uniqueYears = [];

    // Extract unique years
    for (ExpenseModel eachExp in allExpense) {
      var eachYear = yearFormat.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expenseDate)));
      if (!uniqueYears.contains(eachYear)) {
        uniqueYears.add(eachYear);
      }
    }

    // Filter expenses by each unique year
    for (String eachYear in uniqueYears) {
      List<ExpenseModel> eachYearExpenses = [];
      num amt = 0;

      for (ExpenseModel eachExp in allExpense) {
        var eachExpYear = yearFormat.format(DateTime.fromMillisecondsSinceEpoch(
            int.parse(eachExp.expenseDate)));
        if (eachExpYear == eachYear) {
          eachYearExpenses.add(eachExp);

          // Calculate total amount (income and expense)
          if (eachExp.expenseType == 0) {
            amt -= eachExp.expenseAmount; // Expense
          } else {
            amt += eachExp.expenseAmount; // Income
          }
        }
      }

      // Add the filtered data with total amount for the year
      allData.add(FilterExpenseModel(
        title: eachYear,
        fExpense: eachYearExpenses,
        totalAmount: amt,
      ));
    }
  }

  /// Category-wise filter
  void filterExpenseCategoryWise(List<ExpenseModel> allExpense) {
    allData.clear();

    // Create a map to hold category-wise data
    Map<String, List<ExpenseModel>> categoryMap = {};

    // Populate the map with expenses categorized by category title
    for (ExpenseModel eachExp in allExpense) {
      String? categoryTitle = getCategoryTitle(eachExp.expenseCategoryId);
      if (categoryTitle != null) {
        if (!categoryMap.containsKey(categoryTitle)) {
          categoryMap[categoryTitle] = [];
        }
        categoryMap[categoryTitle]!.add(eachExp);
      }
    }

    // Process each category to calculate total amounts and create FilterExpenseModel
    for (var entry in categoryMap.entries) {
      String categoryTitle = entry.key;
      List<ExpenseModel> expenses = entry.value;
      num totalAmount = 0;
      for (ExpenseModel eachExp in expenses) {
        if (eachExp.expenseType == 0) {
          totalAmount -= eachExp.expenseAmount; // Expense
        } else {
          totalAmount += eachExp.expenseAmount; // Income
        }
      }
      allData.add(FilterExpenseModel(
        title: categoryTitle,
        fExpense: expenses,
        totalAmount: totalAmount,
      ));
    }
  }

  String? getCategoryTitle(int categoryId) {
    for (var category in AppConstants.appCategory) {
      if (category['id'] == categoryId) {
        return category['title'];
      }
    }
    return null;
  }
}
