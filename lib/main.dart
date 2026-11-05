
import 'package:flutter/material.dart';

void main() => runApp(SiJimpitApp());

class SiJimpitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'si jimpit', debugShowCheckedModeBanner: false, theme: ThemeData(primaryColor: Color(0xFF10b981), scaffoldBackgroundColor: Color(0xFFf8fafc)), home: LoginPage());
  }
}

class LoginPage extends StatefulWidget { @override _LoginPageState createState() => _LoginPageState(); }

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController pinCtrl = TextEditingController();
  bool showDropdown = false;
  bool obscurePin = true;
  bool isLoading = false;

  List<Map<String, String>> rumahList = [
    {"kode": "JPT-RT05-01", "no": "01", "nama": "Pak Karno - Jl Mawar No 1"},
    {"kode": "JPT-RT05-02", "no": "02", "nama": "Pak Sutrisno - Jl Mawar No 2"},
    {"kode": "JPT-RT05-03", "no": "03", "nama": "Bu Dewi - Jl Mawar No 3"},
    {"kode": "JPT-RT05-08", "no": "08", "nama": "Bu Siti Aminah - Jl Melati No 8"},
    {"kode": "JPT-RT05-09", "no": "09", "nama": "Bu Rini - Jl Melati No 9"},
    {"kode": "JPT-RT05-15", "no": "15", "nama": "Pak Joko - Jl Melati No 15"},
  ];
  List<Map<String, String>> filtered = [];
  @override
  void initState() { super.initState(); filtered = rumahList; usernameCtrl.addListener(() { String q = usernameCtrl.text.toLowerCase(); setState(() { filtered = rumahList.where((r) => r["kode"]!.toLowerCase().contains(q) || r["nama"]!.toLowerCase().contains(q)).toList(); }); }); }

  void doLogin() {
    if (usernameCtrl.text.isEmpty || pinCtrl.text.length < 4) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lengkapi Username & PIN'), backgroundColor: Colors.red)); return; }
    setState(() => isLoading = true);
    Future.delayed(Duration(milliseconds: 700), () {
      String noExtract = "08"; var nums = RegExp(r'\d+').allMatches(usernameCtrl.text).toList(); if (nums.isNotEmpty) { noExtract = nums.last.group(0)!; if (noExtract.length == 1) noExtract = "0" + noExtract; }
      var found = rumahList.firstWhere((r) => r["kode"]!.toLowerCase() == usernameCtrl.text.toLowerCase() || r["no"] == noExtract, orElse: () => {"kode": "JPT-RT05-$noExtract", "no": noExtract, "nama": "Warga No $noExtract"});
      setState(() => isLoading = false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen(userNo: found["no"]!, kodeRumah: found["kode"]!, namaRumah: found["nama"]!)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf8fafc),
      body: SafeArea(
        child: SingleChildScrollView(padding: EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 50),
          Center(child: Container(width: 80, height: 80, decoration: BoxDecoration(color: Color(0xFF10b981), borderRadius: BorderRadius.circular(20)), child: Center(child: Text('J', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold))))),
          SizedBox(height: 16),
          Center(child: Text('si jimpit', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
          Center(child: Text('Jimpitan Digital RT 05 RW 12', style: TextStyle(fontSize: 13, color: Colors.grey))),
          SizedBox(height: 40),
          Text('Username', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFe2e8f0))),
            child: Column(children: [
              TextField(
                controller: usernameCtrl,
                decoration: InputDecoration(hintText: 'Nama rumah', border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14), prefixIcon: Icon(Icons.home, size: 18, color: Colors.grey), suffixIcon: IconButton(icon: Icon(showDropdown ? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 28, color: Color(0xFF64748b)), onPressed: () => setState(() => showDropdown = !showDropdown))),
                onTap: () => setState(() => showDropdown = true),
              ),
              if (showDropdown)
                Container(
                  constraints: BoxConstraints(maxHeight: 200),
                  decoration: BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFe2e8f0))), color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                  child: ListView.builder(shrinkWrap: true, itemCount: filtered.length, itemBuilder: (c, i) { var r = filtered[i]; return InkWell(onTap: () { setState(() { usernameCtrl.text = "${r["kode"]} - ${r["nama"]}"; showDropdown = false; }); }, child: Container(padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFf1f5f9)))), child: Text('${r["kode"]} - ${r["nama"]}', style: TextStyle(fontSize: 12)))); },
                ),
                ),
            ]),
          ),
          SizedBox(height: 16),
          Text('PIN', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          TextField(controller: pinCtrl, obscureText: obscurePin, keyboardType: TextInputType.number, maxLength: 6, decoration: InputDecoration(hintText: '••••••', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), filled: true, fillColor: Colors.white, isDense: true, prefixIcon: Icon(Icons.lock, size: 18, color: Colors.grey), suffixIcon: IconButton(icon: Icon(obscurePin ? Icons.visibility : Icons.visibility_off, size: 18), onPressed: () => setState(() => obscurePin = !obscurePin)), counterText: '')),
          SizedBox(height: 24),
          SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF10b981), minimumSize: Size(0, 48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), onPressed: isLoading ? null : doLogin, child: isLoading ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : Text('Masuk', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
          SizedBox(height: 20),
          Center(child: Text('v1.0.7 Full App Setelah Login', style: TextStyle(fontSize: 10, color: Colors.grey))),
        ])),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final String userNo; final String kodeRumah; final String namaRumah;
  MainScreen({required this.userNo, required this.kodeRumah, required this.namaRumah});
  @override _MainScreenState createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int _idx = 0;
  @override Widget build(BuildContext context) {
    final pages = [BerandaPage(userNo: widget.userNo, kodeRumah: widget.kodeRumah, namaRumah: widget.namaRumah), WargaPage(userNo: widget.userNo), RiwayatPage(userNo: widget.userNo), SayaPage(userNo: widget.userNo, kodeRumah: widget.kodeRumah, namaRumah: widget.namaRumah)];
    return Scaffold(body: pages[_idx], bottomNavigationBar: BottomNavigationBar(currentIndex: _idx, selectedItemColor: Color(0xFF10b981), type: BottomNavigationBarType.fixed, onTap: (i) => setState(() => _idx = i), items: [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'), BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Warga'), BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'), BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Saya')]));
  }
}

