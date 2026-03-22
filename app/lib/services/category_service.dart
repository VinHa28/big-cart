import 'package:app/models/category.dart';
import 'package:app/services/api_client.dart';
import 'package:dio/dio.dart';

class CategoryService {
  final Dio _dio = ApiClient.instance;

  // 🔥 Helper parse error tương tự AuthService
  String _parseError(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] ?? "Lấy dữ liệu thất bại";
    }
    return "Lỗi kết nối server";
  }

  /// Lấy danh sách tất cả category từ backend
  Future<List<Category>> getAllCategories() async {
    try {
      final response = await _dio
          .get(
            '/categories/app', // Đường dẫn này sẽ nối tiếp vào baseUrl trong ApiClient
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        // Kiểm tra định dạng data trả về (dựa trên controller backend bạn đã viết)
        // Backend trả về: { success: true, data: [...] }
        final List<dynamic> categoryData = response.data['data'];

        return categoryData.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception(_parseError(response.data));
      }
    } on DioException catch (e) {
      print("Dio error: ${e.message}");
      String message = _parseError(e.response?.data);
      throw Exception(message);
    } catch (e) {
      print("Unknown error in CategoryService: $e");
      throw Exception("Không thể tải danh mục sản phẩm");
    }
  }
}
