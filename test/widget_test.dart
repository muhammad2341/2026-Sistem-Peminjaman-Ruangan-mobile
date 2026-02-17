import 'package:flutter_test/flutter_test.dart';
import 'package:room_booking_mobile/features/auth/auth_controller.dart';
import 'package:room_booking_mobile/features/auth/data/auth_repository.dart';
import 'package:room_booking_mobile/features/auth/domain/auth_user.dart';
import 'package:room_booking_mobile/main.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<AuthUser> login({required String email, required String password}) async {
    return AuthUser(token: 'fake-token', role: 'Admin', email: email);
  }

  @override
  Future<void> logout() async {}

  @override
  Future<AuthUser?> restoreSession() async {
    return null;
  }
}

void main() {
  testWidgets('shows login page when unauthenticated', (WidgetTester tester) async {
    final authController = AuthController(repository: _FakeAuthRepository());

    await tester.pumpWidget(RoomBookingApp(authController: authController));
    await tester.pump();

    expect(find.text('Login Room Booking'), findsOneWidget);
    expect(find.text('Demo akun:'), findsOneWidget);
  });
}
