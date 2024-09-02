import 'dart:core';

import '../data/app_data.dart';

class UserModel {
  int user_id;
  String user_name;
  String user_email;
  String user_number;
  String user_password;

  UserModel(
      {required this.user_id,
      required this.user_email,
      required this.user_name,
      required this.user_number,
      required this.user_password});

  /// from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        user_id: map[AppDataBase.COLUMN_USER_ID],
        user_email: map[AppDataBase.COLUMN_USER_EMAIL],
        user_name: map[AppDataBase.COLUMN_USER_NAME],
        user_number: map[AppDataBase.COLUMN_USER_NUMBER],
        user_password: map[AppDataBase.COLUMN_USER_PASSWORD]);
  }

  /// to map
  Map<String, dynamic> toMap() {
    return {
      AppDataBase.COLUMN_USER_NAME: user_name,
      AppDataBase.COLUMN_USER_EMAIL: user_email,
      AppDataBase.COLUMN_USER_NUMBER: user_number,
      AppDataBase.COLUMN_USER_PASSWORD: user_password,
    };
  }
}
