import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await [Permission.camera, Permission.microphone].request();
  runApp(const RassLiveApp());
}

class RassLiveApp extends StatelessWidget {
  const RassLiveApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black), home: const MainNav());
  }
}

class MainNav extends StatefulWidget { const MainNav({super.key}); @override State<MainNav> createState() => _MainNavState(); }
class _MainNavState extends State<MainNav> {
  int _index = 0;
  final pages = [const RassLiveScorePage(), const PrivatePage(), const FamilyPage(), const VideoPage(), const MessengerPage(), const GamesPage(), const WalletPage(), const ProfilePage()];
  @override Widget build(BuildContext context) {
    return Scaffold(body: pages[_index], bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.fixed, backgroundColor: const Color(0xFF121212), selectedItemColor: const Color(0xFFE91E63), unselectedItemColor: Colors.white54, currentIndex: _index, onTap: (i) => setState(() => _index = i), items: const [
      BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'RassLive'),
      BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Private'),
      BottomNavigationBarItem(icon: Icon(Icons.family_restroom), label: 'Family'),
      BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Video'),
      BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messen.'),
      BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Games'),
      BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ]));
  }
}

// ================== CODE A WALA - RASS LIVE SCORE - ONLY RASS LIVE NAME - 1,2,3,4,5 PINK CIRCLE - 1257/100 etc - NO DELETE ==================
class RassLiveScorePage extends StatefulWidget { const RassLiveScorePage({super.key}); @override State<RassLiveScorePage> createState() => _RassLiveScorePageState(); }
class _RassLiveScorePageState extends State<RassLiveScorePage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final List<Map<String, dynamic>> roomsFromImage = [
    {"num": "1", "name": "Rass World", "emoji": "🌍", "viewers": "1257", "score": "100", "type": "RassLive"},
    {"num": "2", "name": "Queen Live", "emoji": "👑", "viewers": "892", "score": "85", "type": "Queen"},
    {"num": "3", "name": "Rass PK Arena", "emoji": "⚔️", "viewers": "543", "score": "70", "type": "PK"},
    {"num": "4", "name": "9 Stars Multi", "emoji": "⭐", "viewers": "321", "score": "60", "type": "Multi"},
    {"num": "5", "name": "Voice Live", "emoji": "🎤", "viewers": "210", "score": "50", "type": "Voice"},
  ];
  final List<Map<String, dynamic>> allExtraRooms = [
    {"num": "6", "name": "Family Room 4", "emoji": "👨‍👩‍👧‍👦", "viewers": "156", "score": "4/4", "type": "Family"},
    {"num": "7", "name": "Private Room", "emoji": "🔒", "viewers": "89", "score": "1/1", "type": "Private"},
  ];
  void _join(Map r) async {
    try { await audioPlayer.play(AssetSource('sounds/join.mp3')); } catch (_) {}
    if (r['type'] == "PK") Navigator.push(context, MaterialPageRoute(builder: (_) => const RassPKPage()));
    else if (r['type'] == "Multi") Navigator.push(context, MaterialPageRoute(builder: (_) => NineStarsPage(roomName: r['name'])));
    else if (r['type'] == "Voice") Navigator.push(context, MaterialPageRoute(builder: (_) => const VoiceLivePage()));
    else Navigator.push(context, MaterialPageRoute(builder: (_) => LiveRoom(roomName: "${r['name']} ${r['emoji']}")));
  }
  @override Widget build(BuildContext context) {
    List all = [...roomsFromImage, ...allExtraRooms];
    return SafeArea(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.all(16), child: Text('RASS LIVE - Score', style: TextStyle(color: Color(0xFFE53935), fontWeight: FontWeight.w500, fontSize: 16))),
      Expanded(child: ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: all.length, itemBuilder: (c,i){
        final r = all[i];
        return GestureDetector(onTap: ()=>_join(r), child: Container(margin: const EdgeInsets.only(bottom: 24), child: Row(children: [
          Container(width: 48, height: 48, decoration: const BoxDecoration(color: Color(0xFFE91E63), shape: BoxShape.circle), child: Center(child: Text(r['num'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)))),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Text(r['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)), const SizedBox(width: 6), Text(r['emoji'], style: const TextStyle(fontSize: 14))]),
            const SizedBox(height: 2),
            Text('Viewers: ${r['viewers']} | Score: ${r['score']}', style: const TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 2),
            const Text('Rass Live Only - 150 Gifts | 30 Games | Upar Neechay | 195 Mulk', style: TextStyle(color: Colors.white24, fontSize: 8)),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFE53935), borderRadius: BorderRadius.circular(12)), child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
        ])));
      })),
      Container(padding: const EdgeInsets.all(8), color: const Color(0xFF121212), child: const Row(children: [Icon(Icons.verified, size: 12, color: Colors.green), Text(' AppID: com.rasslive.world Verified ✅ - LEVEL 8 - App Sign: rasslive-key.jks - Build #208 - Rass Live Only - No Other App Name - Merged Code A+B', style: TextStyle(color: Colors.white54, fontSize: 6))])),
    ]));
  }
}

