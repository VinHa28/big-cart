import 'package:app/services/api_client.dart';
import 'package:dio/dio.dart';

class OrderService {
  final Dio _dio = ApiClient.instance;

  // Tạo đơn hàng mới
  Future<bool> createOrder({
    required String userId,
    required Map<String, dynamic> address,
  }) async {
    try {
      final response = await _dio.post(
        '/order/create',
        data: {"userId": userId, "address": address},
      );
      return response.statusCode == 201;
    } catch (e) {
      print("Error creating order: $e");
      return false;
    }
  }

  // Lấy lịch sử đơn hàng
  Future<List<dynamic>> getUserOrders(String userId) async {
    try {
      final response = await _dio.get('/order/user/$userId');
      if (response.statusCode == 200) {
        return response.data; // Bạn có thể dùng Order.fromJson ở đây
      }
      return [];
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }
}
