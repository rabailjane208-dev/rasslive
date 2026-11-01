import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:audioplayers/audioplayers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cams = await availableCameras();
  runApp(RassApp(cams: cams));
}

class RassApp extends StatelessWidget {
  final List<CameraDescription> cams;
  const RassApp({super.key, required this.cams});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RASS LIVE',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: MainTabs(cams: cams),
    );
  }
}

// MAIN TABS
class MainTabs extends StatefulWidget {
  final List<CameraDescription> cams;
  const MainTabs({super.key, required this.cams});
  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  int idx = 0;
  late List<Widget> pages;
  @override
  void initState() {
    super.initState();
    pages = [
      RassScorePage(cams: widget.cams),
      PrivateRoomPage(),
      FamilyRoomPage(),
      VideoPage(),
      MessengerPage(),
      Games30Page(),
      WalletPage(),
      ProfilePage(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[idx],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.white54,
        currentIndex: idx,
        onTap: (v) => setState(() => idx = v),
        selectedFontSize: 10,
        unselectedFontSize: 9,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "Rass"),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Private"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Video"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Mess..."),
          BottomNavigationBarItem(icon: Icon(Icons.extension), label: "Games"),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// 1. RASS SCORE
class RassScorePage extends StatelessWidget {
  final List<CameraDescription> cams;
  RassScorePage({super.key, required this.cams});
  final rooms = [
    {"id": 1, "name": "Rass World 🌍", "type": "solo", "viewers": 1257, "score": 100},
    {"id": 2, "name": "Queen Live 👑", "type": "queen", "viewers": 892, "score": 85},
    {"id": 3, "name": "Rass PK Arena", "type": "pk", "viewers": 543, "score": 70},
    {"id": 4, "name": "9 Stars Multi ⭐", "type": "multi", "viewers": 321, "score": 60},
    {"id": 5, "name": "Voice Live 🎙️", "type": "voice", "viewers": 210, "score": 50},
  ];
  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text("RASS LIVE - Score", style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold))),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (ctx, i) {
          var r = rooms[i];
          return GestureDetector(
            onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => UltimateLiveRoom(cams: cams, room: r))),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                CircleAvatar(radius: 28, backgroundColor: Colors.pink, child: Text("${r["id"]}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                const SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r["name"] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Viewers: ${r["viewers"]} | Score: ${r["score"]}", style: const TextStyle(fontSize: 11, color: Colors.white54))
                ])
              ]),
            ),
          );
        },
      ),
    );
  }
}

// ULTIMATE LIVE ROOM
class UltimateLiveRoom extends StatefulWidget {
  final List<CameraDescription> cams;
  final Map room;
  const UltimateLiveRoom({super.key, required this.cams, required this.room});
  @override
  State<UltimateLiveRoom> createState() => _UltimateLiveRoomState();
}

class _UltimateLiveRoomState extends State<UltimateLiveRoom> with TickerProviderStateMixin {
  CameraController? cam;
  int camIdx = 0;
  bool isHD = true;
  bool isBeauty = true;
  double beauty = 0.7;
  bool showGift = false;
  bool showBeauty = false;
  final AudioPlayer audio = AudioPlayer();
  late AnimationController giftAnim;
  Map? activeGift;
  int diamonds = 50000;
  int coins = 100000;
  int beans = 358000;
  List<String> chats = ["Apple: ggg", "Admin: arhaab ya close bhai ❤️", "AD: sent Rose x134", "Nawab: sent Lion"];
  List<Map> allGifts = [];

  @override
  void initState() {
    super.initState();
    _initCam();
    giftAnim = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _generate1000Gifts();
    Timer.periodic(const Duration(seconds: 3), (t) {
      if (mounted) setState(() => chats.insert(0, "User${Random().nextInt(999)}: ❤️🔥"));
    });
  }

  void _generate1000Gifts() {
    List<Map> base = [
      {"n": "Rose", "i": Icons.local_florist, "c": Colors.pink, "p": 1},
      {"n": "Kiss", "i": Icons.favorite, "c": Colors.red, "p": 5},
      {"n": "Popper", "i": Icons.celebration, "c": Colors.yellow, "p": 30},
      {"n": "Swan", "i": Icons.flutter_dash, "c": Colors.white, "p": 50},
      {"n": "New Star", "i": Icons.star, "c": Colors.cyan, "p": 100},
      {"n": "Spider", "i": Icons.bug_report, "c": Colors.purple, "p": 200},
      {"n": "Candy", "i": Icons.cake, "c": Colors.pink, "p": 300},
      {"n": "Skull", "i": Icons.skull, "c": Colors.white, "p": 500},
      {"n": "Lucky Box", "i": Icons.card_giftcard, "c": Colors.amber, "p": 1000},
      {"n": "Dragon", "i": Icons.whatshot, "c": Colors.cyanAccent, "p": 15000},
      {"n": "Sports Car", "i": Icons.directions_car, "c": Colors.pinkAccent, "p": 9999},
      {"n": "Lion", "i": Icons.pets, "c": Colors.orange, "p": 29999},
      {"n": "Universe", "i": Icons.public, "c": Colors.purple, "p": 40000},
    ];
    for (int i = 0; i < 1000; i++) {
      var b = base[i % base.length];
      allGifts.add({
        "id": i,
        "name": "${b["n"]} ${i > 12 ? i : ''}",
        "icon": b["i"],
        "color": b["c"],
        "price": b["p"] + i,
        "type": i % 3 == 0 ? "car" : i % 3 == 1 ? "lion" : "rose"
      });
    }
  }

