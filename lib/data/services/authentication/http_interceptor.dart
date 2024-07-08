import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../features/authentication/screens/login/login.dart';
import '../../../utils/constants/connection_strings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpInterceptor extends http.BaseClient {
  final http.Client _client = http.Client();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final String? secretKey = dotenv.env['SECRET_KEY'];

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    var accessToken = await secureStorage.read(key: 'access_token');
    var refreshToken = await secureStorage.read(key: 'refresh_token');

    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    var response = await _client.send(request);

    if (response.statusCode == 401) {
      // Access token might be expired, try to refresh
      var newTokens = await refreshTokens(refreshToken);
      if (newTokens != null) {
        accessToken = newTokens['access_token'];
        refreshToken = newTokens['refresh_token'];
        request.headers['Authorization'] = 'Bearer $accessToken';
        response = await _client.send(request);
      } else {
        await logoutUser();
        Get.off(() => const LoginScreen());
        throw Exception('Session expired. Please login again.');
      }
    }

    return response;
  }

  Future<Map<String, dynamic>?> refreshTokens(String? refreshToken) async {
    if (refreshToken == null) return null;

    try {
      var response = await _client.post(
        Uri.parse('${TConnectionStrings.deployment}auth/refresh-token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        await secureStorage.write(key: 'access_token', value: data['access_token']);
        await secureStorage.write(key: 'refresh_token', value: data['refresh_token']);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> logoutUser() async {
    await secureStorage.delete(key: 'access_token');
    await secureStorage.delete(key: 'refresh_token');
    // Add any additional cleanup actions if necessary
  }
}
