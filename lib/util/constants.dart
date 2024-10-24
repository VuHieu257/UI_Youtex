import 'package:flutter/cupertino.dart';

class NetworkConstants {
  NetworkConstants._();
  static const String baseUrl =
  //server testing
  "https://kimi-api.sharework-academy.com/api/";
      
  //server domain 
  // "https://kitemite2.ataraxiashorin.com/api/";

  //server customer
  // "https://kitemite2.ataraxiashorin.com/api/";
  static const String baseAuthUrl =
      "https://kitemite2.ataraxiashorin.com/auth/";
      // "https://kimi-api.sharework-academy.com/auth/";


  static const Duration receiveTimeout = Duration(milliseconds: 5000);

  static const Duration connectionTimeout = Duration(milliseconds: 5000);

  static hideKeyBoard() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

}