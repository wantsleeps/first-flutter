import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpService {
  // 单例模式
  static final HttpService _instance = HttpService._internal();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal();

  // 配置
  static const String _baseUrl = 'https://api.example.com'; // 替换为实际的 API URL
  static const Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static const Duration _timeout = Duration(seconds: 10);

  // GET 请求
  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http
          .get(
            Uri.parse('$_baseUrl$endpoint'),
            headers: {..._defaultHeaders, ...?headers},
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // POST 请求
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl$endpoint'),
            headers: {..._defaultHeaders, ...?headers},
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // PUT 请求
  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .put(
            Uri.parse('$_baseUrl$endpoint'),
            headers: {..._defaultHeaders, ...?headers},
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE 请求
  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .delete(
            Uri.parse('$_baseUrl$endpoint'),
            headers: {..._defaultHeaders, ...?headers},
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // 响应处理
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // 解码 JSON 响应
      if (response.body.isEmpty) return null;
      try {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } catch (e) {
        return response.body; // 如果不是 JSON 则返回原始字符串
      }
    } else {
      // 处理服务器错误
      throw HttpException(
        'Server error: ${response.statusCode} ${response.reasonPhrase}',
        uri: response.request?.url,
      );
    }
  }

  // 错误处理
  Exception _handleError(Object error) {
    if (error is SocketException) {
      return const SocketException('No internet connection');
    } else if (error is http.ClientException) {
      return const HttpException('Network error occurred');
      // ignore: dead_code
    } else if (error is FormatException) {
      return const FormatException('Invalid response format');
    } else if (error is Exception) {
      return error;
    } else {
      return Exception('Unknown error: $error');
    }
  }
}
