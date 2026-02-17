import 'package:flutter/material.dart';
import 'package:room_booking_mobile/features/auth/auth_controller.dart';
import 'package:room_booking_mobile/features/auth/presentation/login_page.dart';
import 'package:room_booking_mobile/features/home/admin_home_page.dart';
import 'package:room_booking_mobile/features/home/borrower_home_page.dart';

void main() {
  runApp(const RoomBookingApp());
}

class RoomBookingApp extends StatefulWidget {
  const RoomBookingApp({super.key, this.authController});

  final AuthController? authController;

  @override
  State<RoomBookingApp> createState() => _RoomBookingAppState();
}

class _RoomBookingAppState extends State<RoomBookingApp> {
  late final AuthController _authController;
  late final bool _ownsController;
  late final Future<void> _bootstrapFuture;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.authController == null;
    _authController = widget.authController ?? AuthController();
    _bootstrapFuture = _authController.bootstrap();
  }

  @override
  void dispose() {
    if (_ownsController) {
      _authController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Booking Mobile',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: FutureBuilder<void>(
        future: _bootstrapFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return AnimatedBuilder(
            animation: _authController,
            builder: (context, _) {
              if (!_authController.isAuthenticated) {
                return LoginPage(authController: _authController);
              }

              if (_authController.role == 'Admin') {
                return AdminHomePage(authController: _authController);
              }

              return BorrowerHomePage(authController: _authController);
            },
          );
        },
      ),
    );
  }
}
