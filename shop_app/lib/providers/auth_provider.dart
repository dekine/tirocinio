import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  // String _token;
  // DateTime _expiryDate;
  // String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    const apiKey = ''; // AIzaSyDSi2LS0QpelK5w5y0fRaMmbnSij_bsKac
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$apiKey');

    try {
      final body = json.encode({
        'email': email, // andrea.pugliatti@outlook.it
        'password': password, // andrea123
        'returnSecureToken': true,
      });

      final response = await http.post(
        url,
        body: body,
      );
      print(response.body);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
