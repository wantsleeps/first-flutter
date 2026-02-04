import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpService {
  // Singleton pattern
  static final HttpService _instance = HttpService._internal();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal();

  // Configuration
  static const String _baseUrl = 
      'https://api.example.com'; // Replace with your actual API URL
  static const Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static const Duration _timeout = Duration(seconds: 10);

  // GET Request
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

  // POST Request
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

  // PUT Request
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

  // DELETE Request
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

  // Response Handler
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Decode JSON response
      if (response.body.isEmpty) return null;
      try {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } catch (e) {
        return response.body; // Return raw string if not JSON
      }
    } else {
      // Handle server errors
      throw HttpException(
        'Server error: ${response.statusCode} ${response.reasonPhrase}',
        uri: response.request?.url,
      );
    }
  }

  // Error Handler
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
