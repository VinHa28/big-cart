import 'package:app/models/address.dart';
import 'package:app/services/api_client.dart';
import 'package:dio/dio.dart';

class AddressService {
  final Dio _dio = ApiClient.instance;

  // Lấy danh sách địa chỉ (thực tế thường lấy qua User profile)
  // Nhưng ở đây ta có thể tạo hàm fetch riêng nếu cần

  Future<List<Address>> createAddress(String userId, Address address) async {
    try {
      final response = await _dio.post(
        '/users/add-address',
        data: {"userId": userId, "addressData": address.toJson()},
      );
      return (response.data as List).map((e) => Address.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Address>> updateAddress(
    String userId,
    String addressId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.put(
        '/users/update-address',
        data: {"userId": userId, "addressId": addressId, "updateData": data},
      );
      return (response.data as List).map((e) => Address.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Address>> deleteAddress(String userId, String addressId) async {
    try {
      final response = await _dio.delete(
        '/users/delete-address/$userId/$addressId',
      );
      return (response.data as List).map((e) => Address.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Address>> setDefault(String userId, String addressId) async {
    try {
      final response = await _dio.patch(
        '/users/set-default-address',
        data: {"userId": userId, "addressId": addressId},
      );
      return (response.data as List).map((e) => Address.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Address>> getAllAddresses(String userId) async {
    try {
      final response = await _dio.get('/users/address/$userId');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Address.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print("Error fetching addresses: ${e.message}");
      rethrow;
    }
  }
}
