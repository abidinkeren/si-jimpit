
# si jimpit - Aplikasi Jimpitan RT

Aplikasi Android untuk pencatatan jimpitan harian dengan fitur:
- Petugas jaga bergilir semua rumah
- Tandai KOSONG jadi tagihan
- Saldo prepaid 500/hari, 4000 untuk 8 hari
- Edit transaksi jika salah input
- Notif inline di atas nama
- Rekapan live semua warga

## Cara Build APK

1. Install Flutter: https://flutter.dev/docs/get-started/install
2. Buka terminal di folder ini:
   cd si_jimpit
   flutter pub get

3. Build APK release dengan nama si jimpit:
   flutter build apk --release --build-name="si jimpit" --build-number=1

4. File APK akan ada di:
   build/app/outputs/flutter-apk/app-release.apk

5. Rename jadi si_jimpit.apk:
   mv build/app/outputs/flutter-apk/app-release.apk si_jimpit.apk

6. Install di HP: adb install si_jimpit.apk atau share via WA

## Koneksi ke Backend
Edit lib/main.dart:
const String API_BASE_URL = "https://api.jimpitan.rt05.id"; // ganti dengan IP Public statis kamu
// atau http://103.XX.XX.XX:3001

## Fitur Backend yang dibutuhkan:
- POST /api/transaksi
- GET /api/rekapan/hari-ini
- GET /api/jadwal/hari-ini
- POST /api/transaksi/kosong
- PUT /api/transaksi/:id (edit)
- GET /api/saldo/:warga_id