  Future<void> _initCam() async {
    if (widget.cams.isEmpty) return;
    cam = CameraController(widget.cams[camIdx], isHD ? ResolutionPreset.high : ResolutionPreset.medium, enableAudio: false);
    await cam!.initialize();
    if (mounted) setState(() {});
  }

  Future<void> _switchCam() async {
    camIdx = (camIdx + 1) % widget.cams.length;
    await cam?.dispose();
    await _initCam();
  }

  void _sendGift(Map g) async {
    setState(() {
      activeGift = g;
      showGift = false;
      chats.insert(0, "You sent ${g["name"]}");
      diamonds -= (g["price"] as int) ~/ 100;
      if (diamonds < 0) diamonds = 0;
      beans += g["price"] as int;
    });
    giftAnim.forward(from: 0);
    try {
      await audio.play(AssetSource('sounds/pop.mp3'));
    } catch (e) {}
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => activeGift = null);
    });
  }

  @override
  void dispose() {
    cam?.dispose();
    giftAnim.dispose();
    audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    String type = widget.room["type"];
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: cam != null && cam!.value.isInitialized
              ? ColorFiltered(
                  colorFilter: isBeauty
                      ? ColorFilter.matrix([1 + beauty * 0.2, 0, 0, 0, 20 * beauty, 0, 1 + beauty * 0.1, 0, 0, 20 * beauty, 0, 0, 1 + beauty * 0.1, 0, 20 * beauty, 0, 0, 0, 1, 0])
                      : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                  child: type == "multi" ? _multiGrid() : type == "pk" ? _pkView() : type == "voice" ? _voiceView() : CameraPreview(cam!),
                )
              : Container(color: Colors.black, child: const Center(child: CircularProgressIndicator())),
        ),
        _topBar(),
        if (activeGift != null) _giftAnimWidget(),
        _chat(),
        _bottomBar(),
        if (showGift) _giftPanel1000(),
        if (showBeauty) _beautyPanel(),
      ]),
    );
  }

  Widget _pkView() => Row(children: [
        Expanded(child: Stack(children: [CameraPreview(cam!), Positioned(top: 50, left: 8, child: _badge("WIN x3"))])),
        Container(width: 2, color: Colors.white24),
        Expanded(child: Container(color: Colors.grey[900], child: const Center(child: Icon(Icons.person, size: 60))))
      ]);
  Widget _multiGrid() => GridView.count(crossAxisCount: 3, children: List.generate(9, (i) => Container(margin: const EdgeInsets.all(1), color: Colors.grey[900], child: i == 0 && cam != null ? CameraPreview(cam!) : Center(child: Text("User ${i + 1}")))));
  Widget _voiceView() => Container(color: const Color(0xFF1A1A2E), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.mic, size: 60, color: Colors.pink), Text(widget.room["name"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))])));
  Widget _badge(String t) => Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(10)), child: Text(t, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)));
  Widget _topBar() => Positioned(top: 0, left: 0, right: 0, child: SafeArea(child: Padding(padding: const EdgeInsets.all(8), child: Row(children: [const CircleAvatar(radius: 14, backgroundColor: Colors.orange, child: Icon(Icons.person, size: 14)), const SizedBox(width: 6), Expanded(child: Text(widget.room["name"], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))), IconButton(icon: const Icon(Icons.cameraswitch, size: 18), onPressed: _switchCam), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(10)), child: Text("$beans beans | 💎$diamonds", style: const TextStyle(fontSize: 9))), GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 20))]))));
  Widget _giftAnimWidget() => Positioned.fill(child: AnimatedBuilder(animation: giftAnim, builder: (c, _) { double v = giftAnim.value; return Stack(alignment: Alignment.center, children: [if (activeGift!["type"] == "car") Transform.translate(offset: Offset(-200 + v * 400, 0), child: Icon(activeGift!["icon"], size: 80, color: activeGift!["color"])), if (activeGift!["type"] == "lion") Transform.scale(scale: v, child: Icon(activeGift!["icon"], size: 100, color: activeGift!["color"])), Center(child: Opacity(opacity: 1 - v, child: Text(activeGift!["name"], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: activeGift!["color"]))))]); }));
  Widget _chat() => Positioned(left: 8, bottom: 70, right: 80, child: SizedBox(height: 100, child: ListView.builder(reverse: true, itemCount: chats.length, itemBuilder: (c, i) => Container(margin: const EdgeInsets.only(bottom: 2), padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(6)), child: Text(chats[i], style: const TextStyle(fontSize: 10))))));
  Widget _bottomBar() => Positioned(bottom: 0, left: 0, right: 0, child: SafeArea(child: Padding(padding: const EdgeInsets.all(8), child: Row(children: [GestureDetector(onTap: () => setState(() => showBeauty = !showBeauty), child: Container(padding: const EdgeInsets.all(5), decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: const Icon(Icons.auto_fix_high, size: 13))), const Spacer(), GestureDetector(onTap: () => setState(() => showGift = true), child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.pink, Colors.orange]), borderRadius: BorderRadius.circular(20)), child: const Text("Gift 🎁", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))))]))));
  Widget _giftPanel1000() => Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 360, decoration: const BoxDecoration(color: Color(0xFF1A1A2E), borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))), child: Column(children: [Padding(padding: const EdgeInsets.all(8), child: Row(children: [Text("Gift Pack - 1000 Gifts | 💎$diamonds", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber)), const Spacer(), IconButton(icon: const Icon(Icons.close, size: 18), onPressed: () => setState(() => showGift = false))])), Expanded(child: GridView.builder(padding: const EdgeInsets.all(6), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.8, crossAxisSpacing: 6, mainAxisSpacing: 6), itemCount: allGifts.length, itemBuilder: (c, i) { final g = allGifts[i]; return GestureDetector(onTap: () => _sendGift(g), child: Container(decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(g["icon"], color: g["color"], size: 22), Text(g["name"], style: const TextStyle(fontSize: 7), maxLines: 1, overflow: TextOverflow.ellipsis), Text("${g["price"]}", style: TextStyle(fontSize: 7, color: g["color"]))]))); }))]))); }
  Widget _beautyPanel() => Positioned(bottom: 60, left: 8, right: 8, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(14)), child: Column(children: [Row(children: [const Text("Beauty HD - Face Saaf + Choty Bal", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)), const Spacer(), Switch(value: isBeauty, onChanged: (v) => setState(() => isBeauty = v), activeColor: Colors.pink)]), Row(children: [const Text("Smooth", style: TextStyle(fontSize: 9)), Expanded(child: Slider(value: beauty, min: 0, max: 1, activeColor: Colors.pink, onChanged: (v) => setState(() => beauty = v))), Text("${(beauty * 100).toInt()}%")])]))); 
}

