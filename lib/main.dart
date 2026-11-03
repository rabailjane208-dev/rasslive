import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.microphone.request();
  runApp(const RassLiveApp());
}

class RassLiveApp extends StatelessWidget {
  const RassLiveApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black), home: MainNav());
  }
}

class MainNav extends StatefulWidget { @override _MainNavState createState() => _MainNavState(); }
class _MainNavState extends State<MainNav> {
  int _index = 0;
  int coins = 5000; int diamonds = 1250;
  @override
  Widget build(BuildContext context) {
    final pages = [
      RassLivePage(),
      PrivateRoomPage(),
      FamilyRoomPage(),
      VideoPage(),
      MessengerPage(),
      GamesPage(),
      WalletPage(),
      ProfilePage(),
    ];
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.white54,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'RassLive'),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Private'),
          BottomNavigationBarItem(icon: Icon(Icons.family_restroom), label: 'Family'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Video'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messen.'),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

void _noop(int c) {} 
class RassLivePage extends StatelessWidget {
  final Function(int) onGift; final int coins; RassLivePage({this.onGift = _noop, this.coins = 5000});
  final rooms = [
    {'name': 'Rass World 🌍', 'v': '1257', 's': '100'},
    {'name': 'Queen Live 👑', 'v': '892', 's': '85'},
    {'name': 'Rass PK Arena X', 'v': '543', 's': '70'},
    {'name': '9 Stars Multi ⭐', 'v': '321', 's': '60'},
    {'name': 'Voice Live 🔒', 'v': '210', 's': '50'},
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(children: [
      Padding(padding: EdgeInsets.all(10), child: Align(alignment: Alignment.centerLeft, child: Text('RASS LIVE - Score', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)))),
      Expanded(child: ListView.builder(itemCount: rooms.length, itemBuilder: (c, i) {
        final r = rooms[i];
        return Card(color: Colors.white10, child: ListTile(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LiveRoom(roomName: r['name']!))),
          leading: CircleAvatar(backgroundColor: Colors.pink, child: Text('${i+1}')),
          title: Text(r['name']!, style: TextStyle(color: Colors.white)),
          subtitle: Text('Viewers: ${r['v']} | Score: ${r['s']} | TAP TO LIVE', style: TextStyle(color: Colors.white70, fontSize: 11)),
          trailing: Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)), child: Text('Live', style: TextStyle(fontSize: 10))),
        ));
      }))
    ]));
  }
}

class LiveRoom extends StatefulWidget {
  final String roomName;
  const LiveRoom({super.key, required this.roomName});
  @override
  State<LiveRoom> createState() => _LiveRoomState();
}

class _LiveRoomState extends State<LiveRoom> {
  CameraController? ctrl;
  List<CameraDescription> allCams = [];
  bool isFront = true;
  int coins = 5000;

  @override
  void initState() { super.initState(); _startCamera(); }

  Future<void> _startCamera() async {
    allCams = await availableCameras();
    if (allCams.isEmpty) return;
    final frontCams = allCams.where((c) => c.lensDirection == CameraLensDirection.front).toList();
    final backCams = allCams.where((c) => c.lensDirection == CameraLensDirection.back).toList();
    CameraDescription selectedCam;
    if (isFront && frontCams.isNotEmpty) {
      selectedCam = frontCams[0];
    } else if (!isFront && backCams.isNotEmpty) {
      selectedCam = backCams[0];
    } else {
      selectedCam = allCams[0];
    }
    ctrl = CameraController(selectedCam, ResolutionPreset.high);
    await ctrl!.initialize();
    if (mounted) setState(() {});
  }

  Future<void> _switchCamera() async {
    isFront = !isFront;
    await _startCamera();
  }

