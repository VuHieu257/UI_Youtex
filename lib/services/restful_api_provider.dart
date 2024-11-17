import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ui_youtex/bloc/product_bloc_bloc/product_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_identification_bloc/seller_register_identification_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_product_bloc_bloc/seller_register_product_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_tax_get_bloc/seller_register_tax_get_bloc_bloc.dart';
import 'package:ui_youtex/core/model/bank.dart';
import 'package:ui_youtex/core/model/store.info.dart';
import 'package:ui_youtex/model/industry.dart';

import '../core/base/base_dio.dart';
import '../model/address.dart';
import '../model/cart.dart';
import '../model/cart_sponse.dart';
import '../model/product_model.dart';
import '../util/constants.dart';

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

  ///*******************************BuyerProduct*******************************
  ///******************************GET************************************
  ///

  static const String BuyerproductsGet = 'buyer/products';
  static const String BuyerbestproductsGet = 'buyer/products/best-sellers';
  static const String BuyersearcnproductsGet = 'buyer/search/products';
  static const String BuyerindustryproductsGet = 'buyer/products';
  static const String BuyerUUIDproductsGet = 'buyer/products';
  static const String BuyeIndustrysGet = 'buyer/industries';
  static const String buyerGetCart = 'buyer/cart';

  static String buyerGetProductDetail(uuid) => 'buyer/product/$uuid';
  static String addCart(uuid) => 'buyer/product/$uuid/add-cart';

  ///*******************************ALL***********************************
  ///*******************************POST***********************************

  static const String sellerRegistorPost = 'seller/store';

  static const String sellerRAddressPost = 'seller/address';
  static const String sellerTaxPost = 'seller/tax';
  static const String selleridentificationPost = 'seller/identification';
  static const String sellershippingunitsPost = 'seller/shipping-unit';

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
  static const String authToken =
      '26|Y4HoSC3Rlbegkjw47OKBdf1m1EXMeLyiLx5V8WsY20be74d7';
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
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 201) {
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
  Future<List<Cart>> getCart({
    required String token,
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.buyerGetCart,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.data != null && response.data['carts'] != null) {
        final data = (response.data['carts'] as List)
            .map((json) => Cart.fromJson(json))
            .toList();
        return data;
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load cart with error: $e');
    }
  }

  Future<Map<String, dynamic>> getAllPaymentMethods({
    required String token,
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.paymentMethods,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
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
          'Authorization': 'Bearer $token',
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
          'Authorization': 'Bearer $token',
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
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 201) {
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

  Future<ProductModel> fetchProductDetailBuyer({
    required String token,
    required String uuid,
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.buyerGetProductDetail(uuid),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ProductModel.fromJson(response.data['product']);
      } else {
        throw Exception('Failed to fetch product: ${response.statusMessage}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching product: $error');
      }
      rethrow;
    }
  }

  Future<List<ProductBuyer>> fetchProductBuyer({
    required String token,
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.BuyerproductsGet,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final products = (response.data['products'] as List)
            .map((productJson) => ProductBuyer.fromJson(productJson))
            .toList();
        return products;
      } else {
        throw Exception('Failed to fetch product: ${response.statusMessage}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching product: $error');
      }
      rethrow;
    }
  }

  Future<List<Industry>> fetchIndustryBuyer({
    required String token,
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.BuyeIndustrysGet,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final industryList = (response.data['industries'] as List)
            .map((industryJson) => Industry.fromJson(industryJson))
            .toList();
        return industryList;
      } else {
        throw Exception('Failed to fetch industry: ${response.statusMessage}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching industry: $error');
      }
      rethrow;
    }
  }

  ///******************************************************************
  ///---------------------------POST-----------------------------------
  ///******************************************************************
  Future addCart({
    required String uuid,
    required String token,
    required String colorId,
    required String sizeId,
    required String quantity,
  }) async {
    try {
      final response = await dioClient.post(
        ApiPath.addCart(uuid),
        body: {
          "quantity": quantity,
          "size_id": sizeId,
          "color_id": colorId,
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
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
          'Authorization': 'Bearer $token',
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
          'Authorization': 'Bearer $token',
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
    required String token,
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

      final response = await dioClient.post(
        ApiPath.sellerRegistorPost,
        body: formData,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      // Log dữ liệu phản hồi
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      // Kiểm tra mã trạng thái
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        final errorMessage =
            response.data['message'] ?? 'Đăng ký cửa hàng thất bại';
        throw errorMessage;
      }
    } on DioException catch (e) {
      // Log lỗi chi tiết
      print('DioException Type: ${e.type}');
      print('DioException Message: ${e.message}');
      print('DioException Response: ${e.response?.data}');

      // Xử lý lỗi theo mã lỗi
      if (e.response?.statusCode == 403) {
        final message = e.response?.data['message'] ?? 'Lỗi từ server: 403';
        throw message;
      } else {
        throw 'Lỗi từ server: ${e.response?.statusCode ?? "Không rõ"}';
      }
    } catch (error) {
      print('General Error: $error');
      throw 'Đã xảy ra lỗi không xác định khi đăng ký cửa hàng';
    }
  }

  Future<StoreInfo> getStoreInfo({
    required String token,
    String authType = 'Bearer',
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.sellerRegistorGet,
        headers: {
          'Authorization': '$authType $token',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('GET Response Status Code: ${response.statusCode}');
        print('GET Response Data: ${response.data}');
      }

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Kiểm tra nếu response chứa thông báo message
        if (response.data is Map<String, dynamic>) {
          final data = response.data;

          // Lấy nội dung mà không bao gồm message
          if (data.containsKey('message')) {
            if (kDebugMode) {
              print('Message found: ${data['message']}');
            }
            data.remove('message'); // Bỏ trường message nếu không cần
          }

          // Lấy thông tin cửa hàng từ response
          final storeData = data['store'] ?? data;
          return StoreInfo.fromJson(storeData);
        } else {
          throw const FormatException('Invalid response format');
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
            throw '${e.response?.data['message'] ?? 'Không tìm thấy dữ liệu'}';
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

  Future<Response> getAddress({
    required String token,
  }) async {
    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.sellerRAddressGet}');
    }

    try {
      final response = await dioClient.get(
        ApiPath.sellerRAddressGet,
        headers: {
          'Content-Type': 'application/json', // Đảm bảo gửi dữ liệu JSON

          'Authorization': 'Bearer $token',
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
            throw '${e.response}.';
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
    required String token,
    required String label,
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
      'label': label,
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

          'Authorization': 'Bearer $token',
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
            throw '${e.response}.';
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

  Future<Response> getTax({
    required String token,
  }) async {
    if (kDebugMode) {
      print('Request URL: ${NetworkConstants.baseUrl}${ApiPath.sellerTaxGet}');
    }

    try {
      final response = await dioClient.get(
        ApiPath.sellerTaxGet,
        headers: {
          'Content-Type': 'application/json', // Đảm bảo gửi dữ liệu JSON

          'Authorization': 'Bearer $token',
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
            throw '${e.response}.';
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

  Future<bool> postTax(SellerRegisterTaxModel tax,
      {required String token}) async {
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
          'Authorization': 'Bearer $token',
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
            throw '${e.response}.';
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

  Future<Response> getidentification({
    required String token,
  }) async {
    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.selleridentificationPost}');
    }

    try {
      final response = await dioClient.get(
        ApiPath.selleridentificationPost,
        headers: {
          'Content-Type': 'application/json', // Đảm bảo gửi dữ liệu JSON

          'Authorization': 'Bearer $token',
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
            throw '${e.response}.';
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
    SellerIdentificationModel identification, {
    required String token,
  }) async {
    try {
      // Prepare FormData with identification information
      final formData = FormData.fromMap({
        // Set default values if fields are null or empty
        'type': identification.type.isNotEmpty == true
            ? identification.type
            : 'id_card',
        'number':
            identification.number.isNotEmpty ? identification.number : '123456',
        'name': identification.name.isNotEmpty == true
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
          'Authorization': 'Bearer $token',
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
            throw '${e.response}.';
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
    required String token,
    required String bank,
    required String branch,
    required String number,
    required String cardHolder,
    required bool isDefault,
  }) async {
    final requestBody = {
      'bank': bank,
      'branch': branch,
      'number': number,
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
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('POST Response Status Code: ${response.statusCode}');
        print('POST Response Data: ${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
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
            throw '${e.response}.';
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

  Future<BankAccountResponse> sellerpaymentmethodssGet({
    required String token,
  }) async {
    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.selleridentificationPost}');
    }

    try {
      final response = await dioClient.get(
        ApiPath.sellerpaymentmethodssGet,
        headers: {
          'Content-Type': 'application/json', // Ensure JSON data format
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('Get Response Status Code: ${response.statusCode}');
        print('Get Response Data: ${response.data}');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return BankAccountResponse.fromJson(response.data);
        // return reponse;
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
            throw '${e.response}.';
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

  Future<List<SellerRegisterProductModel>?> getProduct({
    required String token,
  }) async {
    try {
      final response = await dioClient.get(
        ApiPath.sellerRegisterProductGet,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('Get Product Response Status Code: ${response.statusCode}');
        print('Get Product Response Data: ${response.data}');
      }

      if (response.statusCode == 201 || response.statusCode == 200) {
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
    } on DioException {
      throw 'Lỗi kết nối hoặc lỗi từ server';
    } catch (error) {
      throw 'Đã xảy ra lỗi không xác định khi lấy thông tin sản phẩm';
    }
  }

  Future<bool> activateProduct(
      {required String uuid, required String token}) async {
    try {
      final response = await dioClient.get(
        'http://52.77.246.91/api/v1/seller/product/$uuid/status',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      print('Error activating product: ${e.message}');
      return false;
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
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 201) {
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
          'Authorization': 'Bearer $token',
        },
      );
      print(response);
      if (response.statusCode == 201) {
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

  Future postProductDetail({
    required String token,
    required String product_id,
    required String brand,
    required String gender,
    required String origin,
    required String material,
    required String occasion,
    required String manufacturer,
    required String manufacturer_address,
  }) async {
    try {
      // final url = '${ApiPath.sellersproductdetailsPost}/$product_id';
      final url =
          'http://52.77.246.91/api/v1/seller/product/$product_id/detail';

      final response = await dioClient.post(
        url,
        body: {
          "product_id": product_id,
          "brand": brand,
          "gender": gender,
          "origin": origin,
          "material": material,
          "occasion": occasion,
          "manufacturer": manufacturer,
          "manufacturer_address": manufacturer_address,
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data; // `data` is now a Map or List if it's JSON.

        return response;
      } else {
        throw Exception('Failed to post productdetail');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error post productdetail: $error');
      }
      rethrow;
    }
  }

  Future<bool> postproductsales({
    required String token,
    required String product_id,
    required String original_price,
    required String discount_price,
    required String quantity,
    required String min_order,
    required String max_order,
    required String size_chart,
  }) async {
    try {
      // Prepare FormData with the tax information
      final formData = FormData.fromMap({
        'product_id': product_id,
        'original_price': original_price,
        'discount_price': discount_price,
        'quantity': quantity,
        'min_order': min_order,
        'max_order': max_order,
        'size_chart': size_chart != null
            ? await MultipartFile.fromFile(
                size_chart!,
                filename: 'size_chart.jpg',
              )
            : null,
      });
      // final url = '${ApiPath.sellersproductsalesPost}/$product_id';
      final url = 'http://52.77.246.91/api/v1/seller/product/$product_id/sales';
      ;

      // Send POST request to update tax information
      final response = await dioClient.post(
        url,
        body: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (kDebugMode) {
        print('Post   Response Status Code: ${response.statusCode}');
        print('Post   Response Data: ${response.data}');
      }

      // Check response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('  information posted successfully');
        return true;
      } else if (response.statusCode == 401) {
        throw 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
      } else {
        throw Exception(
            'Failed to post   information. Status: ${response.statusCode}');
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
            throw '${e.response}.';
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
      throw 'Đã xảy ra lỗi không xác định khi gửi  ';
    }
  }

  Future postProductShipping({
    required String token,
    required String product_id,
    required int weight,
    required String dimension,
  }) async {
    try {
      // final url = '${ApiPath.sellersproductshippingPost}/$product_id';
      final url =
          'http://52.77.246.91/api/v1/seller/product/$product_id/shipping';

      final response = await dioClient.post(
        url,
        body: {
          "product_id": product_id,
          "weight": weight,
          "dimension": '20x20x20',
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response);
      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to post  ');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error post  : $error');
      }
      rethrow;
    }
  }

  Future postProductExtra({
    required String token,
    required String product_id,
    required String is_pre_order,
    required String status,
    required String sku,
  }) async {
    try {
      // final url = '${ApiPath.sellersproductextra}/$product_id';
      final url = 'http://52.77.246.91/api/v1/seller/product/$product_id/extra';

      final response = await dioClient.post(
        url,
        body: {
          "product_id": product_id,
          "is_pre_order": is_pre_order,
          "status": status,
          "sku": 'SKU5332485739845348539845',
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response);
      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to post  ');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error post  : $error');
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
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 201) {
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

  Future<bool> postProduct(
    ProductPostModel product, {
    required String token,
  }) async {
    try {
      // Kiểm tra xem tất cả các hình ảnh có tồn tại không
      for (String imagePath in product.images) {
        if (!File(imagePath).existsSync()) {
          throw 'Hình ảnh không tồn tại: $imagePath';
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
          'Authorization': 'Bearer $token',
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
            throw '${e.response}.';
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
      rethrow;
    }
  }

  Future<bool> sendShippingData(
      {String shippingUnit = 'Default Shipping Unit',
      String description = 'Default Description',
      required String token,
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
          'Authorization': 'Bearer $token',
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
            throw '${e.response}.';
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

  Future<Response> getStatus({
    required String token,
  }) async {
    if (kDebugMode) {
      print(
          'Request URL: ${NetworkConstants.baseUrl}${ApiPath.sellerstorestatusGet}');
    }

    try {
      final response = await dioClient.get(
        ApiPath.sellerstorestatusGet,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
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
            throw '${e.response}.';
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
}