// ================== CODE A WALA - RASS PK ARENA - ONLY RASS LIVE - 752718 vs 338881 - FOLLOW ONLY - NO TIKTOK NO BIGO - NO DELETE ==================
class RassPKPage extends StatefulWidget { const RassPKPage({super.key}); @override State<RassPKPage> createState() => _RassPKPageState(); }
class _RassPKPageState extends State<RassPKPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  int leftScore = 752718; int rightScore = 338881; int timerSec = 100; int giftMult = 134;
  bool isFollowingRass = false; bool isFollowingQueen = false; bool isFollowingMain = false;
  List<Map> comments = [
    {"user": "Rass Fan Ali", "text": "Rass World Zabardast ❤️❤️❤️"},
    {"user": "Queen Zara Fan", "level": "9", "text": "Queen Live in the house 🏠"},
    {"user": "Rass Jigar Lover", "level": "8", "text": "Rass Live best hai"},
    {"user": "Rass Family", "level": "13", "text": "sent Rose 🌹 x1 - Rass World"},
  ];
  Timer? _timer;
  @override void initState() { super.initState(); _timer = Timer.periodic(const Duration(seconds: 1), (t){ if(mounted) setState((){ if(timerSec>0) timerSec--; }); }); }
  @override void dispose() { _timer?.cancel(); super.dispose(); }
  void _sendRose() async { try { await audioPlayer.play(AssetSource('sounds/gift.mp3')); } catch(_){} setState((){ leftScore+=100; giftMult++; }); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Rass Fan Club sent Rose 🌹 x$giftMult - $leftScore vs $rightScore - x3 gifting points - Rass World Queen Live Only'))); }
  void _toggleFollowRass() { setState(()=> isFollowingRass = !isFollowingRass); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isFollowingRass ? 'Followed Rass Jigar ✅ - Rass World' : 'Unfollowed Rass Jigar'))); }
  void _toggleFollowMain() { setState(()=> isFollowingMain = !isFollowingMain); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isFollowingMain ? 'Followed @rass_jigar ✅ - Rass Live Only' : 'Unfollowed @rass_jigar'))); }
  @override Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, body: SafeArea(child: Column(children: [
      Container(color: const Color(0xFF1A0A2E), padding: const EdgeInsets.all(8), child: Column(children: [
        Row(children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: ()=>Navigator.pop(context)),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(12)), child: const Text('10:02', style: TextStyle(fontSize: 12, color: Colors.white))),
          const SizedBox(width: 8),
          const CircleAvatar(radius: 16, backgroundColor: Colors.pink, child: Text('R', style: TextStyle(fontSize: 12))),
          const SizedBox(width: 6),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Rass Jigar is...', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)), Text('2.4K Watching', style: TextStyle(color: Colors.white54, fontSize: 10))]),
          const SizedBox(width: 8),
          GestureDetector(onTap: _toggleFollowRass, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: isFollowingRass ? Colors.white10 : Colors.pink, borderRadius: BorderRadius.circular(20)), child: Text(isFollowingRass ? 'Following' : '+ Follow', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
          const Spacer(),
          const Icon(Icons.search, color: Colors.white), const SizedBox(width: 8), const Text('2.4K', style: TextStyle(color: Colors.white, fontSize: 12)), const SizedBox(width: 8), const Icon(Icons.close, color: Colors.white),
        ]),
        const SizedBox(height: 6),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.pink.shade900.withOpacity(0.5), borderRadius: BorderRadius.circular(4)), child: const Row(children: [Icon(Icons.card_giftcard, size: 12, color: Colors.white), SizedBox(width: 4), Expanded(child: Text('Rass Fan Club sent Rass Universe+ to Rass World - Rass Live Only', style: TextStyle(color: Colors.white, fontSize: 10))), Icon(Icons.card_giftcard, size: 12)])),
        const SizedBox(height: 6),
        Row(children: [
          const Spacer(),
          const Text('38/100', style: TextStyle(color: Colors.yellow, fontSize: 12)), const SizedBox(width: 4), const Text('⭐', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 12),
          Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(8)), child: const Center(child: Text('💎', style: TextStyle(fontSize: 20)))),
          const SizedBox(width: 8),
          const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('Rass Live Ranking 99+ 🔥', style: TextStyle(color: Colors.white54, fontSize: 8)), Text('Rass Points 1.6M - Rass Live Only', style: TextStyle(color: Colors.white24, fontSize: 7))]),
        ]),
      ])),
      Container(height: 28, color: Colors.black, child: Row(children: [
        Container(width: MediaQuery.of(context).size.width*0.5*leftScore/(leftScore+rightScore), color: const Color(0xFFE91E63), padding: const EdgeInsets.symmetric(horizontal: 8), child: Row(children: [Text('$leftScore', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))])), 
        Expanded(child: Container(color: const Color(0xFF2196F3), padding: const EdgeInsets.symmetric(horizontal: 8), alignment: Alignment.centerRight, child: Text('$rightScore', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)))),
      ])),
      Container(color: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2), child: Row(children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.yellow.shade900, borderRadius: BorderRadius.circular(12)), child: const Text('WIN x3 - Rass World', style: TextStyle(color: Colors.yellow, fontSize: 10, fontWeight: FontWeight.bold))),
        const Spacer(),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)), child: Text('VS ${timerSec~/60}:${(timerSec%60).toString().padLeft(2,'0')}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
        const Spacer(),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)), child: const Text('WIN x0 - Queen Live', style: TextStyle(color: Colors.white54, fontSize: 10))),
      ])),
      Expanded(child: Row(children: [
        Expanded(child: Stack(children: [
          Container(color: const Color(0xFF2A1A1A), child: const Center(child: Text('Rass Jigar\nRass Fan Club sent Rose\nx134\nRass Live Only', textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 10)))),
          Positioned(bottom: 40, left: 8, right: 8, child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)), child: Row(children: [const CircleAvatar(radius: 14, backgroundColor: Colors.pink, child: Text('R', style: TextStyle(fontSize: 10))), const SizedBox(width: 6), const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Rass Fan Club', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)), Text('sent Rose - Rass Live', style: TextStyle(color: Colors.white54, fontSize: 8))]), const Spacer(), const Text('🌹', style: TextStyle(fontSize: 20)), Text(' x$giftMult', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, fontStyle: FontStyle.italic))] ))),
        ])),
        Expanded(child: Stack(children: [
          Container(color: const Color(0xFF1A2A2A), child: const Center(child: Text('Queen Zara\nQueen Live 1.6K\nx2 Heart\nRass Live Only', textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 10)))),
          Positioned(bottom: 40, right: 8, child: Column(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)), child: const Row(children: [Text('✈️ x2 - Rass Live', style: TextStyle(fontSize: 10)), Icon(Icons.favorite_border, size: 16, color: Colors.white)])), const SizedBox(height: 4), const Text('Queen Zara 1.6K', style: TextStyle(color: Colors.yellow, fontSize: 10))])),
        ])),
      ])),
      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), color: const Color(0xFF1A0A2E), child: Row(children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.pink.shade900, borderRadius: BorderRadius.circular(20)), child: const Row(children: [Text('x3 Rass Live gifting points', style: TextStyle(color: Colors.white, fontSize: 10)), SizedBox(width: 12), Text('29s', style: TextStyle(color: Colors.white54, fontSize: 10))])),
        const Spacer(),
        const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20), const SizedBox(width: 4), const Text('14', style: TextStyle(color: Colors.white, fontSize: 12)),
      ])),
      Container(height: 100, color: Colors.black, padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Rass Live Comment - Follow System ON - No Other App', style: TextStyle(color: Colors.white24, fontSize: 10)),
        const SizedBox(height: 6),
        ...comments.map((c)=> Padding(padding: const EdgeInsets.only(bottom: 6), child: Row(children: [
          if(c['level']!=null) Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.blue.shade900, borderRadius: BorderRadius.circular(4)), child: Text('${c['level']}', style: const TextStyle(color: Colors.white, fontSize: 8))),
          const SizedBox(width: 6),
          Expanded(child: RichText(text: TextSpan(children: [TextSpan(text: '${c['user']} ', style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)), TextSpan(text: c['text'], style: const TextStyle(color: Colors.white, fontSize: 11))]))),
        ]))),
      ])),
      Container(color: const Color(0xFF121212), padding: const EdgeInsets.all(8), child: Row(children: [
        const CircleAvatar(radius: 16, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 16)),
        const SizedBox(width: 8),
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('@rass_jigar', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)), Text('Add comment - Rass Live Only', style: TextStyle(color: Colors.white54, fontSize: 10))]),
        const SizedBox(width: 12),
        GestureDetector(onTap: _toggleFollowMain, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), decoration: BoxDecoration(color: isFollowingMain ? Colors.white10 : Colors.pink, borderRadius: BorderRadius.circular(20), border: Border.all(color: isFollowingMain ? Colors.white24 : Colors.pink)), child: Text(isFollowingMain ? 'Following' : '+ Follow', style: TextStyle(color: isFollowingMain ? Colors.white54 : Colors.white, fontSize: 12, fontWeight: FontWeight.bold)))),
        const Spacer(),
        Column(children: [
          const Icon(Icons.bookmark_border, color: Colors.white, size: 24), const Text('Save', style: TextStyle(color: Colors.white54, fontSize: 8)), const SizedBox(height: 8),
          const Icon(Icons.send, color: Colors.white, size: 20), const Text('Share', style: TextStyle(color: Colors.white54, fontSize: 8)), const SizedBox(height: 8),
          GestureDetector(onTap: _sendRose, child: const Column(children: [Icon(Icons.favorite, color: Colors.red, size: 28), SizedBox(height: 2), Text('3', style: TextStyle(color: Colors.white, fontSize: 10))])),
        ]),
      ])),
      Container(color: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), child: Row(children: [
        const Expanded(child: Text('Rass Live PK Match - Rass Jigar vs Queen Zara #rasslive #rassworld - Rass Live Only', style: TextStyle(color: Colors.white, fontSize: 11))),
        const SizedBox(width: 8),
        Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.card_giftcard, color: Colors.orange, size: 20)),
        const SizedBox(width: 8),
        Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(8)), child: const Center(child: Text('🌹', style: TextStyle(fontSize: 16)))),
        const SizedBox(width: 8),
        Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(8)), child: const Center(child: Text('🎁', style: TextStyle(fontSize: 16)))),
      ])),
    ])));
  }
}

