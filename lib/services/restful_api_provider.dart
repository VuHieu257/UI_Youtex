import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ui_youtex/bloc_seller/seller_register_identification_bloc/seller_register_identification_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_bloc/seller_register_event.dart';
import 'package:ui_youtex/bloc_seller/seller_register_product_bloc_bloc/seller_register_product_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_tax_get_bloc/seller_register_tax_get_bloc_bloc.dart';
import 'package:ui_youtex/core/model/bank.dart';
import 'package:ui_youtex/core/model/shipping.dart';
import 'package:ui_youtex/core/model/store.info.dart';

import '../bloc_seller/seller_register_bloc/seller_register_bloc.dart';
import '../core/base/base_dio.dart';
import '../model/address.dart';

abstract class ApiPath {
  ApiPath._();

  static const String login = 'login';
  static const String logout = 'auth/logout';
  static const String customer = 'auth/profile';
  static const String forgotPassword = 'forgot-password';
  static const String searchByPhone = 'buyer/user/';
  static const String register = 'register';
  static const String buyerAddress = 'buyer/addresses';
  static const String buyerDeleteAddress = 'buyer/address';
  static const String buyerAddAddress = 'buyer/address';
  static const String paymentMethods = 'buyer/payment-methods';
  static const String bankAccount = 'buyer/bank-account';
  static const String creditCard = 'buyer/credit-card';
// buyer/payment-methods
// api/v1/buyer/bank-account
//{
//   "bank": "Sacombank",
//   "branch": "Tân Phú",
//   "number": "1234567811",
//   "card_holder": "Lư Hữu Đức",
//   "is_default": true
// }
//pi/v1/buyer/credit-card
//{
//     "type": "visa",
//     "number": "1111111111111112",
//     "expiration": "29/12",
//     "cvv": "123",
//     "card_holder": "Lư Hữu Đức",
//     "address": "Tân Phú",
//     "postal_code": "720000"
// }

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

  ///*******************************MALL***********************************
  ///*******************************POST***********************************

  static const String sellerRegistorPost = 'seller/store';

  static const String sellerRAddressPost = 'seller/address';
  static const String sellerTaxPost = 'seller/tax';
  static const String selleridentificationPost = 'seller/identification';
  static const String sellershippingunitsPost = 'seller/shipping-unit';
  // static const String sellerpaymentmethodssPost = 'seller/payment-methods';
  // static const String sellerswalletPost = 'seller/shipping-wallet';
  static const String sellerscategoriesPost = 'seller/category';
  static const String sellersproductsPost = 'seller/products';
  static const String sellersproductdetailsPost = 'seller/product-detail';
  static const String sellersproductsalesPost = 'seller/product-sales';
  static const String sellersproductshippingPost = 'seller/product-shipping';
  static const String sellersproductextra = 'seller/product-extra';
  static const String sellerRBankAccountPost = 'seller/bank-account';

  ///******************************GET************************************

  static const String sellerRegistorGet = 'seller/store';
  static const String sellerRAddressGet = 'seller/addresses';
  static const String sellerTaxGet = 'seller/tax';
  static const String selleridentificationGet = 'seller/identification';
  static const String sellershippingunitsGet = 'seller/shipping-units';
  static const String sellerpaymentmethodssGet = 'seller/payment-methods';
  static const String sellerswalletGet = 'seller/shipping-wallet';

  static const String sellerscategoriesGet = 'seller/categories';
  static const String sellersindustriesGet = 'seller/industries';
  static const String sellersproductsGet = 'seller/products';
  static const String sellershippingunitspost = 'seller/shipping-unit';

  static const String sellersproductdetailsGet = 'seller/product-detail/:id';
  static const String sellersproductshippingGet = 'seller/product-shipping/id';
  static const String sellersproductextraGet = 'seller/product-extra/id';
  static const String sellerstorestatusGet = '/seller/store/status';
  static const String sellerstorestatussGetGet = '/seller/product/:id/status';

  ///*******************************DELETE***********************************
  static const String sellerRAddressDelete = 'seller/address/id';