  @override
  void dispose() { ctrl?.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, title: Text(widget.roomName, style: TextStyle(fontSize: 14)), leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))),
      body: Stack(children: [
        if (ctrl != null && ctrl!.value.isInitialized)
          SizedBox.expand(child: FittedBox(fit: BoxFit.cover, child: SizedBox(width: ctrl!.value.previewSize!.height, height: ctrl!.value.previewSize!.width, child: CameraPreview(ctrl!))))
        else Container(color: Colors.black, child: Center(child: CircularProgressIndicator(color: Colors.pink))),
        Positioned(top: 10, left: 10, right: 10, child: Wrap(spacing: 6, runSpacing: 6, children: List.generate(8, (i) => GestureDetector(
          onTap: () { setState(() => coins += 10); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gift ${i+1} bheja - Coins +10 - Wallet Me Gaya'))); },
          child: Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(6)), child: Text('Gift ${i+1}', style: TextStyle(color: Colors.white, fontSize: 11))),
        )))),
        Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: EdgeInsets.all(8), child: Row(children: [
          Expanded(child: TextField(style: TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'Comment...', hintStyle: TextStyle(color: Colors.white54), border: InputBorder.none))),
          IconButton(icon: Icon(isFront ? Icons.camera_rear : Icons.camera_front, color: Colors.white), onPressed: _switchCamera),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), onPressed: () {}, child: Text('Send'))
        ]))),
      ]),
    );
  }
}

class PrivateRoomPage extends StatelessWidget { @override Widget build(BuildContext context){ return SafeArea(child: Center(child: Text('Private 1v1\nHost + Request Ali Khan Approve/Reject\n5000 Coins Gift Shop Andar Hai + Go LIVE se Front Camera ON', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)))); } }
class FamilyRoomPage extends StatelessWidget { @override Widget build(BuildContext context){ return SafeArea(child: Column(children: [Padding(padding: EdgeInsets.all(10), child: Text('Family Room 6 Log - 2 Video + 4 Voice + Request Approve', style: TextStyle(color: Colors.white))), Expanded(child: GridView.count(crossAxisCount: 2, children: List.generate(6, (i)=> Container(margin: EdgeInsets.all(8), color: Colors.white10, child: Center(child: Text(i==0 ? 'You (Host) Full Camera' : 'Empty + Invite + Join Guest Approve', style: TextStyle(color: Colors.white, fontSize: 12)))))))])); } }
class VideoPage extends StatelessWidget { @override Widget build(BuildContext context){ return SafeArea(child: ListView(children: [ListTile(leading: Icon(Icons.play_circle, color: Colors.white), title: Text('My Videos 12 Shared Likes 287 Comments 1.2K Views 38K', style: TextStyle(color: Colors.white)), subtitle: Text('❤️ 12500 + Edit Caption: Naya caption likho + Follow/Unfollow', style: TextStyle(color: Colors.white54)))])); } }
class MessengerPage extends StatelessWidget { @override Widget build(BuildContext context){ return SafeArea(child: ListView(children: [ListTile(leading: Icon(Icons.mic, color: Colors.white), title: Text('Voice + Gift Button + Wallet + WhatsApp jaisa', style: TextStyle(color: Colors.white70)))])); } }
class GamesPage extends StatelessWidget { @override Widget build(BuildContext context){ return SafeArea(child: GridView.count(crossAxisCount: 3, children: List.generate(9, (i)=> Card(color: Colors.white10, child: Center(child: Text('Game ${i+1}\nEntry 50 Win 90\nGift Marzi\nWinner 90% Wallet', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 10))))))); } }
class WalletPage extends StatelessWidget { @override Widget build(BuildContext context){ return SafeArea(child: Center(child: Container(margin: EdgeInsets.all(16), padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(12)), child: Column(children: [Text('5000 Coins \$39.60', style: TextStyle(fontSize: 22, color: Colors.white)), SizedBox(height: 10), Text('1250 Diamonds | Gift Sidha Wallet Me', style: TextStyle(color: Colors.white)), SizedBox(height: 10), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), onPressed: (){}, child: Text('Recharge - 195 Mulk PKR/SAR/AED/USD - Stripe + JazzCash + Easypaisa'))])))); } }
class ProfilePage extends StatelessWidget { @override Widget build(BuildContext context){ return SafeArea(child: ListView(padding: EdgeInsets.all(16), children: [SwitchListTile(title: Text('Host Mode ON', style: TextStyle(color: Colors.white)), value: true, onChanged: (v){}), ListTile(title: Text('Level 8 1250/2000 XP', style: TextStyle(color: Colors.white))), ListTile(title: Text('My Diamonds 1250 | My Videos 12', style: TextStyle(color: Colors.white))), ListTile(title: Text('287 Likes | 38K Views | 168 Comments | Live History | Beauty HD', style: TextStyle(color: Colors.white54)))])); } }