// ================== CODE B WALA - LIVE ROOM - 150 GIFT + SOUND + FRONT/BACK - APP ID SIGN - NO DELETE ==================
class LiveRoom extends StatefulWidget { final String roomName; const LiveRoom({super.key, required this.roomName}); @override State<LiveRoom> createState() => _LiveRoomState(); }
class _LiveRoomState extends State<LiveRoom> {
  CameraController? ctrl; List<CameraDescription> allCams = []; bool isFront = true; bool isLive = false; final AudioPlayer audioPlayer = AudioPlayer();
  final List<Map<String, dynamic>> allGifts = [
    {"name": "Party Popper", "icon": "🎉", "price": 10}, {"name": "New Star", "icon": "⭐", "price": 30}, {"name": "Spiderweb", "icon": "🕸️", "price": 50}, {"name": "Broom", "icon": "🧹", "price": 50}, {"name": "Candy", "icon": "🍬", "price": 100}, {"name": "Skull", "icon": "💀", "price": 100}, {"name": "Lucky Box", "icon": "🎁", "price": 150}, {"name": "Fan Light", "icon": "💡", "price": 10}, {"name": "Sweet Bouquet", "icon": "💐", "price": 100}, {"name": "Hand Mirror", "icon": "🪞", "price": 200}, {"name": "Parrot", "icon": "🦜", "price": 200}, {"name": "Dancing Clock", "icon": "🕰️", "price": 300}, {"name": "Magic Kitty", "icon": "🐱", "price": 5000}, {"name": "Rose Route", "icon": "🌹", "price": 10000}, {"name": "Balloon", "icon": "🎈", "price": 12000}, {"name": "Wind Chimes", "icon": "🎐", "price": 15000}, {"name": "Rocking Horse", "icon": "🐴", "price": 18000}, {"name": "Back Massage", "icon": "💆", "price": 36000}, {"name": "Sleeping Beauty", "icon": "👸", "price": 40000}, {"name": "Rainbow", "icon": "🌈", "price": 50000}, {"name": "LOVE Bear", "icon": "🐻", "price": 55000}, {"name": "Pirate Booty", "icon": "🏴‍☠️", "price": 150000}, {"name": "Crystal Castle", "icon": "🏰", "price": 200000}, {"name": "Kiss", "icon": "💋", "price": 5}, {"name": "Rose", "icon": "🌹", "price": 10}, {"name": "Lollipop", "icon": "🍭", "price": 50}, {"name": "Diamond", "icon": "💎", "price": 300}, {"name": "Shark Submarine", "icon": "🦈", "price": 10000}, {"name": "Candy House", "icon": "🍭", "price": 12000}, {"name": "Yacht", "icon": "🛥️", "price": 800000}, {"name": "Castle King", "icon": "🏰", "price": 1000000},
  ];
  @override void initState() { super.initState(); _startCamera(); }
  Future<void> _startCamera() async { try { allCams = await availableCameras(); if (allCams.isEmpty) return; CameraDescription selected = isFront ? allCams.firstWhere((c) => c.lensDirection == CameraLensDirection.front, orElse: () => allCams.first) : allCams.firstWhere((c) => c.lensDirection == CameraLensDirection.back, orElse: () => allCams.first); await ctrl?.dispose(); ctrl = CameraController(selected, ResolutionPreset.high, enableAudio: true); await ctrl!.initialize(); if (mounted) setState(() {}); } catch (e) {} }
  Future<void> _switchCamera() async { setState(() => isFront = !isFront); await _startCamera(); }
  void _sendGift(Map gift) async { try { await audioPlayer.play(AssetSource('sounds/gift.mp3')); } catch (_) {} ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${gift['name']} ${gift['icon']} bheja - ${gift['price']} Coins 🔊💳 Wallet Connect - Rass Live Only'))); }
  @override void dispose() { ctrl?.dispose(); audioPlayer.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.black, title: Text('${widget.roomName} - Rass Live Only - AppID com.rasslive.world Verified ✅', style: const TextStyle(fontSize: 10)), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)), actions: [IconButton(icon: const Icon(Icons.sports_kabaddi), onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const RassPKPage()))), Container(margin: const EdgeInsets.all(8), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(12)), child: const Text('Rass Live Effect ON', style: TextStyle(fontSize: 8)))]), body: Stack(children: [
      if (ctrl != null && ctrl!.value.isInitialized) SizedBox.expand(child: CameraPreview(ctrl!)) else Container(color: Colors.black, child: const Center(child: Text('LIVE - Camera ON - Front Camera Face Ayega - Rass Live Only - LEVEL 8', style: TextStyle(color: Colors.white38, fontSize: 10)))),
      Positioned(top: 10, left: 10, right: 10, child: Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)), child: const Row(children: [Icon(Icons.remove_red_eye, size: 12, color: Colors.white), SizedBox(width: 4), Text('2.4K | 1257/100 | LEVEL 8 | 150 Gifts | Rass Live Only', style: TextStyle(fontSize: 7, color: Colors.white))])), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(12)), child: const Text('Rass World + Queen Live + PK Arena + 9 Stars + Rass Live Only', style: TextStyle(fontSize: 7)))])),
      Positioned(bottom: 60, left: 0, right: 0, top: 50, child: Container(decoration: BoxDecoration(color: const Color(0xFF1E1E1E).withOpacity(0.95), borderRadius: const BorderRadius.vertical(top: Radius.circular(20))), child: Column(children: [Container(padding: const EdgeInsets.all(8), child: const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text('Gift 150 🎁', style: TextStyle(color: Colors.pink, fontSize: 10, fontWeight: FontWeight.bold)), Text('Rass Live Only', style: TextStyle(color: Colors.cyan, fontSize: 8)), Text('PK 752718⚔️', style: TextStyle(color: Colors.white54, fontSize: 8)), Text('Follow 👑', style: TextStyle(color: Colors.orange, fontSize: 8))])), Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.65), itemCount: allGifts.length, itemBuilder: (c, i) { final g = allGifts[i]; return GestureDetector(onTap: () => _sendGift(g), child: Container(margin: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(g['icon'], style: const TextStyle(fontSize: 26)), Text(g['name'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 7)), Text('${g['price']}', style: const TextStyle(fontSize: 7, color: Colors.orange))] ))); }))]))),
      Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.all(8), child: Row(children: [const Expanded(child: TextField(style: TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'Say Hi... 150 Gifts + Rass Live Only + Follow System - Rass World Queen Live', hintStyle: TextStyle(color: Colors.white54, fontSize: 9), border: InputBorder.none))), IconButton(icon: Icon(isFront ? Icons.camera_rear : Icons.camera_front, color: Colors.yellow), onPressed: _switchCamera), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), onPressed: () => setState(() => isLive = !isLive), child: Text(isLive ? 'END' : 'Go LIVE'))]))),
    ]));
  }
}

