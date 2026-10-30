
import 'package:flutter/material.dart';

void main() => runApp(SiJimpitApp());

class SiJimpitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'si jimpit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF10b981), scaffoldBackgroundColor: Color(0xFFf8fafc), fontFamily: 'Inter'),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool isPetugasMode = false;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      BerandaPage(isPetugasMode: isPetugasMode, onTogglePetugas: (v) => setState(() => isPetugasMode = v)),
      WargaPage(isPetugasMode: isPetugasMode),
      RiwayatPage(),
      SayaPage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFF10b981),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
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

// BERANDA - FOKUS UTAMA
class BerandaPage extends StatefulWidget {
  final bool isPetugasMode;
  final Function(bool) onTogglePetugas;
  BerandaPage({required this.isPetugasMode, required this.onTogglePetugas});
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  List<Map<String, dynamic>> warga = [
    {"no": "01", "nama": "Pak Karno", "status": "LUNAS", "jam": "18:30", "isPetugas": true},
    {"no": "02", "nama": "Pak Sutrisno", "status": "LUNAS", "jam": "19:15", "isPetugas": false},
    {"no": "03", "nama": "Bu Ani", "status": "LUNAS", "jam": "19:00", "isPetugas": false},
    {"no": "08", "nama": "Bu Siti Aminah (ANDA)", "status": "SALDO", "jam": "19:23", "saldo": "Rp 4.000 / 8 Hari", "sisa": "Sisa 6 Hari s/d 5 Nov 2026"},
    {"no": "09", "nama": "Bu Rini", "status": "LUNAS", "jam": "18:45", "isPetugas": true},
    {"no": "15", "nama": "Pak Joko", "status": "BELUM", "jam": ""},
    {"no": "16", "nama": "Bu Lastri", "status": "KOSONG", "jam": "", "tagihan": 500},
    {"no": "20", "nama": "Pak Budi", "status": "BELUM", "jam": ""},
  ];
  Map<String, dynamic>? inlineNotif;

