import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A service class responsible for handling authentication.
class AuthService {
  final String apiUrl;

  /// Constructs an [AuthService] instance.
  ///
  /// If [apiUrl] is not provided, it attempts to read `API_URL` from environment variables.
  AuthService({String? apiUrl})
      : apiUrl = apiUrl ?? dotenv.env['API_URL'] ?? '' {
    if (this.apiUrl.isEmpty) {
      throw Exception('API_URL is not set.');
    }
  }

  /// Logs in to the server using the provided PID and API key.
  ///
  /// Sends a POST request to the `/authenticate` endpoint with
  /// headers 'X-PID' and 'X-API-KEY'.
  ///
  /// Returns the 'token' from the JSON response if the login is successful.
  ///
  /// Throws an [Exception] if the server responds with an error.
  Future<String?> login(String pid, String apiKey) async {
    final url = Uri.parse('$apiUrl/authenticate');

    final headers = {
      'X-PID': pid,
      'X-API-KEY': apiKey,
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        // Parse the JSON response.
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        // Extract the 'token' from the response.
        final String? token = responseBody['token'];

        if (token != null) {
          return token;
        } else {
          // Handle the case where 'token' is not present in the response.
          throw Exception('Token not found in response.');
        }
      } else {
        // Handle server errors.
        throw Exception(
            'Login failed with status code: ${response.statusCode}\nResponse body: ${response.body}');
      }
    } catch (e) {
      // Handle networking or parsing errors.
      throw Exception('An error occurred during login: $e');
    }
  }
}
