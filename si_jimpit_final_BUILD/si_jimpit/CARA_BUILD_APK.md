# CARA DAPAT APK SI JIMPIT 25 MB TANPA INSTALL FLUTTER

## CARA 1: GITHUB - OTOMATIS JADI APK (Paling Mudah)

1. Buka github.com -> New Repository -> Nama: si-jimpit -> Create
2. Upload semua file dari folder si_jimpit ini ke GitHub
3. Buka tab Actions -> Workflow Build si jimpit APK sedang berjalan
4. Tunggu 5 menit sampai hijau
5. Klik workflow -> Scroll bawah -> Download Artifacts si_jimpit-apk
6. Extract -> Dapat si_jimpit.apk 25 MB SIAP INSTALL

## CARA 2: CODEMAGIC.IO

1. Buka codemagic.io -> Sign up Google
2. Add application -> Upload si_jimpit_source.zip
3. Start Build -> Tunggu 5 menit -> Download APK

Kenapa kemarin error 1.52KB? Karena bukan APK valid, cuma placeholder. APK beneran butuh Android SDK untuk compile.

Setting IP Public: Edit lib/main.dart -> const API_BASE_URL = "http://103.XX.XX.XX:3001"
