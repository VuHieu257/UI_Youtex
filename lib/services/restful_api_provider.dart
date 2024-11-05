import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../core/base/base_dio.dart';
import '../model/address.dart';

abstract class ApiPath {
  ApiPath._();

  static const String login = 'login';
  static const String logout = 'auth/logout';
  static const String customer = 'auth/profile';
  static const String searchByPhone = 'buyer/user/';
  static const String register = 'register';
  static const String buyerAddress = 'buyer/addresses';
  static const String buyerDeleteAddress = 'buyer/address';
  static const String buyerAddAddress = 'buyer/address';
}

class RestfulApiProviderImpl {
  final DioClient dioClient = DioClient();

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
    } catch (error) {
      if (kDebugMode) {
        print('Error login: $error');
      }
      rethrow;
    }
  }

  Future logout({
    required String token,
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.logout,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error login: $error');
      }
      rethrow;
    }
  }

  ///******************************************************************
  ///---------------------------GET-----------------------------------
  ///******************************************************************
  Future<Map<String, dynamic>> getUserByPhone({
    required String token,
    required String phone,
  }) async {
    try {
      final response = await dioClient.get('${ApiPath.searchByPhone}/$phone',
        headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to load user');
    }
  }
  Future profile({
    required String token,
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.customer,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error login: $error');
      }
      rethrow;
    }
  }

  Future fetchAddresses({
    required String token,
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.buyerAddress,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        List<Address> listAddresses = (response.data['addresses'] as List)
            .map((json) => Address.fromJson(json))
            .toList();
        return listAddresses;
      } else {
        throw Exception('Failed to fetch addresses');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetch addresses: $error');
      }
      rethrow;
    }
  }

  ///******************************************************************
  ///---------------------------POST-----------------------------------
  ///******************************************************************
  Future register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await dioClient.post(
        ApiPath.register,
        body: {
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
        headers: {
          'Content-Type': 'application/json',
        },
      );
        return response;
    } catch (error) {
      if (kDebugMode) {
        print('Error login: $error');
      }
      rethrow;
    }
  }

  Future editProfile(
      {required String name,
      required String gender,
      required String birthday,
      required String imagePath,
      required String token}) async {
    try {
      FormData formData = FormData.fromMap({
        "name": name,
        "gender": gender,
        "birthday": birthday,
        "_method": "PUT",
        "image": await MultipartFile.fromFile(imagePath,
            filename: "name_profile_image.jpg"),
        // "image": imagePath,
      });
      final response = await dioClient.post(
        ApiPath.customer,
        body: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error login: $error');
      }
      rethrow;
    }
  }

  Future addAddresses({
    required String token,
    required String name,
    required String phone,
    required String country,
    required String province,
    required String ward,
    required String address,
    required int isDefault,
  }) async {
    try {
      final response = await dioClient.post(
        ApiPath.buyerAddAddress,
        body: {
          "name": name,
          "phone": phone,
          "country": country,
          "province": province,
          "ward": ward,
          "address": address,
          "longitude": "20.1234567",
          "latitude": "-20.1234567",
          "is_default": true
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print(response);
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to fetch addresses');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetch addresses: $error');
      }
      rethrow;
    }
  }

  ///******************************************************************
  ///---------------------------DELETE-----------------------------------
  ///******************************************************************
  Future deleteAddresses({
    required String token,
    required String id,
  }) async {
    try {
      final response = await dioClient.delete(
        "${ApiPath.buyerDeleteAddress}/$id",
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to fetch addresses');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetch addresses: $error');
      }
      rethrow;
    }
  }
}
