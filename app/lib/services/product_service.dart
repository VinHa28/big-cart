import 'package:app/models/product.dart'; // Đảm bảo bạn đã có model Product
import 'package:app/services/api_client.dart';
import 'package:dio/dio.dart';

class ProductService {
  final Dio _dio = ApiClient.instance;

  String _parseError(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] ?? "Thao tác thất bại";
    }
    return "Lỗi kết nối server";
  }

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await _dio.get('/products');

      if (response.statusCode == 200) {
        final List<dynamic> productData = response.data;

        return productData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception(_parseError(response.data));
      }
    } on DioException catch (e) {
      print("Dio error: ${e.message}");
      throw Exception(_parseError(e.response?.data));
    } catch (e) {
      print("Error in ProductService: $e");
      throw Exception("Không thể tải danh sách sản phẩm");
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      print("CALL API GET /products/$id");

      final response = await _dio.get('/products/$id');

      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception(_parseError(response.data));
      }
    } on DioException catch (e) {
      print("Dio error: ${e.message}");
      throw Exception(_parseError(e.response?.data));
    } catch (e) {
      print("Error fetching product detail: $e");
      throw Exception("Không tìm thấy sản phẩm");
    }
  }
}
