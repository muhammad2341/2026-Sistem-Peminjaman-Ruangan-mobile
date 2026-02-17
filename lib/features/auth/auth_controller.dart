import 'package:flutter/foundation.dart';
import 'package:room_booking_mobile/features/auth/data/auth_repository.dart';
import 'package:room_booking_mobile/features/auth/domain/auth_user.dart';

class AuthController extends ChangeNotifier {
  AuthController({AuthRepository? repository}) : _repository = repository ?? ApiAuthRepository();

  final AuthRepository _repository;
  AuthUser? _user;
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;
  String get role => _user?.role ?? 'Borrower';
  String get email => _user?.email ?? '';
  String? get error => _error;

  Future<void> bootstrap() async {
    _user = await _repository.restoreSession();
    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _repository.login(email: email, password: password);
      return true;
    } catch (exception) {
      _error = exception.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    _user = null;
    _error = null;
    notifyListeners();
  }
}
