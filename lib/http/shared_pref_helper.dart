import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences pref;

  SharedPreferencesHelper({required this.pref});

  Future<void> setUserToken(String userToken) async {
    await pref.setString("userToken", userToken);
  }

  String get getUserToken {
    return pref.getString("userToken") ?? "";
  }

  Future<void> setName(String userToken) async {
    await pref.setString("userName", userToken);
  }

  String get getName {
    return pref.getString("userName") ?? "";
  }

  Future<void> setNumber(String userToken) async {
    await pref.setString("userNumber", userToken);
  }

  String get getNumber {
    return pref.getString("userNumber") ?? "";
  }

  Future<void> setAge(String userToken) async {
    await pref.setString("userAge", userToken);
  }

  String get getuserAge {
    return pref.getString("userAge") ?? "";
  }

  Future<void> setId(String userToken) async {
    await pref.setString("userId", userToken);
  }

  String get getuserId {
    return pref.getString("userId") ?? "";
  }

  Future<void> setEmail(String userToken) async {
    await pref.setString("userEmail", userToken);
  }

  String get getuserEmail {
    return pref.getString("userEmail") ?? "";
  }

  Future<void> setAddress(String userToken) async {
    await pref.setString("userAddress", userToken);
  }

  String get getuserAddress {
    return pref.getString("userAddress") ?? "";
  }

  Future<void> setLicenseNo(String userToken) async {
    await pref.setString("userLicenseNo", userToken);
  }

  String get getuserLicenseNo {
    return pref.getString("userLicenseNo") ?? "";
  }

  Future<void> setTypeLicense(String userToken) async {
    await pref.setString("userTypeLicense", userToken);
  }

  String get getuserTypeLicense {
    return pref.getString("userTypeLicense") ?? "";
  }

  Future<void> setIssueDate(String userToken) async {
    await pref.setString("userIssueDate", userToken);
  }

  String get getuserIssueDate {
    return pref.getString("userIssueDate") ?? "";
  }

  Future<void> setExpiryDate(String userToken) async {
    await pref.setString("userExpiryDate", userToken);
  }

  String get getuserExpiryDate {
    return pref.getString("userExpiryDate") ?? "";
  }
}
