import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class LinkedIn {
  static const String clientId = '86ydjzjvea9mw2';
  static const String clientSecret = 'CvKLqkJ6S7Fp1wY7';
  //static const String redirectUri = 'http://example.com:8000/oauth2callback';
  static const String redirectUri = 'http://localhost:3000/oauth/callback';
  //static const String redirectUri = 'http';
  static const String scope = 'r_emailaddress r_liteprofile w_member_social';

  static const String authorizationEndpoint =
      'https://www.linkedin.com/oauth/v2/authorization';
  static const String tokenEndpoint =
      'https://www.linkedin.com/oauth/v2/accessToken';
  static const String userInfoEndpoint =
      'https://api.linkedin.com/v2/me?projection=(id,firstName,lastName,profilePicture(displayImage~:playableStreams))';

  static Future<Map<String, dynamic>> getToken(String code) async {
    final response = await http.post(
      Uri.parse(tokenEndpoint),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
        'client_id': clientId,
        'client_secret': clientSecret,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve access token');
    }

    return json.decode(response.body) as Future<Map<String, dynamic>>;
  }

  static Future<Map<String, dynamic>> getUserInfo(String accessToken) async {
    final response = await http.get(
      Uri.parse(userInfoEndpoint),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve user info');
    }

    return json.decode(response.body) as Future<Map<String, dynamic>>;
  }

  static Uri getAuthorizationUrl() {
    return Uri.parse(
        '$authorizationEndpoint?response_type=code&client_id=$clientId&redirect_uri=$redirectUri&scope=$scope');
  }
}