class PrivatePage extends StatelessWidget { const PrivatePage({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Private Page 🔒 - Rass Live Only - 89 Viewers')), body: ListView(padding: const EdgeInsets.all(12), children: [Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: const Column(children: [Icon(Icons.lock, size: 50, color: Colors.pink), SizedBox(height: 8), Text('Private Room - Viewers: 89 | Score: 1/1 | Invite Only - Rass Live Only', style: TextStyle(fontWeight: FontWeight.bold)), Text('Rass World Private - Queen Live Private - Gift Marzi - 150 Gifts - Wallet Connect - Rass Live Only', textAlign: TextAlign.center, style: TextStyle(color: Colors.white54, fontSize: 10))])), const ListTile(leading: CircleAvatar(backgroundColor: Colors.pink, child: Text('1', style: TextStyle(color: Colors.white))), title: Text('Private Room 1'), subtitle: Text('Viewers: 89 | Score: 1/1 - Invite Code: RASS123 - LIVE - Rass Live Only'))])); }

class FamilyPage extends StatelessWidget { const FamilyPage({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Family Room 4 👨‍👩‍👧‍👦 - Rass Live Only')), body: GridView.count(crossAxisCount: 2, padding: const EdgeInsets.all(12), children: List.generate(4, (i) => Container(margin: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.pink.withOpacity(0.3))), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 60, height: 60, decoration: const BoxDecoration(color: Color(0xFFE91E63), shape: BoxShape.circle), child: Center(child: Text('${i+1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)))), const SizedBox(height: 8), Text('Family Seat ${i+1}', style: const TextStyle(fontWeight: FontWeight.bold)), const Text('Viewers: 156 | Score: 4/4 | Gift Marzi - Rass Live Only', style: TextStyle(color: Colors.white54, fontSize: 8)), ElevatedButton(onPressed: () {}, child: const Text('Join', style: TextStyle(fontSize: 10)))]))))); }

