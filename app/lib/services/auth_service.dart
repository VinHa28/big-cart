import 'package:app/services/api_client.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = ApiClient.instance;

  // 🔥 Helper parse error an toàn
  String _parseError(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] ?? "Unknown error";
    } else if (data is String) {
      return data;
    }
    return "Unknown error";
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print("CALL API /login");

      final response = await _dio
          .post(
            '/auth/login',
            data: {"email": email, "password": password},
          )
          .timeout(const Duration(seconds: 10));

      print("TYPE: ${response.data.runtimeType}");
      print("DATA: ${response.data}");

      // ✅ Đảm bảo response là Map
      if (response.data is Map<String, dynamic>) {
        return {
          "success": true,
          "user": response.data['user'] ?? {},
          "message": response.data['message'] ?? "Login success",
        };
      } else {
        return {
          "success": false,
          "message": "Sai định dạng response từ server",
        };
      }
    } on DioException catch (e) {
      print("Dio error: ${e.message}");
      print("ERROR TYPE: ${e.response?.data.runtimeType}");
      print("RAW ERROR DATA: ${e.response?.data}");

      String errorMessage = "Lỗi server";

      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = "Timeout kết nối";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = "Server phản hồi quá lâu";
      } else {
        errorMessage = _parseError(e.response?.data);
      }

      return {"success": false, "message": errorMessage};
    } catch (e) {
      print("Unknown error: $e");
      return {"success": false, "message": "Lỗi không xác định"};
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      print("CALL API /register");

      final response = await _dio
          .post('/auth/register', data: {"email": email, "password": password})
          .timeout(const Duration(seconds: 10));

      print("TYPE: ${response.data.runtimeType}");
      print("DATA: ${response.data}");

      if (response.statusCode == 201 && response.data is Map<String, dynamic>) {
        return {
          "success": true,
          "user": response.data['user'] ?? {},
          "message": response.data['message'] ?? "Register success",
        };
      }

      return {"success": false, "message": "Unknown error"};
    } on DioException catch (e) {
      print("Dio error: ${e.message}");
      print("RAW ERROR DATA: ${e.response?.data}");

      String errorMessage = _parseError(e.response?.data);

      return {"success": false, "message": errorMessage};
    } catch (e) {
      print("Unknown error: $e");
      return {"success": false, "message": "Lỗi không xác định"};
    }
  }
}
