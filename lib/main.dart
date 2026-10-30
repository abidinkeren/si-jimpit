
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(SiJimpitApp());

class SiJimpitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'si jimpit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF10b981), scaffoldBackgroundColor: Color(0xFFf8fafc)),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPetugas = false;
  List<Map<String, dynamic>> warga = [
    {"no": "01", "nama": "Pak Karno", "status": "LUNAS", "jam": "18:30"},
    {"no": "02", "nama": "Pak Sutrisno", "status": "LUNAS", "jam": "19:15"},
    {"no": "08", "nama": "Bu Siti Aminah (ANDA)", "status": "SALDO", "saldo": "Rp 4.000 / 8 Hari s/d 5 Nov"},
    {"no": "09", "nama": "Bu Rini", "status": "LUNAS", "jam": "18:45"},
    {"no": "15", "nama": "Pak Joko", "status": "BELUM"},
    {"no": "16", "nama": "Bu Lastri", "status": "KOSONG", "tagihan": "Tagihan Rp 500"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf8fafc),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Jimpitan RT', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
          Text('RT 05 RW 12 • MODE WARGA ONLY', style: TextStyle(color: Colors.grey, fontSize: 11)),
        ]),
        actions: [
          Switch(value: isPetugas, onChanged: (v) => setState(() => isPetugas = v), activeColor: Color(0xFF10b981)),
          Padding(padding: EdgeInsets.only(right: 12), child: Center(child: Text(isPetugas ? 'Petugas' : 'Warga', style: TextStyle(color: Colors.black, fontSize: 11)))),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Color(0xFF0f172a), borderRadius: BorderRadius.circular(20)),
              child: Row(children: [
                Icon(Icons.calendar_today, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Expanded(child: Text('JADWAL JAGA HARI INI: Pak Karno No 01 & Bu Rini No 09 - Status: LIBUR', style: TextStyle(color: Colors.white, fontSize: 12))),
              ]),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Rekapan Hari Ini - Live 27 dari 35 (77%)', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                LinearProgressIndicator(value: 0.77, color: Color(0xFF10b981)),
                SizedBox(height: 12),
                ...warga.map((w) => Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Color(0xFFf8fafc), borderRadius: BorderRadius.circular(12)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${w["no"]} ${w["nama"]}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      Text(w["status"] + (w["jam"] != null ? " ${w["jam"]}" : "") + (w["saldo"] != null ? " ${w["saldo"]}" : "") + (w["tagihan"] != null ? " ${w["tagihan"]}" : ""), style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ]),
                    if (w["status"] == "BELUM")
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: isPetugas ? Color(0xFF10b981) : Colors.grey, minimumSize: Size(60, 28)),
                        onPressed: () => setState(() => w["status"] = isPetugas ? "LUNAS" : "BELUM"),
                        child: Text(isPetugas ? "LUNAS" : "Ingatkan", style: TextStyle(fontSize: 10)),
                      ),
                  ]),
                )).toList(),
              ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF10b981),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Warga'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Saya'),
        ],
      ),
    );
  }
}