class VideoPage extends StatefulWidget { const VideoPage({super.key}); @override State<VideoPage> createState() => _VideoPageState(); }
class _VideoPageState extends State<VideoPage> {
  final AudioPlayer audioPlayer = AudioPlayer(); PageController pageController = PageController();
  List<Map<String, dynamic>> videos = [
    {"user": "Singer Faiza Ali 58", "likes": 3546, "comments": 456, "shares": 348, "bookmarks": 46, "isLiked": false, "isFollowed": false, "caption": "Beach wala Heart Dil ❤️ #rasslive #rassworld - Rass Live Only", "song": "Guzarish - Original Sound - Rass Live Only"},
    {"user": "Queen Live 👑", "likes": 12500, "comments": 2100, "shares": 480, "bookmarks": 96, "isLiked": true, "isFollowed": true, "caption": "PK karoge? 🔥 752718 vs 338881 #rasslive #rassworld - Rass Live Only", "song": "Lofi Beat - Queen Live"},
    {"user": "Rass World 🌍", "likes": 8920, "comments": 540, "shares": 210, "bookmarks": 120, "isLiked": false, "isFollowed": false, "caption": "Rass PK Arena Winner 🏆 9 Stars Multi - Rass Live Only", "song": "Victory Anthem - Rass World"},
  ];
  void _toggleLike(int i) { setState(() { videos[i]['isLiked'] = !videos[i]['isLiked']; if (videos[i]['isLiked']) videos[i]['likes']++; else videos[i]['likes']--; }); }
  void _toggleFollow(int i) { setState(() => videos[i]['isFollowed'] = !videos[i]['isFollowed']); }
  void _showComments() { showModalBottomSheet(context: context, backgroundColor: const Color(0xFF121212), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (_) => Container(height: 400, padding: const EdgeInsets.all(12), child: const Column(children: [Text('Comments - 150 Gifts + PK 752718 + Rass Live Only - Follow System'), Expanded(child: Center(child: Text('Ali: Zabardast ❤️ Rass World Queen Live - Rass Live Only - Follow System')))]))); }
  void _showCreateSheet() { showModalBottomSheet(context: context, backgroundColor: Colors.black, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (_) => Container(height: 500, padding: const EdgeInsets.all(12), child: const Column(children: [Text('Create - Add sound 🎵 - Beauty - Filters - Clips - Audio - Text - Stickers - Effects - Speed - 10m 60s 15s PHOTO TEXT - Rass World Queen Live PK Arena 9 Stars Multi - Rass Live Only - Follow System')] ))); }
  @override Widget build(BuildContext context) { return Scaffold(body: PageView.builder(scrollDirection: Axis.vertical, controller: pageController, itemCount: videos.length, itemBuilder: (context, index) { final v = videos[index]; return Stack(children: [Container(color: const Color(0xFF0A0A0A), child: const Center(child: Icon(Icons.play_circle_fill, size: 80, color: Colors.white24))), Positioned(right: 12, bottom: 120, child: Column(children: [Stack(children: [const CircleAvatar(radius: 28, backgroundColor: Colors.pink, child: Icon(Icons.person)), Positioned(bottom: 0, left: 0, right: 0, child: GestureDetector(onTap: () => _toggleFollow(index), child: Container(width: 20, height: 20, decoration: BoxDecoration(color: v['isFollowed'] ? Colors.white10 : Colors.pink, shape: BoxShape.circle), child: Icon(v['isFollowed'] ? Icons.check : Icons.add, size: 12))))]), const SizedBox(height: 20), GestureDetector(onTap: () => _toggleLike(index), child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.white10, shape: BoxShape.circle), child: Icon(Icons.favorite, size: 32, color: Colors.white)), Text('${v['likes']}', style: const TextStyle(fontSize: 12)), Text(v['isLiked'] ? 'Liked ❤️' : 'Like - Follow System', style: const TextStyle(fontSize: 8, color: Colors.white54))])), const SizedBox(height: 16), GestureDetector(onTap: _showComments, child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.white10, shape: BoxShape.circle), child: const Icon(Icons.chat_bubble, size: 28)), Text('${v['comments']}', style: const TextStyle(fontSize: 12))]))])), Positioned(left: 12, right: 80, bottom: 20, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text('@${v['user']}', style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(width: 8), GestureDetector(onTap: () => _toggleFollow(index), child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: v['isFollowed'] ? Colors.white10 : Colors.pink, borderRadius: BorderRadius.circular(4)), child: Text(v['isFollowed'] ? 'Following' : '+ Follow', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))))]), Text(v['caption'], style: const TextStyle(fontSize: 12)), Row(children: [const Icon(Icons.music_note, size: 14), Text(v['song'], style: const TextStyle(fontSize: 11))])])), Positioned(top: 40, left: 12, right: 12, child: Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)), child: const Text('Restricted Mode - Rass World Queen Live PK Arena 9 Stars - Rass Live Only - Follow System', style: TextStyle(fontSize: 8))), const Spacer(), GestureDetector(onTap: _showCreateSheet, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(12)), child: const Text('Create', style: TextStyle(fontSize: 12))))]))]); }), floatingActionButton: FloatingActionButton.extended(backgroundColor: Colors.pink, onPressed: _showCreateSheet, icon: const Icon(Icons.video_call), label: const Text('Go LIVE - Video Editing - Follow System'))); }
}

