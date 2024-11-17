import 'package:flutter/cupertino.dart';

class NetworkConstants {
  NetworkConstants._();
  static const String baseUrl =
      //server testing
      "https://duclh.id.vn/api/v1/";
  //server testing image storage

  static const String STORAGE_URL = 'https://duclh.id.vn/storage/';

  static const String urlImage =
  //server testing
      "https://duclh.id.vn/storage/";
  static const Duration receiveTimeout = Duration(milliseconds: 5000);

  static const Duration connectionTimeout = Duration(milliseconds: 5000);

  static hideKeyBoard() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }
  static String convertToUnaccentedNoSpace(String input) {
    const accents =
        'áàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵđ';
    const unaccented =
        'aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd';

    String result = '';
    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      final index = accents.indexOf(char);
      if (index != -1) {
        result += unaccented[index];
      } else if (char != ' ') {
        result += char;
      }
    }

    return result;
  }

}