  ///*******************************Update***********************************
  ///---------------------------Product-----------------------------------
  ///******************************GET************************************
  static const String sellerRegisterProductGet = '/seller/products';

  ///*******************************POST***********************************
  static const String sellerRegisterProductPost = '/seller/product';
}

class RestfulApiProviderImpl {
  final DioClient dioClient = DioClient();
  final Dio _dio = Dio();
  static const String authToken =
      '2|TF2GUoa5kp1jaMHRDQbYRhymIzXrNChTYJ8Lq1xLe31b5005';
  static const String authType = 'Bearer';

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
  Future<Map<String, dynamic>> getAllPaymentMethods({
    required String token,
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.paymentMethods,
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

  Future<Map<String, dynamic>> getUserByPhone({
    required String token,
    required String phone,
  }) async {
    try {
      final response = await dioClient.get(
        '${ApiPath.searchByPhone}/$phone',
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
  Future forgotPassword({
    required String email,
  }) async {
    try {
      final response = await dioClient.post(
        ApiPath.forgotPassword,
        body: {
          "email": email,
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

  Future addBankAccount({
    required String token,
    required String bank,
    required String branch,
    required String number,
    required String cardHolder,
    required String isDefault,
  }) async {
    try {
      final response = await dioClient.post(
        ApiPath.bankAccount,
        body: {
          "bank": bank,
          "branch": branch,
          "number": number,
          "card_holder": cardHolder,
          "is_default": isDefault
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
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

  Future addCreditCard({
    required String token,
    required String type,
    required String number,
    required String expiration,
    required String cvv,
    required String cardHolder,
    required String address,
    required String postalCode,
  }) async {
    try {
      final response = await dioClient.post(
        ApiPath.creditCard,
        body: {
          "type": type,
          "number": number,
          "expiration": expiration,
          "cvv": cvv,
          "card_holder": cardHolder,
          "address": address,
          "postal_code": postalCode
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
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

  /// Seller a new store
  Future<Response> registerStore({
    required String name,
    required String imagePath,
    required String phone,
    required String email,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'phone': phone,
        'email': email,
        'auth_type': authType,
        'image': await MultipartFile.fromFile(
          imagePath,
          filename: 'store_image.jpg',
        ),
      });

      if (kDebugMode) {
        print('Request URL: ${NetworkConstants.baseUrl}${ApiPath.store}');
        print('Request Data: ${formData.fields}');
      }

      // Make the API request
      final response = await dioClient.post(
        ApiPath.sellerRegistorPost,
        body: formData,
        headers: {
          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );
      if (kDebugMode) {
        print('Response Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      }

      throw Exception(
        'Failed to register store. Status: ${response.statusCode}',
      );
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      if (e.response?.data != null && e.response?.data['errors'] != null) {
        final errors = e.response?.data['errors'];
        if (errors is Map) {
          // Check all possible error fields
          final firstError = errors.values
              .whereType<List>()
              .firstWhere((list) => list.isNotEmpty, orElse: () => [])
              .firstOrNull;
          if (firstError != null) {
            throw firstError.toString();
          }
        }
      }

      // Handle specific error cases
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 404) {
            throw 'Không tìm thấy API endpoint. Vui lòng kiểm tra lại URL.';
          }
          throw 'Lỗi từ server: ${e.response?.statusCode ?? "Unknown"}';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi đăng ký cửa hàng';
    }
  }

  Future<StoreInfo> getStoreInfo({
    String authType = 'Bearer',
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.sellerRegistorGet,
        headers: {
          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('GET Response Status Code: ${response.statusCode}');
        print('GET Response Data: ${response.data}');
      }

      if (response.statusCode == 200) {
        // Kiểm tra xem response.data có phải là Map không
        if (response.data is Map<String, dynamic>) {
          // Lấy thông tin store từ response
          final storeData = response.data['store'] ?? response.data;
          return StoreInfo.fromJson(storeData);
        } else {
          throw FormatException('Invalid response format');
        }
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Failed to get store info. Status: ${response.statusCode}',
      );
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 404) {
            throw 'Không tìm thấy API endpoint. Vui lòng kiểm tra lại URL.';
          } else if (e.response?.statusCode == 401) {
            throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
          }
          throw 'Lỗi từ server: ${e.response?.statusCode ?? "Unknown"}';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi lấy thông tin cửa hàng';
    }
  }

  Future<Response> getAddress() async {
    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.sellerRAddressGet}');
    }

    try {
      final response = await dioClient.get(
        ApiPath.sellerRAddressGet,
        headers: {
          'Content-Type': 'application/json', // Đảm bảo gửi dữ liệu JSON

          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('POST Response Status Code: ${response.statusCode}');
        print('POST Response Data: ${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Address posted successfully');
        return response;
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to post address. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw 'Không tìm thấy API endpoint. Vui lòng kiểm tra lại URL.';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi gửi địa chỉ';
    }
  }

  Future<Response> postAddress({
    required String name,
    required String phone,
    required String country,
    required String province,
    required String ward,
    required String address,
    required String longitude,
    required String latitude,
    required bool isDefault,
  }) async {
    final requestBody = {
      'name': name,
      'phone': phone,
      'country': country,
      'province': province,
      'ward': ward,
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
      'is_default': isDefault,
    };

    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.sellerRAddressPost}');
      print('Request Data: $requestBody');
    }

    try {
      final response = await dioClient.post(
        ApiPath.sellerRAddressPost,
        body: requestBody,
        headers: {
          'Content-Type': 'application/json', // Đảm bảo gửi dữ liệu JSON

          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('POST Response Status Code: ${response.statusCode}');
        print('POST Response Data: ${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Address posted successfully');
        return response;
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to post address. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw 'Không tìm thấy API endpoint. Vui lòng kiểm tra lại URL.';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi gửi địa chỉ';
    }
  }

  Future<Response> getTax() async {
    if (kDebugMode) {
      print('Request URL: ${NetworkConstants.baseUrl}${ApiPath.sellerTaxGet}');
    }

    try {
      final response = await dioClient.get(
        ApiPath.sellerTaxGet,
        headers: {
          'Content-Type': 'application/json', // Đảm bảo gửi dữ liệu JSON

          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('Getg Response Status Code: ${response.statusCode}');
        print('GetG Response Data: ${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Tax Get successfully');
        return response;
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to post address. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw 'Không tìm thấy API endpoint. Vui lòng kiểm tra lại URL.';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi gửi Tax';
    }
  }

  Future<bool> postTax(SellerRegisterTaxModel tax) async {
    try {
      // Prepare FormData with the tax information
      final formData = FormData.fromMap({
        'type': tax.type,
        'address': tax.address,
        'email': tax.email,
        'tax_code': tax.taxCode,
        'name': tax.name,
        'business_license': tax.businessLicense != null
            ? await MultipartFile.fromFile(
                tax.businessLicense!,
                filename: 'business_license.jpg',
              )
            : null,
      });

      // Send POST request to update tax information
      final response = await dioClient.post(
        ApiPath.sellerTaxPost,
        body: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('Post Tax Response Status Code: ${response.statusCode}');
        print('Post Tax Response Data: ${response.data}');
      }

      // Check response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Tax information posted successfully');
        return true;
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to post tax information. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw 'Không tìm thấy API endpoint. Vui lòng kiểm tra lại URL.';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi gửi Tax';
    }
  }

  Future<Response> getidentification() async {
    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.selleridentificationPost}');
    }

    try {
      final response = await dioClient.get(
        ApiPath.selleridentificationPost,
        headers: {
          'Content-Type': 'application/json', // Đảm bảo gửi dữ liệu JSON

          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('Getg Response Status Code: ${response.statusCode}');
        print('GetG Response Data: ${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('  Get successfully');
        return response;
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception('Failed to post  . Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw 'Không tìm thấy API endpoint. Vui lòng kiểm tra lại URL.';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi gửi Tax';
    }
  }

  Future<bool> postIdentification(
      SellerIdentificationModel identification) async {
    try {
      // Prepare FormData with identification information
      final formData = FormData.fromMap({
        // Set default values if fields are null or empty
        'type': identification.type?.isNotEmpty == true
            ? identification.type
            : 'id_card',
        'number':
            identification.number.isNotEmpty ? identification.number : '123456',
        'name': identification.name?.isNotEmpty == true
            ? identification.name
            : 'Default Name',

        // Handle image upload if image path is not empty
        'image': identification.image.isNotEmpty
            ? await MultipartFile.fromFile(
                identification.image,
                filename: 'identification_image.jpg',
              )
            : null,

        // Handle selfie upload if selfie path is not empty
        'selfie': identification.selfie.isNotEmpty
            ? await MultipartFile.fromFile(
                identification.selfie,
                filename: 'identification_selfie.jpg',
              )
            : null,
      });

      // Send POST request to update identification information
      final response = await dioClient.post(
        ApiPath.selleridentificationPost,
        body: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print(
            'Post Identification Response Status Code: ${response.statusCode}');
        print('Post Identification Response Data: ${response.data}');
      }

      // Check response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Identification information posted successfully');
        return true;
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to post identification information. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw 'Không tìm thấy API endpoint. Vui lòng kiểm tra lại URL.';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi gửi thông tin identification';
    }
  }

  Future<Response> postBankAccount({
    required String bankName,
    required String branch,
    required String accountNumber,
    required String cardHolder,
    required bool isDefault,
  }) async {
    // Create the request body with the required fields for a bank account
    final requestBody = {
      'bank_name': bankName,
      'branch': branch,
      'account_number': accountNumber,
      'card_holder': cardHolder,
      'is_default': isDefault,
    };

    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.sellerRBankAccountPost}');
      print('Request Data: $requestBody');
    }

    try {
      final response = await dioClient.post(
        ApiPath.sellerRBankAccountPost,
        body: requestBody, // Use 'data' instead of 'body' for Dio requests
        headers: {
          'Content-Type': 'application/json', // Ensure JSON data format
          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('POST Response Status Code: ${response.statusCode}');
        print('POST Response Data: ${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Bank account posted successfully');
        return response;
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to post bank account. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw 'Không tìm thấy API endpoint. Vui lòng kiểm tra lại URL.';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi gửi thông tin tài khoản ngân hàng';
    }
  }

  Future<BankAccountResponse> sellerpaymentmethodssGet() async {
    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.selleridentificationPost}');
    }

    try {
      final response = await dioClient.get(
        ApiPath.sellerpaymentmethodssGet,
        headers: {
          'Content-Type': 'application/json', // Ensure JSON data format
          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('Get Response Status Code: ${response.statusCode}');
        print('Get Response Data: ${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Get successfully');
        return BankAccountResponse.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to get identification. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw 'Không tìm thấy API endpoint. Vui lòng kiểm tra lại URL.';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi gửi yêu cầu xác minh';
    }
  }

  Future<List<SellerRegisterProductModel>?> getProduct() async {
    try {
      final response = await dioClient.get(
        ApiPath.sellerRegisterProductGet,
        headers: {
          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('Get Product Response Status Code: ${response.statusCode}');
        print('Get Product Response Data: ${response.data}');
      }

      if (response.statusCode == 200) {
        // Extract the products array from the response
        final Map<String, dynamic> responseData = response.data;
        if (responseData.containsKey('products')) {
          final List<dynamic> productsData = responseData['products'];
          return productsData
              .map((item) => SellerRegisterProductModel.fromJson(item))
              .toList();
        } else {
          return [];
        }
      } else if (response.statusCode == 404) {
        print('No product information found.');
        return [];
      } else {
        throw Exception(
            'Failed to get product information. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw 'Lỗi kết nối hoặc lỗi từ server';
    } catch (error) {
      throw 'Đã xảy ra lỗi không xác định khi lấy thông tin sản phẩm';
    }
  }

  Future<bool> postProduct(ProductPostModel product) async {
    try {
      // Kiểm tra xem tất cả các hình ảnh có tồn tại không
      for (String imagePath in product.images) {
        if (!File(imagePath).existsSync()) {
          throw 'Hình ảnh không tồn tại: $imagePath';
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
      // Giới hạn số lượng ảnh tối đa là 9
      final limitedImages = product.images.take(9).toList();

      // Chuyển đổi danh sách đường dẫn hình ảnh thành danh sách MultipartFile
      final List<MultipartFile> imageFiles = await Future.wait(
        limitedImages.map((imagePath) async {
          return await MultipartFile.fromFile(imagePath,
              filename: imagePath.split('/').last);
        }).toList(),
      );

      // Kiểm tra nếu không có hình ảnh nào được chọn
      if (imageFiles.isEmpty) {
        throw 'Cần phải có ít nhất một hình ảnh.';
      }

      // Chuẩn bị FormData
      final formData = FormData.fromMap({
        'industry_id': product.industryId,
        'category_id': product.categoryId,
        'images[]': imageFiles, // Đảm bảo rằng images[] là một mảng
        'video': product.video != null && await File(product.video!).exists()
            ? await MultipartFile.fromFile(product.video!,
                filename: 'video.mp4')
            : null,
        'name': product.name,
        'description': product.description,
      });

      // Gửi yêu cầu POST
      final response = await dioClient.post(
        ApiPath.sellerRegisterProductPost,
        body: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('Post Product Response Status Code: ${response.statusCode}');
        print('Post Product Response Data: ${response.data}');
      }

      // Kiểm tra trạng thái phản hồi
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Product information posted successfully');
        return true;
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to post product information. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      // Xử lý các loại lỗi khác nhau
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw 'Không tìm thấy API endpoint. Vui lòng kiểm tra lại URL.';
          } else if (statusCode == 422) {
            // Thêm xử lý lỗi chi tiết cho 422
            final errorData = e.response?.data;
            throw 'Lỗi xử lý yêu cầu: ${errorData['errors'] ?? 'Đã xảy ra lỗi.'}';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw error;
    }
  }

  Future<bool> sendShippingData(
      {String shippingUnit = 'Default Shipping Unit',
      String description = 'Default Description',
      Map<String, dynamic> settings = const {
        'is_cod': 1,
        'is_active': 1
      }}) async {
    // Tạo requestBody với dữ liệu mặc định
    Map<String, dynamic> requestBody = {
      "shipping_units": [
        {
          "id": 1,
          "name": shippingUnit,
          "description": description,
          "settings": settings,
        }
      ]
    };

    // In thông tin yêu cầu khi ở chế độ debug
    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.sellershippingunitsPost}');
      print('Request Data: $requestBody');
    }

    try {
      // Gửi yêu cầu POST
      final response = await dioClient.post(
        '${NetworkConstants.baseUrl}${ApiPath.sellershippingunitsPost}',
        body:
            requestBody, // Sử dụng 'data' thay vì 'body' cho yêu cầu POST với Dio
        headers: {
          'Content-Type':
              'application/json', // Đảm bảo gửi dữ liệu dưới dạng JSON
          'Authorization': '$authType $authToken',
          'Accept': 'application/json',
        },
      );

      // In thông tin phản hồi khi ở chế độ debug
      if (kDebugMode) {
        print('POST Response Status Code: ${response.statusCode}');
        print('POST Response Data: ${response.data}');
      }

      // Kiểm tra mã trạng thái phản hồi
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Shipping data posted successfully');
        return true; // Trả về true khi gửi thành công
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to post shipping data. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Xử lý lỗi khi sử dụng Dio
      if (kDebugMode) {
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
        print('DioError Response: ${e.response?.data}');
      }

      // Xử lý theo loại lỗi Dio
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw 'Kết nối tới server bị timeout. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 404) {
            throw 'Không tìm thấy API endpoint. Vui lòng kiểm tra lại URL.';
          }
          throw 'Lỗi từ server: $statusCode';
        case DioExceptionType.cancel:
          throw 'Yêu cầu đã bị hủy';
        default:
          throw 'Lỗi kết nối: ${e.message}';
      }
    } catch (error) {
      // Xử lý lỗi chung khi có lỗi ngoài Dio
      if (kDebugMode) {
        print('General Error: $error');
      }
      throw 'Đã xảy ra lỗi không xác định khi gửi thông tin tài khoản ngân hàng';
    }
  }
}
