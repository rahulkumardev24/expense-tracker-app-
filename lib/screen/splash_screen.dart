import 'package:expense_tracker_app/screen/home_screen.dart';
import 'package:expense_tracker_app/screen/main_screen.dart';
import 'package:flutter/material.dart';

import '../Colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/rrrr.png" , height: 400, width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
             const Text(
                "Easy Way to monitor ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const Text(
                "your expense ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
             const SizedBox(
                height: 20,
              ),
              const Text(
                "Safe your future by managing your",
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
              const Text(
                "expense right now",
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/dot.png",
                      height: 50,
                    ),
                    FloatingActionButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                        }, backgroundColor: AppColors.appPink,
                        child: const Icon(Icons.arrow_forward_rounded) ,)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
