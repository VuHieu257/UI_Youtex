import 'package:flutter/cupertino.dart';

class NetworkConstants {
  NetworkConstants._();
  static const String baseUrl =
      //server testing
      "http://52.77.246.91/api/v1/";
  //server testing image storage

  static const String STORAGE_URL = 'http://52.77.246.91/storage/';

  static const Duration receiveTimeout = Duration(milliseconds: 5000);

  static const Duration connectionTimeout = Duration(milliseconds: 5000);

  static hideKeyBoard() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