  void showNotif(String no, String msg, Color color) {
    setState(() => inlineNotif = {"no": no, "msg": msg, "color": color});
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) setState(() => inlineNotif = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    int lunas = warga.where((w) => w["status"] == "LUNAS" || w["status"] == "SALDO").length;
    int total = 35;
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(children: [
                    Container(width: 44, height: 44, decoration: BoxDecoration(color: Color(0xFF10b981), borderRadius: BorderRadius.circular(12)), child: Center(child: Text('J', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)))),
                    SizedBox(width: 10),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Jimpitan RT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), Text('RT 05 RW 12 • ${widget.isPetugasMode ? "MODE PETUGAS" : "MODE WARGA ONLY"}', style: TextStyle(fontSize: 11, color: Colors.grey))]),
                  ]),
                  Row(children: [
                    IconButton(icon: Icon(widget.isPetugasMode ? Icons.lock_open : Icons.lock, size: 18), onPressed: () => widget.onTogglePetugas(!widget.isPetugasMode)),
                    Stack(children: [Icon(Icons.notifications, size: 20), Positioned(right: 0, child: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle)))]),
                  ]),
                ]),
                SizedBox(height: 12),
                Text('Halo, Bu Siti Aminah 👋', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Row(children: [Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)), child: Text('No 08', style: TextStyle(color: Colors.white, fontSize: 11))), SizedBox(width: 8), Text('RT 05 / RW 12', style: TextStyle(color: Colors.grey, fontSize: 12))]),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(children: [
                Container(padding: EdgeInsets.all(14), decoration: BoxDecoration(color: Color(0xFF0f172a), borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [Icon(Icons.calendar_today, color: Colors.white, size: 14), SizedBox(width: 6), Text('JADWAL JAGA HARI INI', style: TextStyle(color: Colors.grey, fontSize: 10))]), Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)), child: Text('Kamis 30 Okt 2026', style: TextStyle(color: Colors.white, fontSize: 10)))]),
                  SizedBox(height: 8),
                  Text('Petugas: Pak Karno (No 01) & Bu Rini (No 09)', style: TextStyle(color: Colors.white, fontSize: 12)),
                  Text('Status Anda: ${widget.isPetugasMode ? "PETUGAS" : "No 08 • LIBUR"}', style: TextStyle(color: Colors.grey, fontSize: 11)),
                ])),
                SizedBox(height: 10),
                if (!widget.isPetugasMode)
                  Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Color(0xFFf1f5f9), borderRadius: BorderRadius.circular(12)), child: Row(children: [Icon(Icons.lock, size: 18, color: Colors.grey), SizedBox(width: 8), Expanded(child: Text('Hari ini Anda BUKAN petugas jaga - Mode Warga Only', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)))])),
                SizedBox(height: 10),
                Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Color(0xFFe2e8f0))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Rekapan Hari Ini - Live', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text('${lunas} Lunas dari $total', style: TextStyle(fontSize: 11, color: Color(0xFF10b981)))]),
                  SizedBox(height: 6),
                  LinearProgressIndicator(value: lunas / total, color: Color(0xFF10b981), backgroundColor: Color(0xFFf1f5f9)),
                  SizedBox(height: 12),
                  ...warga.map((w) {
                    bool isTarget = inlineNotif != null && inlineNotif!['no'] == w['no'];
                    return Column(children: [
                      if (isTarget) Container(margin: EdgeInsets.only(bottom: 6), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: inlineNotif!['color'], borderRadius: BorderRadius.circular(10)), child: Row(children: [Icon(Icons.check_circle, color: Colors.white, size: 14), SizedBox(width: 6), Expanded(child: Text(inlineNotif!['msg'], style: TextStyle(color: Colors.white, fontSize: 10)))])),
                      Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(10), decoration: BoxDecoration(color: w['no'] == '08' ? Color(0xFFeff6ff) : Color(0xFFf8fafc), borderRadius: BorderRadius.circular(10), border: Border.all(color: w['no'] == '08' ? Color(0xFFbfdbfe) : Colors.transparent)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Row(children: [CircleAvatar(radius: 14, backgroundColor: w['status'] == 'LUNAS' ? Color(0xFFdcfce7) : w['status'] == 'SALDO' ? Color(0xFFdbeafe) : w['status'] == 'KOSONG' ? Color(0xFFe2e8f0) : Color(0xFFfef3c7), child: Text(w['no'], style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold))), SizedBox(width: 8), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('${w['no']} ${w['nama']}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text(w['status'] == 'LUNAS' ? 'LUNAS ${w['jam']}' : w['status'] == 'SALDO' ? '${w['saldo']}' : w['status'] == 'KOSONG' ? 'KOSONG - Jadi Tagihan Rp 500' : 'BELUM BAYAR', style: TextStyle(fontSize: 9, color: w['status'] == 'LUNAS' ? Color(0xFF10b981) : w['status'] == 'SALDO' ? Colors.blue : Colors.grey))])]),
                        Row(children: [
                          if (w['status'] == 'BELUM')
                            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: widget.isPetugasMode ? Color(0xFF10b981) : Colors.grey, minimumSize: Size(50, 26), padding: EdgeInsets.symmetric(horizontal: 6)), onPressed: () { if (!widget.isPetugasMode) { showNotif(w['no'], 'Akses Ditolak! Bukan jadwal jaga Anda', Colors.red); } else { setState(() => w['status'] = 'LUNAS'); showNotif(w['no'], '${w['no']} ${w['nama']} LUNAS jam ${TimeOfDay.now().format(context)}', Color(0xFF10b981)); } }, child: Text(widget.isPetugasMode ? 'LUNAS' : 'Ingatkan', style: TextStyle(fontSize: 9, color: Colors.white))),
                          if (w['status'] == 'BELUM' && widget.isPetugasMode) SizedBox(width: 4),
                          if (w['status'] == 'BELUM' && widget.isPetugasMode)
                            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, minimumSize: Size(55, 26), padding: EdgeInsets.symmetric(horizontal: 6)), onPressed: () { setState(() => w['status'] = 'KOSONG'); showNotif(w['no'], '${w['no']} ${w['nama']} KOSONG - Jadi tagihan', Color(0xFF475569)); }, child: Text('KOSONG', style: TextStyle(fontSize: 9, color: Colors.white))),
                          if ((w['status'] == 'LUNAS' || w['status'] == 'KOSONG') && widget.isPetugasMode)
                            IconButton(icon: Icon(Icons.edit, size: 16, color: Colors.grey), onPressed: () => showNotif(w['no'], 'Edit transaksi ${w['no']} - Modal edit terbuka', Colors.blue), padding: EdgeInsets.zero, constraints: BoxConstraints()),
                        ]),
                      ])),
                    ]);
                  }).toList(),
                ])),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class WargaPage extends StatefulWidget {
  final bool isPetugasMode;
  WargaPage({required this.isPetugasMode});
  @override
  _WargaPageState createState() => _WargaPageState();
}