class JadwalService {
  static Map<String, dynamic> jadwalHariIni = {"tanggal": "2026-10-30", "hari": "Kamis", "petugas": [{"no": "01", "nama": "Pak Karno"}, {"no": "09", "nama": "Bu Rini"}], "jam": {"buka": "18:00", "tutup": "21:00", "is_aktif": true}};
  static bool isUserPetugas(String no) => (jadwalHariIni["petugas"] as List).any((p) => p["no"] == no);
}

class BerandaPage extends StatefulWidget {
  final String userNo; final String kodeRumah; final String namaRumah;
  BerandaPage({required this.userNo, required this.kodeRumah, required this.namaRumah});
  @override _BerandaPageState createState() => _BerandaPageState();
}
class _BerandaPageState extends State<BerandaPage> {
  List<Map<String, dynamic>> warga = [
    {"no": "01", "nama": "Pak Karno", "status": "LUNAS", "jam": "18:30", "nominal": 500},
    {"no": "02", "nama": "Pak Sutrisno", "status": "LUNAS", "jam": "19:15", "nominal": 500},
    {"no": "08", "nama": "Bu Siti Aminah", "status": "SALDO", "jam": "19:23", "nominal": 4000, "periode": "29 Okt - 5 Nov 2026", "sisa": "Sisa 6 Hari"},
    {"no": "09", "nama": "Bu Rini", "status": "LUNAS", "jam": "18:45", "nominal": 500},
    {"no": "15", "nama": "Pak Joko", "status": "BELUM", "nominal": 0},
    {"no": "16", "nama": "Bu Lastri", "status": "KOSONG", "nominal": 0, "tagihan": 500},
    {"no": "20", "nama": "Pak Slamet", "status": "BELUM", "nominal": 0},
  ];
  Map<String, dynamic>? notif;
  void showNotif(String no, String msg, Color c){ setState(()=>notif={"no":no,"msg":msg,"color":c}); Future.delayed(Duration(seconds:3),(){ if(mounted) setState(()=>notif=null); }); }
  void showEdit(Map<String, dynamic> w){
    String status = w["status"]=="SALDO" ? "LUNAS" : w["status"];
    TextEditingController nomCtrl = TextEditingController(text: w["nominal"].toString());
    showDialog(context: context, builder: (ctx)=>AlertDialog(
      title: Text('Edit No ${w["no"]} ${w["nama"]} (Petugas Only)', style: TextStyle(fontSize:13, fontWeight: FontWeight.bold)),
      content: Column(mainAxisSize: MainAxisSize.min, children:[
        DropdownButtonFormField<String>(value: status, items: ["LUNAS","BELUM","KOSONG"].map((s)=>DropdownMenuItem(value:s, child:Text(s, style: TextStyle(fontSize:13)))).toList(), onChanged: (v)=>status=v!, decoration: InputDecoration(labelText:'Status', border:OutlineInputBorder(), isDense:true)),
        SizedBox(height:10),
        TextField(controller: nomCtrl, decoration: InputDecoration(labelText:'Nominal 500=1hr 4000=8hr', border:OutlineInputBorder(), isDense:true), keyboardType: TextInputType.number),
      ]),
      actions:[TextButton(onPressed:()=>Navigator.pop(ctx), child:Text('Batal')), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF10b981)), onPressed:(){ setState(()=>w["status"]=status); Navigator.pop(ctx); showNotif(w["no"], 'No ${w["no"]} diubah jadi $status', Color(0xFF10b981)); }, child: Text('Simpan', style:TextStyle(color:Colors.white)))],
    ));
  }
  @override Widget build(BuildContext context){
    bool isPetugas = JadwalService.isUserPetugas(widget.userNo);
    var jadwal = JadwalService.jadwalHariIni;
    String petugasStr = (jadwal["petugas"] as List).map((p)=>"${p["nama"]} No ${p["no"]}").join(" & ");
    int lunas = warga.where((w)=>w["status"]=="LUNAS" || w["status"]=="SALDO").length;
    return SafeArea(child: Column(children:[
      Container(color: Colors.white, padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[
          Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
            Text('Jimpitan RT RT 05 RW 12 • ${isPetugas ? "MODE PETUGAS JAGA" : "MODE WARGA ONLY"}', style:TextStyle(fontSize:10, fontWeight:FontWeight.bold, color: isPetugas ? Color(0xFF10b981) : Colors.grey)),
            Text('Halo, ${widget.namaRumah} No ${widget.userNo} 👋', style:TextStyle(fontWeight:FontWeight.bold, fontSize:15)),
          ]),
          Container(padding: EdgeInsets.symmetric(horizontal:8, vertical:4), decoration: BoxDecoration(color: isPetugas ? Color(0xFFdcfce7) : Color(0xFFf1f5f9), borderRadius: BorderRadius.circular(12)), child: Text(isPetugas ? 'PETUGAS' : 'WARGA', style:TextStyle(fontSize:9, fontWeight:FontWeight.bold, color: isPetugas ? Color(0xFF15803d) : Colors.grey))),
        ]),
        SizedBox(height:4),
        Text('Kode ${widget.kodeRumah} • Kunci petugas dari Admin Web', style:TextStyle(fontSize:10, color: Colors.blue)),
      ])),
      Expanded(child: SingleChildScrollView(padding: EdgeInsets.all(12), child: Column(children:[
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Color(0xFF0f172a), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          Text('JADWAL JAGA HARI INI - DARI WEB ADMIN - ${jadwal["tanggal"]}', style:TextStyle(color: Colors.grey, fontSize:9)),
          SizedBox(height:4),
          Text('Petugas: $petugasStr', style:TextStyle(color: Colors.white, fontSize:12, fontWeight: FontWeight.w500)),
          SizedBox(height:4),
          Text('Anda No ${widget.userNo}: ${isPetugas ? "BERTUGAS - Bisa input, KOSONG & edit" : "LIBUR - Hanya lihat"}', style:TextStyle(color: isPetugas ? Color(0xFF86efac) : Colors.amber[200], fontSize:11)),
        ])),
        SizedBox(height:8),
        if(!isPetugas) Container(padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Color(0xFFf1f5f9), borderRadius: BorderRadius.circular(10)), child: Row(children:[Icon(Icons.lock, size:16), SizedBox(width:6), Expanded(child: Text('Terkunci: Hari ini Anda BUKAN petugas. Kunci dari Admin Web, bukan dari APK.', style:TextStyle(fontSize:11)))])),
        SizedBox(height:12),
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFe2e8f0))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[Text('Rekapan Live $lunas dari 35', style:TextStyle(fontWeight:FontWeight.bold, fontSize:13)), Text('77%', style:TextStyle(fontWeight:FontWeight.bold, color: Color(0xFF10b981)))]),
          SizedBox(height:8),
          LinearProgressIndicator(value: lunas/35, color: Color(0xFF10b981)),
          SizedBox(height:12),
          ...warga.map((w){
            bool isTarget = notif!=null && notif!['no']==w['no'];
            return Column(children:[
              if(isTarget) Container(margin: EdgeInsets.only(bottom:6), padding: EdgeInsets.all(8), decoration: BoxDecoration(color: notif!['color'], borderRadius: BorderRadius.circular(8)), child: Text(notif!['msg'], style:TextStyle(color:Colors.white, fontSize:10))),
              Container(margin: EdgeInsets.only(bottom:8), padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Color(0xFFf8fafc), borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xFFe2e8f0))), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text('No ${w['no']} - ${w['nama']}', style:TextStyle(fontWeight:FontWeight.bold, fontSize:11)), Text('${w['status']} ${w['jam']??""} ${w['periode']??""}', style:TextStyle(fontSize:10, color:Colors.grey))])),
                Row(children:[
                  if(w['status']=='BELUM' && isPetugas) ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF10b981), minimumSize: Size(50,26)), onPressed:(){ setState(()=>w['status']='LUNAS'); showNotif(w['no'], 'No ${w['no']} LUNAS', Color(0xFF10b981)); }, child: Text('LUNAS', style:TextStyle(fontSize:9, color:Colors.white))),
                  if(w['status']=='BELUM' && isPetugas) SizedBox(width:4),
                  if(w['status']=='BELUM' && isPetugas) ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, minimumSize: Size(55,26)), onPressed:(){ setState(()=>w['status']='KOSONG'); showNotif(w['no'], 'KOSONG jadi tagihan', Color(0xFF475569)); }, child: Text('KOSONG', style:TextStyle(fontSize:9, color:Colors.white))),
                  if(w['status']=='BELUM' && !isPetugas) ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFe2e8f0), minimumSize: Size(60,26)), onPressed:(){ showNotif(w['no'], 'Hubungi: $petugasStr', Colors.blue); }, child: Text('Ingatkan', style:TextStyle(fontSize:9))),
                  if((w['status']=='LUNAS' || w['status']=='KOSONG' || w['status']=='SALDO') && isPetugas) IconButton(icon: Icon(Icons.edit, size:16, color: Color(0xFF10b981)), onPressed:()=>showEdit(w), padding: EdgeInsets.zero, constraints: BoxConstraints()),
                ]),
              ])),
            ]);
          }).toList(),
        ])),
      ]))),
    ]));
  }
}
class WargaPage extends StatefulWidget { final String userNo; WargaPage({required this.userNo}); @override _WargaPageState createState() => _WargaPageState(); }
class _WargaPageState extends State<WargaPage> {
  List<Map<String, dynamic>> allWarga = List.generate(35, (i) => {"no": (i+1).toString().padLeft(2,'0'), "nama": "Warga No ${(i+1).toString().padLeft(2,'0')} - Jl Mawar No ${i+1}", "status": i%5==0 ? "BELUM" : i%7==0 ? "KOSONG" : "LUNAS"});
  @override Widget build(BuildContext context){
    bool isPetugas = JadwalService.isUserPetugas(widget.userNo);
    return SafeArea(child: Column(children:[
      Container(color: Colors.white, padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[Text('Data Warga 35 Rumah', style:TextStyle(fontWeight:FontWeight.bold, fontSize:16)), Container(padding: EdgeInsets.symmetric(horizontal:8, vertical:4), decoration: BoxDecoration(color: isPetugas ? Color(0xFFdcfce7) : Color(0xFFf1f5f9), borderRadius: BorderRadius.circular(12)), child: Text(isPetugas ? 'MODE PETUGAS' : 'MODE WARGA', style:TextStyle(fontSize:9, fontWeight:FontWeight.bold, color: isPetugas ? Color(0xFF15803d) : Colors.grey))) ]), SizedBox(height:8), Text('Login No ${widget.userNo} - Edit hanya jika petugas dari Web Admin', style:TextStyle(fontSize:11, color: Colors.blue))])),
      Expanded(child: ListView.builder(padding: EdgeInsets.all(8), itemCount: allWarga.length, itemBuilder: (c,i){ var w=allWarga[i]; return Container(margin: EdgeInsets.only(bottom:6), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[Text('No ${w['no']} ${w['nama']} - ${w['status']}', style:TextStyle(fontSize:11)), Row(children:[Icon(Icons.qr_code, size:18, color: Colors.grey), if(isPetugas) Icon(Icons.edit, size:16, color: Color(0xFF10b981))])])); })),
    ]));
  }
}
class RiwayatPage extends StatelessWidget { final String userNo; RiwayatPage({required this.userNo}); @override Widget build(BuildContext context){ return SafeArea(child: Column(children:[Container(color: Colors.white, padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text('Riwayat Transaksi No ${userNo}', style:TextStyle(fontWeight:FontWeight.bold)), Text('7 hari terakhir', style:TextStyle(color: Colors.grey, fontSize:12))])), Expanded(child: ListView.builder(padding: EdgeInsets.all(12), itemCount: 7, itemBuilder: (c,i){ return Container(margin: EdgeInsets.only(bottom:8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[Text('${30-i} Okt 2026', style:TextStyle(fontWeight:FontWeight.bold, fontSize:13)), Text('Rp ${(13500+i*500)}', style:TextStyle(fontWeight:FontWeight.bold, color: Color(0xFF10b981))) ])); })) ])); } }
class SayaPage extends StatelessWidget {
  final String userNo; final String kodeRumah; final String namaRumah;
  SayaPage({required this.userNo, required this.kodeRumah, required this.namaRumah});
  @override Widget build(BuildContext context){
    bool isPetugas = JadwalService.isUserPetugas(userNo);
    return SafeArea(child: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children:[
      Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Row(children:[CircleAvatar(backgroundColor: Color(0xFF10b981), child: Text(userNo, style: TextStyle(color: Colors.white))), SizedBox(width:12), Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text(namaRumah, style:TextStyle(fontWeight:FontWeight.bold, fontSize:14)), Text('$kodeRumah No $userNo • ${isPetugas ? "Petugas (Kunci Admin Web)" : "Warga"}', style:TextStyle(fontSize:11, color: Colors.grey))])])),
      SizedBox(height:12),
      Container(padding: EdgeInsets.all(14), decoration: BoxDecoration(color: Color(0xFFdbeafe), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text('SALDO PREPAID AKTIF', style:TextStyle(fontWeight:FontWeight.bold, fontSize:11, color: Color(0xFF1e40af))), SizedBox(height:4), Text('Rp 4.000 • Sisa 6 Hari • s/d 5 Nov 2026', style:TextStyle(fontWeight:FontWeight.bold, fontSize:13)), Text('Tercakup otomatis 29 Okt - 5 Nov (4000/500=8 hari)', style:TextStyle(fontSize:10, color: Color(0xFF1e40af)))])),
      SizedBox(height:12),
      Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(children:[
        ListTile(leading: Icon(Icons.qr_code), title: Text('QR Code Saya', style:TextStyle(fontSize:13)), subtitle: Text('$kodeRumah', style:TextStyle(fontSize:11)), onTap: (){}),
        Divider(height:1),
        ListTile(leading: Icon(Icons.settings), title: Text('Pengaturan', style:TextStyle(fontSize:13)), subtitle: Text('Edit profil, PIN, notif', style:TextStyle(fontSize:11)), trailing: Icon(Icons.chevron_right), onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>PengaturanPage(userNo: userNo, kodeRumah: kodeRumah)))),
        Divider(height:1),
        ListTile(leading: Icon(Icons.logout, color: Colors.red), title: Text('Keluar / Ganti User', style:TextStyle(fontSize:13, color: Colors.red)), subtitle: Text('1 APK dipakai 35 rumah bergantian', style:TextStyle(fontSize:10)), onTap: ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginPage()), (r)=>false)),
      ])),
    ])));
  }
}
class PengaturanPage extends StatefulWidget { final String userNo; final String kodeRumah; PengaturanPage({required this.userNo, required this.kodeRumah}); @override _PengaturanPageState createState() => _PengaturanPageState(); }
class _PengaturanPageState extends State<PengaturanPage> {
  bool n1=true,n2=true;
  @override Widget build(BuildContext context){ return Scaffold(appBar: AppBar(title: Text('Pengaturan ${widget.kodeRumah}')), body: ListView(padding: EdgeInsets.all(16), children:[Text('Pengaturan FIXED - ${widget.kodeRumah} No ${widget.userNo} - Minimalis + Full App Beranda Warga Riwayat Saya'), SwitchListTile(title: Text('Notif Harian'), value: n1, onChanged: (v)=>setState(()=>n1=v)), SwitchListTile(title: Text('Notif Tagihan'), value: n2, onChanged: (v)=>setState(()=>n2=v))])); }
}
