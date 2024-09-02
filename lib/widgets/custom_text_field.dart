import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Colors.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController mController;
  String? mHintText;
  String? mLabelText;
  IconData? prefixIcon;
  IconData? suffixIcon;
  double mWith;
  TextInputType keyBoardType;


  CustomTextField(
      {super.key,
      required this.mController,
      this.mWith = double.infinity,
      this.mHintText,
      this.mLabelText,
      this.prefixIcon,
      this.suffixIcon,
      this.keyBoardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mWith,
      child: TextField(
        controller: mController,
        keyboardType: keyBoardType,

        decoration: InputDecoration(
          hintText: mHintText,
          label: mLabelText != null ? Text(mLabelText!) : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(width: 2, color: AppColors.appDeep),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:
                const BorderSide(width: 2, color: AppColors.appEditBox2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:
                const BorderSide(width: 2, color: AppColors.appEditBox2),
          ),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        ),
      ),
    );
  }
}
