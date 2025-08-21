/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */

import 'package:shared_preferences/shared_preferences.dart';

class MyThemePreferences {
  static const THEME_KEY = "theme_key";

 static setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(THEME_KEY, value);
  }

 static getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_KEY) ?? false;
  }
}