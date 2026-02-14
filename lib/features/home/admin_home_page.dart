import 'package:flutter/material.dart';
import 'package:room_booking_mobile/features/auth/auth_controller.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key, required this.authController});

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            onPressed: authController.logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Halo, ${authController.email.isEmpty ? 'Admin' : authController.email}'),
            const SizedBox(height: 8),
            const Text('Role: Admin'),
            const SizedBox(height: 16),
            const Card(
              child: ListTile(
                leading: Icon(Icons.meeting_room),
                title: Text('Kelola Ruangan'),
                subtitle: Text('Tambah, edit, dan nonaktifkan ruangan.'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.approval),
                title: Text('Approval Booking'),
                subtitle: Text('Tinjau dan setujui permintaan peminjaman.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
