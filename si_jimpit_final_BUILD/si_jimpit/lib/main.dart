
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(SiJimpitApp());
}

class SiJimpitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'si jimpit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF10b981),
        scaffoldBackgroundColor: Color(0xFFf8fafc),
        fontFamily: 'Inter',
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    });
    return Scaffold(
      backgroundColor: Color(0xFF10b981),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Center(child: Text('J', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF10b981)))),
            ),
            SizedBox(height: 16),
            Text('si jimpit', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            Text('RT 05 RW 12 • Jimpitan Digital', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool isPetugasMode = false;
  String currentUser = "Bu Siti Aminah No 08";
  List<Map<String, dynamic>> warga = [
    {"no": "01", "nama": "Pak Karno", "status": "LUNAS", "jam": "18:30", "isPetugasToday": true},
    {"no": "02", "nama": "Pak Sutrisno", "status": "LUNAS", "jam": "19:15", "isPetugasToday": false},
    {"no": "08", "nama": "Bu Siti Aminah (ANDA)", "status": "SALDO", "jam": "19:23", "saldo": "Rp 4.000 / 8 Hari", "sisa": "Sisa 6 Hari", "periode": "29 Okt - 5 Nov 2026"},
    {"no": "09", "nama": "Bu Rini", "status": "LUNAS", "jam": "18:45", "isPetugasToday": true},
    {"no": "15", "nama": "Pak Joko", "status": "BELUM", "jam": ""},
    {"no": "16", "nama": "Bu Lastri", "status": "KOSONG", "jam": "Ditandai Pak Karno", "tagihan": 500},
  ];
  Map<String, dynamic>? inlineNotif;

  void showInlineNotif(String wargaNo, String msg, Color color) {
    setState(() {
      inlineNotif = {"no": wargaNo, "msg": msg, "color": color};
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() => inlineNotif = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf8fafc),
      body: SafeArea(
        child: Column(
          children: [
            // Header sesuai gambar upload
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: Color(0xFF10b981), borderRadius: BorderRadius.circular(12)),
                            child: Center(child: Text('J', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Jimpitan RT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              Text('RT 05 RW 12 • MODE WARGA ONLY', style: TextStyle(fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(backgroundColor: Color(0xFFf1f5f9), child: Icon(Icons.lock, size: 18)),
                          SizedBox(width: 8),
                          Stack(
                            children: [
                              CircleAvatar(backgroundColor: Color(0xFFf1f5f9), child: Icon(Icons.notifications, size: 18)),
                              Positioned(right: 0, top: 0, child: Container(width: 16, height: 16, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: Center(child: Text('3', style: TextStyle(color: Colors.white, fontSize: 10))))),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Halo, Bu Siti Aminah 👋', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Icon(Icons.more_vert),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                        child: Row(children: [Icon(Icons.location_on, color: Colors.white, size: 14), SizedBox(width: 4), Text('No 08', style: TextStyle(color: Colors.white, fontSize: 12))]),
                      ),
                      SizedBox(width: 8),
                      Text('RT 05 / RW 12', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Jadwal Jaga Hari Ini - dark card
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Color(0xFF0f172a), borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white10, shape: BoxShape.circle), child: Icon(Icons.calendar_today, color: Colors.white, size: 16)),
                                  SizedBox(width: 8),
                                  Text('JADWAL JAGA HARI INI', style: TextStyle(color: Colors.grey, fontSize: 11, letterSpacing: 1)),
                                ],
                              ),
                              Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)), child: Text('Kamis 30 Okt 2026', style: TextStyle(color: Colors.white, fontSize: 11))),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text('Petugas: Pak Karno (No 01) & Bu Rini (No 09)', style: TextStyle(color: Colors.white, fontSize: 13)),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text('Status Anda:', style: TextStyle(color: Colors.grey, fontSize: 13)),
                              SizedBox(width: 8),
                              Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)), child: Text('No 08 • LIBUR', style: TextStyle(color: Colors.white, fontSize: 11))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    // Bukan petugas
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Color(0xFFf1f5f9), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          Container(padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.lock, size: 20)),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hari ini Anda BUKAN petugas jaga', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                Text('Mode Warga Only - Hanya bisa lihat status. Fitur input terkunci untuk non-petugas.', style: TextStyle(fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    // Jadwal Anda kecil
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Color(0xFFfef3c7), borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFfde68a))),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, size: 16, color: Colors.amber[800]),
                          SizedBox(width: 8),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Jadwal Jaga Anda', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber[800])), Text('Jumat, 31 Okt 2026 • 18:00-21:00 bersama Pak Widodo No 02', style: TextStyle(fontSize: 10))])),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    // Rekapan Live - FOKUS UTAMA
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Color(0xFFe2e8f0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Rekapan Hari Ini - Live', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('30 Okt 2026', style: TextStyle(fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('27 Lunas dari 35 Rumah', style: TextStyle(fontSize: 12)),
                              Text('77%', style: TextStyle(fontSize: 12, color: Color(0xFF10b981), fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 4),
                          LinearProgressIndicator(value: 0.77, backgroundColor: Color(0xFFf1f5f9), color: Color(0xFF10b981)),
                          SizedBox(height: 12),
                          ...warga.map((w) {
                            bool isTarget = inlineNotif != null && inlineNotif!['no'] == w['no'];
                            return Column(
                              children: [
                                if (isTarget)
                                  Container(
                                    margin: EdgeInsets.only(bottom: 6),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: inlineNotif!['color'], borderRadius: BorderRadius.circular(12)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.info, color: Colors.white, size: 16),
                                        SizedBox(width: 8),
                                        Expanded(child: Text(inlineNotif!['msg'], style: TextStyle(color: Colors.white, fontSize: 11))),
                                      ],
                                    ),
                                  ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: w['no'] == '08' ? Color(0xFFeff6ff) : Color(0xFFf8fafc),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: w['no'] == '08' ? Color(0xFFbfdbfe) : Colors.transparent),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(radius: 16, backgroundColor: w['status'] == 'LUNAS' ? Color(0xFFdcfce7) : w['status'] == 'KOSONG' ? Color(0xFFe2e8f0) : Color(0xFFfef3c7), child: Text(w['no'], style: TextStyle(fontSize: 10))),
                                          SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('${w['no']} ${w['nama']}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                              if (w['status'] == 'LUNAS') Text('LUNAS ${w['jam']}', style: TextStyle(fontSize: 10, color: Color(0xFF10b981))),
                                              if (w['status'] == 'SALDO') Text('${w['saldo']} • ${w['sisa']}', style: TextStyle(fontSize: 10, color: Colors.blue)),
                                              if (w['status'] == 'KOSONG') Text('KOSONG - Jadi Tagihan', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                              if (w['status'] == 'BELUM') Text('BELUM', style: TextStyle(fontSize: 10, color: Colors.amber[700])),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          if (w['status'] == 'BELUM')
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(backgroundColor: isPetugasMode ? Color(0xFF10b981) : Colors.grey, minimumSize: Size(60, 28), padding: EdgeInsets.symmetric(horizontal: 8)),
                                              onPressed: () {
                                                if (!isPetugasMode) {
                                                  showInlineNotif(w['no'], 'Akses Ditolak! Hari ini bukan jadwal jaga Anda', Colors.red);
                                                } else {
                                                  setState(() => w['status'] = 'LUNAS');
                                                  showInlineNotif(w['no'], '${w['no']} ${w['nama']} LUNAS jam ${DateFormat('HH:mm').format(DateTime.now())}', Color(0xFF10b981));
                                                }
                                              },
                                              child: Text(isPetugasMode ? 'LUNAS' : 'Ingatkan', style: TextStyle(fontSize: 10, color: Colors.white)),
                                            ),
                                          if (w['status'] == 'BELUM' && isPetugasMode) SizedBox(width: 4),
                                          if (w['status'] == 'BELUM' && isPetugasMode)
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, minimumSize: Size(60, 28)),
                                              onPressed: () {
                                                setState(() => w['status'] = 'KOSONG');
                                                showInlineNotif(w['no'], '${w['no']} ${w['nama']} ditandai KOSONG - Akan jadi tagihan Rp 500', Color(0xFF475569));
                                              },
                                              child: Text('KOSONG', style: TextStyle(fontSize: 10, color: Colors.white)),
                                            ),
                                          if ((w['status'] == 'LUNAS' || w['status'] == 'KOSONG') && isPetugasMode)
                                            IconButton(icon: Icon(Icons.edit, size: 16, color: Colors.grey), onPressed: () => showInlineNotif(w['no'], 'Edit transaksi ${w['no']} - Modal edit terbuka', Colors.blue)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFF10b981),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _currentIndex = i),
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
