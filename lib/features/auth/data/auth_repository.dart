import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:room_booking_mobile/core/config/app_config.dart';
import 'package:room_booking_mobile/features/auth/domain/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login({required String email, required String password});
  Future<AuthUser?> restoreSession();
  Future<void> logout();
}

class ApiAuthRepository implements AuthRepository {
  ApiAuthRepository({
    FlutterSecureStorage? storage,
    http.Client? client,
  })  : _storage = storage ?? const FlutterSecureStorage(),
        _client = client ?? http.Client();

  final FlutterSecureStorage _storage;
  final http.Client _client;

  @override
  Future<AuthUser> login({required String email, required String password}) async {
    final Uri uri = Uri.parse('${AppConfig.baseApiUrl}/auth/login');

    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Login gagal. Periksa email/password.');
    }

    final Map<String, dynamic> payload = jsonDecode(response.body) as Map<String, dynamic>;
    final String token = (payload['token'] ?? payload['accessToken'] ?? '').toString();
    final String role = (payload['role'] ?? 'Borrower').toString();
    final String resolvedEmail = (payload['email'] ?? email).toString();

    if (token.isEmpty) {
      throw Exception('Token tidak ditemukan pada response login.');
    }

    final AuthUser user = AuthUser(token: token, role: role, email: resolvedEmail);
    final map = user.toStorageMap();
    await _storage.write(key: 'token', value: map['token']);
    await _storage.write(key: 'role', value: map['role']);
    await _storage.write(key: 'email', value: map['email']);
    return user;
  }

  @override
  Future<AuthUser?> restoreSession() async {
    final token = await _storage.read(key: 'token');
    if (token == null || token.isEmpty) {
      return null;
    }

    final role = await _storage.read(key: 'role') ?? 'Borrower';
    final email = await _storage.read(key: 'email') ?? '';
    return AuthUser(token: token, role: role, email: email);
  }

  @override
  Future<void> logout() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'role');
    await _storage.delete(key: 'email');
  }
}
