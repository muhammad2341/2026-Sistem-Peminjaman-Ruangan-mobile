# Room Booking Mobile

Flutter mobile app untuk sistem peminjaman ruangan dengan login berbasis role (`Admin` dan `Borrower`).

## Prasyarat

- Flutter SDK di `C:\src\flutter`
- Windows Developer Mode aktif (untuk symlink plugin)

Aktifkan Developer Mode:

```powershell
start ms-settings:developers
```

## Menjalankan Project

```powershell
cd "d:\PERKULIAHAN\MATA KULIAH SEMESTER 4\Pra PDBL\Project\2026-Sistem-Peminjaman-Ruangan-mobile"
C:\src\flutter\bin\flutter.bat pub get
C:\src\flutter\bin\flutter.bat run
```

## Struktur Utama

- `lib/features/auth`: login, session, dan API auth
- `lib/features/home`: dashboard `Admin` dan `Borrower`
- `lib/core/config/app_config.dart`: base URL API

## Catatan API

- Web: `http://localhost:5271/api`
- Android Emulator: `http://10.0.2.2:5271/api`
