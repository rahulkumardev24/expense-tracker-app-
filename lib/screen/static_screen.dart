import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../Colors.dart';

class StaticScreen extends StatefulWidget {
  const StaticScreen({super.key});

  @override
  State<StaticScreen> createState() => _StaticScreenState();
}

class _StaticScreenState extends State<StaticScreen> {
  double expenseValue = 3734; // Initial value for the expense
  List<String> filterType = ["Date", "Month", "Year", "Category"];
  String selectedFilter = "Date";




  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> Monday = [
      {
        "icon": Icons.shopping_cart_outlined,
        "iconColors": Colors.blue,
        "iconBackGround": AppColors.lightSky,
        "title": "Shop",
        "price": "-\$1190"
      },
      {
        "icon": Icons.car_crash_outlined,
        "iconColors": Colors.orange,
        "iconBackGround": Colors.orange.shade50,
        "title": "Transport",
        "price": "-\$890"
      },
      {
        "icon": Icons.phone_android,
        "iconColors": Colors.orange,
        "iconBackGround": Colors.orange.shade50,
        "title": "Electronic",
        "price": "-\$890"
      },
      {
        "icon": Icons.phone_android,
        "iconColors": Colors.orange,
        "iconBackGround": Colors.orange.shade50,
        "title": "Electronic",
        "price": "-\$890"
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Statistic",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.lightSky,
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
                            setState(() {
                              selectedFilter = value!;
                            });
                          },
                          dropdownMenuEntries: filterType
                              .map((eachType) => DropdownMenuEntry(
                              value: eachType, label: eachType))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ///----------------banner-----------------
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Expense total",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Image.asset(
                                  "assets/images/more.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "\$$expenseValue",
                                  style: const TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "/\$4000 per month",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                            Slider(
                              value: expenseValue,
                              onChanged: (value) {
                                setState(() {
                                  expenseValue = value;
                                });
                              },
                              max: 5000,
                              divisions: 5000,
                              min: 0,
                              thumbColor: null,
                              activeColor: Colors.yellow,
                              inactiveColor: Colors.white30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Bar chart showing dynamic data
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 300, // Adjust height as needed
               /* child: BarChart(
                  BarChartData(
                    barGroups: ,
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {

                            return Text("");
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(show: false),
                  ),
                ),*/
              ),
            ),
            const SizedBox(height: 20),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Spending Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  "Your expenses are divided into 6 categories",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Legend display
                // You can customize each category with different colors
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Monday.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 5 / 3,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Monday[index]["iconBackGround"],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Monday[index]["icon"],
                          size: 35,
                          color: Monday[index]["iconColors"],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Monday[index]["title"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              Monday[index]["price"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Monday[index]["iconColors"]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