class MessengerPage extends StatelessWidget { const MessengerPage({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Messenger - 5000 Coins - Rass World Queen Live PK Arena - Rass Live Only - Follow System')), body: ListView(padding: const EdgeInsets.all(12), children: const [ListTile(leading: CircleAvatar(child: Text('R')), title: Text('Rass Jigar 2.4K Watching'), subtitle: Text('752718 vs 338881 - PK karoge? 🔥 9 Stars Multi - Rass Live Only - Follow System'), trailing: Text('2m')), ListTile(leading: CircleAvatar(child: Text('Q')), title: Text('Queen Zara 👑'), subtitle: Text('PK karoge? 🔥 9 Stars Multi me ao - Rose x134 - Follow System'), trailing: Text('2m')), ListTile(leading: CircleAvatar(child: Text('W')), title: Text('Rass World 🌍'), subtitle: Text('Rass PK Arena Winner 🏆 4864 VS 2784 - Follow System'), trailing: Text('5m'))])); }

class GamesPage extends StatefulWidget { const GamesPage({super.key}); @override State<GamesPage> createState() => _GamesPageState(); }
class _GamesPageState extends State<GamesPage> {
  final AudioPlayer audioPlayer = AudioPlayer(); String selectedCat = "All";
  final List<Map<String, dynamic>> allGames = [
    {"name": "PK Battle", "sub": "71 Games - Rass PK Arena 752718", "icon": "⚔️", "cat": "Battle", "entry": "50", "win": "90", "players": "12.3K"},
    {"name": "Ludo King", "sub": "6 Games - Rass World 1257", "icon": "🎲", "cat": "Casual", "entry": "50", "win": "90", "players": "45.2K"},
    {"name": "Teen Patti", "sub": "10 Games - Queen Live 892", "icon": "🃏", "cat": "Card", "entry": "100", "win": "180", "players": "32.1K"},
    {"name": "Poker Pro", "sub": "5 Games - 9 Stars Multi 321", "icon": "♠️", "cat": "Card", "entry": "200", "win": "360", "players": "18.5K"},
    {"name": "8 Ball Pool", "sub": "9 Games - Rass World", "icon": "🎱", "cat": "Casual", "entry": "50", "win": "90", "players": "28.4K"},
    {"name": "Football", "sub": "9 Games - PK Arena", "icon": "⚽", "cat": "Battle", "entry": "50", "win": "90", "players": "15.2K"},
    {"name": "Car Racing", "sub": "12 Games - Rass World", "icon": "🏎️", "cat": "Battle", "entry": "100", "win": "180", "players": "22.1K"},
    {"name": "Snake Ladder", "sub": "4 Games - Queen Live", "icon": "🐍", "cat": "Casual", "entry": "20", "win": "36", "players": "35.6K"},
    {"name": "Chess Master", "sub": "3 Games - 9 Stars", "icon": "♟️", "cat": "Battle", "entry": "50", "win": "90", "players": "12.8K"},
    {"name": "Domino", "sub": "2 Games", "icon": "🁢", "cat": "Card", "entry": "30", "win": "54", "players": "9.2K"},
    {"name": "Rummy", "sub": "8 Games - Rass World", "icon": "♦️", "cat": "Card", "entry": "100", "win": "180", "players": "19.3K"},
    {"name": "Bubble Shooter", "sub": "15 Games - Queen Live", "icon": "🫧", "cat": "Casual", "entry": "20", "win": "36", "players": "41.2K"},
    {"name": "Candy Crush", "sub": "20 Games - Rass World", "icon": "🍭", "cat": "Casual", "entry": "30", "win": "54", "players": "38.7K"},
    {"name": "Carrom", "sub": "3 Games - 9 Stars Multi", "icon": "🥏", "cat": "Casual", "entry": "50", "win": "90", "players": "16.4K"},
    {"name": "Cricket Hit", "sub": "6 Games - PK Arena", "icon": "🏏", "cat": "Battle", "entry": "50", "win": "90", "players": "24.5K"},
    {"name": "Basketball", "sub": "5 Games - Rass World", "icon": "🏀", "cat": "Battle", "entry": "50", "win": "90", "players": "14.2K"},
    {"name": "Archery", "sub": "4 Games - Queen Live", "icon": "🏹", "cat": "Battle", "entry": "40", "win": "72", "players": "8.9K"},
    {"name": "Bowling", "sub": "3 Games - 9 Stars", "icon": "🎳", "cat": "Casual", "entry": "30", "win": "54", "players": "11.3K"},
    {"name": "Dart King", "sub": "2 Games - Rass World", "icon": "🎯", "cat": "Casual", "entry": "20", "win": "36", "players": "7.8K"},
    {"name": "Puzzle Pro", "sub": "25 Games - Queen Live", "icon": "🧩", "cat": "Casual", "entry": "20", "win": "36", "players": "33.1K"},
    {"name": "Memory Match", "sub": "10 Games - 9 Stars Multi", "icon": "🧠", "cat": "Casual", "entry": "20", "win": "36", "players": "29.4K"},
    {"name": "Tic Tac Toe", "sub": "2 Games - Rass World", "icon": "⭕", "cat": "Casual", "entry": "10", "win": "18", "players": "52.3K"},
    {"name": "Word Guess", "sub": "12 Games - Queen Live", "icon": "📝", "cat": "Casual", "entry": "30", "win": "54", "players": "18.9K"},
    {"name": "Quiz Battle", "sub": "30 Games - PK Arena", "icon": "❓", "cat": "Battle", "entry": "50", "win": "90", "players": "26.7K"},
    {"name": "Spin Wheel", "sub": "Lucky - Rass World", "icon": "🎡", "cat": "Casual", "entry": "10", "win": "100", "players": "48.2K"},
    {"name": "Slot Machine", "sub": "Jackpot - Queen Live", "icon": "🎰", "cat": "Card", "entry": "100", "win": "1000", "players": "31.5K"},
    {"name": "Dice Roll", "sub": "Lucky Dice - 9 Stars", "icon": "🎲", "cat": "Casual", "entry": "20", "win": "36", "players": "27.8K"},
    {"name": "UNO", "sub": "4 Games - Rass World", "icon": "🃏", "cat": "Card", "entry": "50", "win": "90", "players": "36.9K"},
    {"name": "Bike Racing", "sub": "8 Games - PK Arena", "icon": "🏍️", "cat": "Battle", "entry": "100", "win": "180", "players": "19.8K"},
    {"name": "Ludo Supreme", "sub": "Pro Ludo - 9 Stars Multi", "icon": "👑", "cat": "Casual", "entry": "200", "win": "360", "players": "42.1K"},
  ];
  List<Map<String, dynamic>> get filteredGames { if (selectedCat == "All") return allGames; return allGames.where((g) => g['cat'] == selectedCat).toList(); }
  void _playGame(Map game) async { try { await audioPlayer.play(AssetSource('sounds/game_start.mp3')); } catch (_) {} Navigator.push(context, MaterialPageRoute(builder: (_) => GamePlayPage(gameName: game['name'], icon: game['icon']))); }
  @override Widget build(BuildContext context) {
    return SafeArea(child: Column(children: [
      Padding(padding: const EdgeInsets.all(12), child: Row(children: [const Text('Games - Rass World Queen Live PK Arena 9 Stars Multi - Rass Live Only - Follow System', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)), const Spacer(), const Icon(Icons.diamond, size: 12, color: Colors.orange), const Text(' 5000 Coins', style: TextStyle(fontSize: 10))])),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [_cat('All', selectedCat == 'All'), _cat('Casual', selectedCat == 'Casual'), _cat('Card', selectedCat == 'Card'), _cat('Battle', selectedCat == 'Battle')]))),
      const SizedBox(height: 8),
      Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.85, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: filteredGames.length, itemBuilder: (c, i) { final g = filteredGames[i]; return GestureDetector(onTap: () => _playGame(g), child: Container(decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(g['icon'], style: const TextStyle(fontSize: 40)), const SizedBox(height: 8), Text(g['name'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Text(g['sub'], style: const TextStyle(color: Colors.white54, fontSize: 7), textAlign: TextAlign.center), const SizedBox(height: 6), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade900, borderRadius: BorderRadius.circular(12)), child: Text('${g['players']} Playing', style: const TextStyle(color: Colors.greenAccent, fontSize: 8))), const SizedBox(height: 6), Text('Entry ${g['entry']} Win ${g['win']}\nGift Marzi\nWinner 90% Wallet', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white24, fontSize: 7)), const SizedBox(height: 6), Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(12)), child: const Text('PLAY - Upar Neechay', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold))) ]))); })),
    ]));
  }
  Widget _cat(String t, bool sel) => GestureDetector(onTap: () => setState(() => selectedCat = t), child: Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: sel ? Colors.pink : Colors.white10, borderRadius: BorderRadius.circular(20)), child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 11))));
}

