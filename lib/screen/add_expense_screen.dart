import 'package:expense_tracker_app/Colors.dart';
import 'package:expense_tracker_app/domain/app_constants.dart';
import 'package:expense_tracker_app/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});
  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  int selectedCategory = -1;
  String selectedMethod = "Debit";
  List<String> payMethod = ["Debit", "Credit", "Case", "Loan", "EMI"];

  DateTime? selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat.yMMMEd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Expense",
          style: TextStyle(fontFamily: "myFontFirst"),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomTextField(
              mController: titleController,
              mHintText: "Enter your title here...",
              mLabelText: "Title",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomTextField(
              mController: descriptionController,
              mHintText: "Enter your Description here...",
              mLabelText: "Description",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomTextField(
              mController: amountController,
              mHintText: "Enter your Description here...",
              mLabelText: "Amount",
            ),
          ),
          // Select Category
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 2 / 2.5),
                            itemCount: AppConstants.appCategory.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  selectedCategory = index;
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  elevation: 4,
                                  shadowColor: AppColors.appEditBox4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          "${AppConstants.appCategory[index]["iconPath"]}"),
                                      const SizedBox(height: 8),
                                      Text(
                                        "${AppConstants.appCategory[index]["title"]}",
                                        style: const TextStyle(
                                            fontFamily: "myFontFirst"),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                              width: 2, color: AppColors.appDeep))),
                  child: selectedCategory == -1
                      ? const Text(
                          "Select Category",
                          style: TextStyle(
                              fontFamily: "myFontFirst", fontSize: 24),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${AppConstants.appCategory[selectedCategory]["title"]}",
                                style: const TextStyle(
                                    fontFamily: "myFontFirst", fontSize: 24),
                              ),
                              Image.asset(
                                "${AppConstants.appCategory[selectedCategory]["iconPath"]}",
                                height: 40,
                                width: 40,
                              )
                            ],
                          ),
                        )),
            ),
          ),

          /// payment type
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Payment Method",
              style: TextStyle(fontSize: 20, fontFamily: "myFontFirst"),
            ),
          ),

          /// payment type
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: DropdownMenu(
              width: MediaQuery.of(context).size.width * 0.95,
              initialSelection: selectedMethod,
              trailingIcon: const Icon(
                Icons.arrow_circle_down_outlined,
                size: 30,
                color: AppColors.appDeep,
              ),
              selectedTrailingIcon: const Icon(
                Icons.arrow_circle_up_outlined,
                size: 25,
                color: AppColors.appEditBox4,
              ),
              onSelected: (value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
              dropdownMenuEntries: payMethod
                  .map((eachType) =>
                      DropdownMenuEntry(value: eachType, label: eachType))
                  .toList(),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          /// payment type
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Select Method",
              style: TextStyle(fontSize: 20, fontFamily: "myFontFirst"),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: AppColors.appEditBox4)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateFormat.format(selectedDate ?? DateTime.now()),
                      style: const TextStyle(
                          fontSize: 20, fontFamily: "myFontFirst"),
                    ),
                    IconButton(
                        onPressed: () async {
                          selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2022),
                              lastDate: DateTime.now());
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.calendar_month_rounded,
                          size: 30,
                          color: AppColors.appDeep,
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