class _WargaPageState extends State<WargaPage> {
  String search = "";
  List<Map<String, dynamic>> allWarga = List.generate(35, (i) {
    int no = i + 1;
    String noStr = no.toString().padLeft(2, '0');
    return {"no": noStr, "nama": "Warga No $noStr", "wa": "0812${no}00${no}00", "status": no % 5 == 0 ? "BELUM" : no % 7 == 0 ? "KOSONG" : "LUNAS", "saldo": no == 8 ? "Saldo 6 Hari" : ""};
  });

  @override
  Widget build(BuildContext context) {
    List filtered = allWarga.where((w) => w['no'].contains(search) || w['nama'].toLowerCase().contains(search.toLowerCase())).toList();
    return SafeArea(
      child: Column(
        children: [
          Container(color: Colors.white, padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Data Warga RT 05', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('35 Rumah • Tap untuk lihat QR', style: TextStyle(color: Colors.grey, fontSize: 12)),
            SizedBox(height: 10),
            TextField(onChanged: (v) => setState(() => search = v), decoration: InputDecoration(hintText: 'Cari No Rumah / Nama...', prefixIcon: Icon(Icons.search, size: 18), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), isDense: true)),
          ])),
          Expanded(child: ListView.builder(padding: EdgeInsets.all(12), itemCount: filtered.length, itemBuilder: (c, i) {
            var w = filtered[i];
            return Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFe2e8f0))), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [CircleAvatar(radius: 18, backgroundColor: Color(0xFFf1f5f9), child: Text(w['no'], style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))), SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('No ${w['no']} - ${w['nama']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text('WA: ${w['wa']} • ${w['status']} ${w['saldo']}', style: TextStyle(fontSize: 10, color: Colors.grey))])]),
              Row(children: [Icon(Icons.qr_code, size: 20, color: Colors.grey), if (widget.isPetugasMode) IconButton(icon: Icon(Icons.edit, size: 18, color: Color(0xFF10b981)), onPressed: () { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Edit Warga No ${w['no']} - Modal edit terbuka'))); })]),
            ]));
          })),
        ],
      ),
    );
  }
}

class RiwayatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> history = [
      {"tgl": "30 Okt 2026", "total": "Rp 13.500", "lunas": 27, "kosong": 3},
      {"tgl": "29 Okt 2026", "total": "Rp 15.000", "lunas": 30, "kosong": 2},
      {"tgl": "28 Okt 2026", "total": "Rp 14.000", "lunas": 28, "kosong": 1},
      {"tgl": "27 Okt 2026", "total": "Rp 12.500", "lunas": 25, "kosong": 4},
    ];
    return SafeArea(
      child: Column(
        children: [
          Container(color: Colors.white, padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Riwayat Transaksi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text('Rekap harian 7 hari terakhir', style: TextStyle(color: Colors.grey, fontSize: 12))])),
          Expanded(child: ListView.builder(padding: EdgeInsets.all(12), itemCount: history.length, itemBuilder: (c, i) {
            var h = history[i];
            return Container(margin: EdgeInsets.only(bottom: 10), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFe2e8f0))), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(h['tgl'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), SizedBox(height: 4), Text('${h['lunas']} Lunas • ${h['kosong']} Kosong', style: TextStyle(fontSize: 11, color: Colors.grey))]),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(h['total'], style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF10b981))), Text('Lihat Detail', style: TextStyle(fontSize: 10, color: Colors.blue))]),
            ]));
          })),
        ],
      ),
    );
  }
}

class SayaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Row(children: [CircleAvatar(radius: 30, backgroundColor: Color(0xFF10b981), child: Text('SA', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))), SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Bu Siti Aminah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('No 08 • RT 05 RW 12', style: TextStyle(color: Colors.grey, fontSize: 12)), Text('WA: 0812xxxx', style: TextStyle(color: Colors.grey, fontSize: 11))])])),
            SizedBox(height: 12),
            Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Color(0xFFdbeafe), borderRadius: BorderRadius.circular(16), border: Border.all(color: Color(0xFFbfdbfe))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [Icon(Icons.account_balance_wallet, size: 18, color: Colors.blue), SizedBox(width: 6), Text('SALDO PREPAID AKTIF', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue[800]))]),
              SizedBox(height: 8),
              Text('Rp 4.000 untuk 8 Hari', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('Periode: 29 Okt - 5 Nov 2026 • Sisa 6 Hari lagi', style: TextStyle(fontSize: 11, color: Colors.blue[700])),
              SizedBox(height: 8),
              LinearProgressIndicator(value: 0.75, color: Colors.blue, backgroundColor: Colors.white),
              SizedBox(height: 8),
              Text('Notifikasi: Jimpitan hari ini sudah tercakup saldo. Sisa 6 hari lagi.', style: TextStyle(fontSize: 10, color: Colors.blue[600])),
            ])),
            SizedBox(height: 12),
            Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Color(0xFFfee2e2), borderRadius: BorderRadius.circular(16), border: Border.all(color: Color(0xFFfecaca))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [Icon(Icons.warning, size: 18, color: Colors.red), SizedBox(width: 6), Text('TAGIHAN KOSONG', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.red[800]))]),
              SizedBox(height: 8),
              Text('Total Tagihan: Rp 1.000', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red[700])),
              Text('2x KOSONG: 25 Okt, 26 Okt 2026', style: TextStyle(fontSize: 11, color: Colors.red[600])),
              SizedBox(height: 10),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: Size(double.infinity, 36)), onPressed: () {}, child: Text('Bayar Tagihan Sekarang', style: TextStyle(fontSize: 12, color: Colors.white))),
            ])),
            SizedBox(height: 12),
            Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Column(children: [
              ListTile(leading: Icon(Icons.qr_code), title: Text('QR Code Saya', style: TextStyle(fontSize: 13)), subtitle: Text('JPT-RT05-008', style: TextStyle(fontSize: 11)), trailing: Icon(Icons.chevron_right, size: 16), dense: true, contentPadding: EdgeInsets.zero),
              Divider(),
              ListTile(leading: Icon(Icons.settings), title: Text('Pengaturan', style: TextStyle(fontSize: 13)), trailing: Icon(Icons.chevron_right, size: 16), dense: true, contentPadding: EdgeInsets.zero),
              ListTile(leading: Icon(Icons.logout, color: Colors.red), title: Text('Keluar', style: TextStyle(fontSize: 13, color: Colors.red)), dense: true, contentPadding: EdgeInsets.zero),
            ])),
          ],
        ),
      ),
    );
  }
}