// OTHER TABS
class PrivateRoomPage extends StatelessWidget { @override Widget build(BuildContext c) { return Scaffold(appBar: AppBar(title: const Text("Private Room 🔒"), backgroundColor: Colors.black), body: const Center(child: Text("Private Room - Password Protected"))); } }
class FamilyRoomPage extends StatelessWidget { @override Widget build(BuildContext c) { return Scaffold(appBar: AppBar(title: const Text("Family Room 👨‍👩‍👧‍👦"), backgroundColor: Colors.black), body: GridView.count(crossAxisCount: 3, children: List.generate(9, (i) => Card(color: const Color(0xFF1E1E1E), child: Center(child: Text("Member ${i + 1}")))))); } }
class VideoPage extends StatelessWidget { @override Widget build(BuildContext c) { return Scaffold(appBar: AppBar(title: const Text("Video"), backgroundColor: Colors.black), body: const Center(child: Text("Video Play / Edit / Upload"))); } }
class MessengerPage extends StatelessWidget { @override Widget build(BuildContext c) { return Scaffold(appBar: AppBar(title: const Text("Messenger"), backgroundColor: Colors.black), body: const Center(child: Text("Messenger - Voice + Gift"))); } }
class Games30Page extends StatelessWidget { final games = ["Ludo", "Carrom", "Teen Patti", "Poker", "8 Ball Pool", "Car Racing", "Quiz", "Chess"]; @override Widget build(BuildContext c) { return Scaffold(appBar: AppBar(title: const Text("Games"), backgroundColor: Colors.black), body: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemCount: games.length, itemBuilder: (ctx, i) => Card(child: Center(child: Text(games[i]))))); } }

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet"), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Card(color: const Color(0xFF1E1E1E), child: Padding(padding: const EdgeInsets.all(16), child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Column(children: [const Icon(Icons.diamond, color: Colors.cyan), const Text("Diamonds: 50000")]), Column(children: [const Icon(Icons.monetization_on, color: Colors.amber), const Text("Coins: 100000")]), Column(children: [const Icon(Icons.savings, color: Colors.pink), const Text("Beans: 358000")])]))),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text("Recharge Wallet"))
        ]),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile - Shams Uddin"), backgroundColor: Colors.black),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const CircleAvatar(radius: 50, backgroundColor: Colors.pink, child: Text("S", style: TextStyle(fontSize: 40))),
          const SizedBox(height: 10),
          const Text("Shams Uddin", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text("03073903022 | rabailjane70@gmail.com", style: TextStyle(color: Colors.white54)),
          const SizedBox(height: 20),
          const Text("Tracking: 152991878854 | Complaint: 3212151", style: TextStyle(fontSize: 12, color: Colors.amber)),
        ]),
      ),
    );
  }
}                                                                                           