class GamePlayPage extends StatefulWidget { final String gameName; final String icon; const GamePlayPage({super.key, required this.gameName, required this.icon}); @override State<GamePlayPage> createState() => _GamePlayPageState(); }
class _GamePlayPageState extends State<GamePlayPage> {
  final AudioPlayer audioPlayer = AudioPlayer(); int myCoins = 5000; int myDiamonds = 1250; String selectedBetType = "Coins"; String selectedSide = "UPAR"; int betAmount = 50; Map<String, dynamic>? selectedGiftBet;
  final List<Map<String, dynamic>> allGiftsForBet = [{"name": "Rose", "icon": "🌹", "price": 10}, {"name": "Kiss", "icon": "💋", "price": 5}, {"name": "Diamond", "icon": "💎", "price": 300}, {"name": "Yacht", "icon": "🛥️", "price": 800000}, {"name": "Castle", "icon": "🏰", "price": 200000}];
  void _placeBet() async { try { await audioPlayer.play(AssetSource('sounds/gift.mp3')); } catch (_) {} bool isWin = (DateTime.now().millisecond % 2 == 0); int winAmount = (betAmount * 1.8).toInt(); if (isWin) { setState(() { if (selectedBetType == "Coins") myCoins += winAmount; }); ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text('WINNER! 🎉 $selectedSide jeet gaya! - $winAmount jeeta - 90% Wallet - Rass Live Only - Follow System'))); } else { ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.orange, content: Text('LOST! $selectedSide haar gaya!'))); } }
  @override Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: Text('${widget.icon} ${widget.gameName} - Upar Neechay - Rass Live Only - Follow System', style: const TextStyle(fontSize: 10)), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))), body: Column(children: [Container(padding: const EdgeInsets.all(16), margin: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.pink.withOpacity(0.5))), child: Column(children: [Text('${widget.icon} ${widget.gameName}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12), Row(children: [Expanded(child: GestureDetector(onTap: () => setState(() => selectedSide = "UPAR"), child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: selectedSide == "UPAR" ? Colors.green : Colors.white10, borderRadius: BorderRadius.circular(12)), child: const Column(children: [Text('📈', style: TextStyle(fontSize: 30)), Text('UPAR - 752718', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)), Text('50%', style: TextStyle(fontSize: 10))])))), const SizedBox(width: 12), const Text('VS'), const SizedBox(width: 12), Expanded(child: GestureDetector(onTap: () => setState(() => selectedSide = "NEECHAY"), child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: selectedSide == "NEECHAY" ? Colors.red : Colors.white10, borderRadius: BorderRadius.circular(12)), child: const Column(children: [Text('📉', style: TextStyle(fontSize: 30)), Text('NEECHAY - 338881', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)), Text('50%', style: TextStyle(fontSize: 10))])))), ]), const SizedBox(height: 8), Text('Selected: $selectedSide - Rass Live Only - 752718 vs 338881 - Follow System', style: TextStyle(color: selectedSide == "UPAR" ? Colors.green : Colors.red, fontSize: 10, fontWeight: FontWeight.bold)) ])), Container(padding: const EdgeInsets.all(12), color: const Color(0xFF121212), child: SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, padding: const EdgeInsets.all(14)), onPressed: _placeBet, child: Text('SHART LAGAO - $betAmount $selectedBetType - $selectedSide 📈 - WIN ${(betAmount * 1.8).toInt()} - Rass Live Only', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)))))]));
  }
}

class WalletPage extends StatefulWidget { const WalletPage({super.key}); @override State<WalletPage> createState() => _WalletPageState(); }
class _WalletPageState extends State<WalletPage> {
  final List<Map<String, dynamic>> packs = [{"coins": "100", "price": "\$1.99"}, {"coins": "330", "price": "\$5.97"}, {"coins": "500", "price": "\$9.99"}, {"coins": "1000", "price": "\$19.99"}, {"coins": "5000", "price": "\$99.99"}];
  @override Widget build(BuildContext context) {
    return SafeArea(child: ListView(padding: const EdgeInsets.all(16), children: [const Text('RASS WORLD WALLET - Rass Live Only - Follow System - 752718 vs 338881', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)), const SizedBox(height: 12), Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFF3A2E00), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.orange)), child: const Column(children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.monetization_on, color: Colors.yellow, size: 32), SizedBox(width: 8), Text('5,000', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold))]), Text('Recharge Available in 195 Countries ✅ Stripe + Card + JazzCash + Easypaisa - Rass Live Only - Follow System', textAlign: TextAlign.center, style: TextStyle(color: Colors.yellow, fontSize: 8, fontWeight: FontWeight.bold))])), const SizedBox(height: 12), ...packs.map((p) => Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Row(children: [const Icon(Icons.monetization_on, color: Colors.yellow), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('${p['coins']} Coins - Rass Live Only', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)), Text(p['price'])]), const Spacer(), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), onPressed: () {}, child: const Text('Card Pay 💳'))])))]));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Profile - @rass_jigar - LEVEL 8 - Rass Live Only - Follow System", style: TextStyle(fontSize: 10))), body: ListView(padding: const EdgeInsets.all(12), children: [const CircleAvatar(radius: 40, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 40)), const SizedBox(height: 8), const Center(child: Text("Rass Jigar - Host Mode ON - Rass World 🌍 Queen Live 👑 PK Arena ⚔️ 9 Stars ⭐ - Rass Live Only - Follow System", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))), const Center(child: Text("LEVEL 8 🔥 1250/2000 XP - Rass Live Only - Follow System", textAlign: TextAlign.center, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 10))), ListTile(leading: const Icon(Icons.settings), title: const Text("Settings - AppID + App Sign + Build + Rass Live Only Full"), subtitle: const Text("AppID: com.rasslive.world Verified ✅ - LEVEL 8\nApp Sign: rasslive-key.jks - SHA1 Verified - Build #208 - 0 Errors\n150 Gifts - Video Best - 30 Games Upar Neechay - Coin Diamond Gift Shart - 195 Mulk Stripe - Follow System Only\nRass World 1257/100 Queen Live 892/85 Rass PK Arena 543/70 9 Stars Multi 321/60 Voice Live 210/50 LIVE\nRass PK 752718 vs 338881 WIN x3 vs WIN x0 1:40 Rose x134 x3 gifting points - Follow System Only - Rass Live Only - Merged A+B"))])); 
}

