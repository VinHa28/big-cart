import 'package:app/models/cart.dart';
import 'package:app/services/api_client.dart';
import 'package:dio/dio.dart';

class CartService {
  final Dio _dio = ApiClient.instance;

  /// Lấy giỏ hàng và chuyển đổi sang Object Cart
  Future<Cart?> getCart(String userId) async {
    try {
      final response = await _dio.get('/cart/$userId');

      print('=== GET /cart/$userId DEBUG ===');
      print('Status: ${response.statusCode}');
      print('Data type: ${response.data.runtimeType}');
      print('Full data: $response.data');
      print('=============================');

      if (response.statusCode != 200) {
        print('Lỗi status: ${response.statusCode}');
        return null;
      }

      Map<String, dynamic>? cartJson;

      if (response.data is Map<String, dynamic>) {
        cartJson = response.data as Map<String, dynamic>;
      } else if (response.data is List && (response.data as List).isNotEmpty) {
        // Nếu backend trả mảng → lấy phần tử đầu tiên (trường hợp phổ biến khi wrap)
        final first = (response.data as List)[0];
        if (first is Map<String, dynamic>) {
          cartJson = first;
        }
      }

      if (cartJson != null) {
        // Xử lý trường hợp backend trả { items: [] } khi giỏ trống
        if (cartJson['items'] == null ||
            (cartJson['items'] is List &&
                (cartJson['items'] as List).isEmpty)) {
          return Cart(
            id: cartJson['_id'] ?? '',
            userId: cartJson['user'] ?? userId,
            items: [],
          );
        }
        return Cart.fromJson(cartJson);
      }

      print('Không tìm thấy dữ liệu giỏ hàng hợp lệ');
      return null;
    } catch (e, stack) {
      print("Error fetching cart: $e");
      print("Stack: $stack");
      return null;
    }
  }

  /// Thêm vào giỏ và trả về Object Cart mới nhất
  Future<bool> addToCart({
    required String userId,
    required String productId,
    int quantity = 1,
  }) async {
    try {
      final response = await _dio.post(
        '/cart/add',
        data: {"userId": userId, "productId": productId, "quantity": quantity},
      );

      if (response.statusCode == 200) {
        // Chỉ kiểm tra message hoặc status thành công
        final message = response.data['message'] as String?;
        if (message != null && message.contains('thành công')) {
          // Không cần parse Cart nữa → trả true để client biết thành công
          return true;
        }
      }

      return false;
    } catch (e) {
      print('Error addToCart: $e');
      return false;
    }
  }

  Future<Cart?> removeFromCart(String userId, String productId) async {
    try {
      final response = await _dio.post(
        '/cart/remove',
        data: {"userId": userId, "productId": productId},
      );
      if (response.statusCode == 200) {
        return Cart.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error removing from cart: $e");
      return null;
    }
  }

  /// Xóa hẳn sản phẩm khỏi giỏ (Clear)
  Future<Cart?> clearItemFromCart(String userId, String productId) async {
    try {
      final response = await _dio.post(
        '/cart/clear-item',
        data: {"userId": userId, "productId": productId},
      );
      if (response.statusCode == 200) {
        return Cart.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error clearing item from cart: $e");
      return null;
    }
  }
}
