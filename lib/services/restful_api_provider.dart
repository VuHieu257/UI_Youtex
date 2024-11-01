import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../core/base/base_dio.dart';
import '../util/constants.dart';

abstract class ApiPath {
  ApiPath._();

  static const String customer = 'v2/customer';
  static const String checkAccount = 'v2/customer/check';

  static const String login = 'login';
  static const String logout = 'logout';

  static const String store = 'v2/store';
  static const String storeName = 'v2/store/store-name';
  static const String searchStore = 'v2/store/search';
  static const String storeNearby = 'v2/store/nearby';

  static const String productStore = 'v2/product/store';
  static const String productWarehouse = 'v2/product/ware-house';
  static const String product = 'v2/product';
  static const String historyProduct = 'v2/history-update-product';
  static const String productOfWareHouse = 'v2/product/storeId-wareHouseId';

  static const String places = 'place/autocomplete/json';
  static const String searchWareHouse = 'v2/ware-house/warehousesName';
  static const String wareHouseNearby = 'v2/ware-house/nearby';
  static const String wareHouse = 'v2/ware-house';

  static const String order = 'v1/order';
  static const String shoppingCart = 'v1/shopping-cart';
  static const String payment = 'create-payment-intent';
  static const String cartCustomer = 'v1/shopping-cart/customer';
}
class RestfulApiProviderImpl {
  final DioClient dioClient = DioClient();
  final Dio _dio = Dio();

  ///******************************************************************
  ///---------------------------Auth-----------------------------------
  ///******************************************************************
  Future login({
    required String userName,
    required String password,
  }) async {
    try {
      final response = await dioClient.post(
        ApiPath.login,
        body: {
          "email": userName,
          "password": password,
        },
        headers: {
            'Content-Type': 'application/json',
          },
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to login');
      }
    }on DioException catch (e) {
      if (e.response?.data != null && e.response?.data['errors'] != null) {
        final errors = e.response?.data['errors'];
        final emailError = errors['email']?[0];
        throw emailError ?? 'Unknown error';
      } else {
        throw 'Lỗi không xác định';
      }
    }  catch (error) {
      if (kDebugMode) {
        print('Error login: $error');
      }
      rethrow;
    }
  }

  // Future logout() async {
  //   try {
  //     final response = await _dio.put(
  //       "${NetworkConstants.baseAuthUrl}${ApiPath.logout}",
  //       // data: {
  //       //   "token": token,
  //       // },
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //         },
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       return response;
  //     } else {
  //       throw Exception('Failed to login');
  //     }
  //   } catch (error) {
  //     if (kDebugMode) {
  //       print('Error login: $error');
  //     }
  //     rethrow;
  //   }
  // }

  ///******************************************************************
  ///---------------------------GET-----------------------------------
  ///******************************************************************



  ///******************************************************************
  ///---------------------------PUT-----------------------------------
  ///******************************************************************


}