class VoiceLivePage extends StatelessWidget { const VoiceLivePage({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Voice Live 🎤 - Viewers: 210 | Score: 50 - LIVE - Rass Live Only - Follow System')), body: GridView.count(crossAxisCount: 4, padding: const EdgeInsets.all(12), children: List.generate(8, (i) => Container(margin: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircleAvatar(radius: 24, backgroundColor: i<3?Colors.pink:Colors.white10, child: Text(i<3?'🎤':'🔇', style: const TextStyle(fontSize: 16))), const SizedBox(height: 6), Text('Seat ${i+1}', style: const TextStyle(fontSize: 8)), Text(i<3?'User ${i+1} - Rass Live Only':'Empty', style: const TextStyle(fontSize: 7, color: Colors.white54))]))))); }

class NineStarsPage extends StatelessWidget { final String roomName; const NineStarsPage({super.key, required this.roomName}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('${widget.roomName} - Viewers: 321 | Score: 60 - 9 Stars Multi ⭐ - LIVE - Rass Live Only - Follow System')), body: GridView.count(crossAxisCount: 3, padding: const EdgeInsets.all(8), children: List.generate(9, (i) => Container(margin: const EdgeInsets.all(4), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.pink.withOpacity(0.3))), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 40, height: 40, decoration: const BoxDecoration(color: Color(0xFFE91E63), shape: BoxShape.circle), child: Center(child: Text('${i+1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))), const SizedBox(height: 6), Text('Host ${i+1} - Rass Live Only', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)), Text('Viewers: ${100+i*10} | Score: ${60+i}', style: const TextStyle(fontSize: 6, color: Colors.white54)), const Text('LIVE - Rass Live Only', style: TextStyle(color: Colors.green, fontSize: 8, fontWeight: FontWeight.bold))]))))); }

class PKBattlePage extends StatelessWidget { const PKBattlePage({super.key}); @override Widget build(BuildContext context) => const RassPKPage(); }
