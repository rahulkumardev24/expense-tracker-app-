import 'package:expense_tracker_app/bloc/expense_bloc.dart';
import 'package:expense_tracker_app/bloc/expense_state.dart';
import 'package:expense_tracker_app/screen/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/Colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tuesday = [
      {
        "icon": Icons.shopping_cart_outlined,
        "iconColors": Colors.blue,
        "iconBackGround": AppColors.lightSky,
        "title": "Shop",
        "subTitle": "Buy new clothes",
        "price": "-\$90"
      },
      {
        "icon": Icons.phone_android,
        "iconColors": Colors.orange,
        "iconBackGround": Colors.orange.shade50,
        "title": "Electronic",
        "subTitle": "Buy new iPhone 14 ",
        "price": "-\$1290"
      },
    ];

    List<Map<String, dynamic>> Mondey = [
      {
        "icon": Icons.car_rental,
        "iconColors": Colors.deepOrange,
        "iconBackGround": Colors.deepOrange.shade100,
        "title": "Transportation",
        "subTitle": "Trip to Malang",
        "price": "-\$60"
      },
    ];

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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExpenseScreen())) ;
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 100,
              child: BlocBuilder<ExpenseBloc , ExpenseState>(builder: (_ , state) {
                if(state is ExpenseLoadedState) {
                  return ListView.builder(
                    itemCount: state.mData.length,
                      itemBuilder: (_ , index) {
                    return ListTile(
                      title: Text(state.mData[index].expenseTitle),
                      subtitle: Text(state.mData[index].expenseDescription),
                      trailing: Text(state.mData[index].expenseAmount.toString()),
                    ) ;
                  }) ;
                } return Container() ;
              }),
            ),

            const SizedBox(height: 20),
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
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 30),
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
                            const Text(
                              "\$3,734",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Expense List",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Container(
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.lightSky, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tuesday, 14",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "-\$1830",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: AppColors.lightSky),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: tuesday.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: tuesday[index]["iconBackGround"],
                                  ),
                                  child: Icon(
                                    tuesday[index]["icon"],
                                    color: tuesday[index]["iconColors"],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tuesday[index]["title"],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      tuesday[index]["subTitle"],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  tuesday[index]["price"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Second List
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.lightSky, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Monday,13",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "-\$60",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: AppColors.lightSky),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: Mondey.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: tuesday[index]["iconBackGround"],
                                  ),
                                  child: Icon(
                                    Mondey[index]["icon"],
                                    color: Mondey[index]["iconColors"],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Mondey[index]["title"],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      Mondey[index]["subTitle"],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  Mondey[index]["price"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
