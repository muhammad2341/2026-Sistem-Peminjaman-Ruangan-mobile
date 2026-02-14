import 'package:flutter/material.dart';
import 'package:room_booking_mobile/features/auth/auth_controller.dart';

class BorrowerHomePage extends StatelessWidget {
  const BorrowerHomePage({super.key, required this.authController});

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrower Dashboard'),
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
            Text('Halo, ${authController.email.isEmpty ? 'Peminjam' : authController.email}'),
            const SizedBox(height: 8),
            const Text('Role: Borrower'),
            const SizedBox(height: 16),
            const Card(
              child: ListTile(
                leading: Icon(Icons.add_box_outlined),
                title: Text('Ajukan Peminjaman'),
                subtitle: Text('Buat permintaan booking ruangan baru.'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.history),
                title: Text('Riwayat Peminjaman'),
                subtitle: Text('Lihat status dan riwayat booking Anda.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
