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
      Container(padding: const EdgeInsets.all(8), color: const Color(0xFF121212), child: const Row(children: [Icon(Icons.verified, size: 12, color: Colors.green), Text(' AppID: com.rasslive.world Verified - Rass Live Only - Merged Code A+B', style: TextStyle(color: Colors.white54, fontSize: 6))])),
    ]));
  }
}

class LiveRoom extends StatefulWidget { final String roomName; const LiveRoom({super.key, required this.roomName}); @override State<LiveRoom> createState() => _LiveRoomState(); }
class _LiveRoomState extends State<LiveRoom> {
  CameraController? ctrl; List<CameraDescription> allCams = []; bool isFront = true; bool isLive = false; final AudioPlayer audioPlayer = AudioPlayer();
  @override void initState() { super.initState(); _startCamera(); }
  Future<void> _startCamera() async { try { allCams = await availableCameras(); if (allCams.isEmpty) return; CameraDescription selected = isFront ? allCams.firstWhere((c) => c.lensDirection == CameraLensDirection.front, orElse: () => allCams.first) : allCams.firstWhere((c) => c.lensDirection == CameraLensDirection.back, orElse: () => allCams.first); await ctrl?.dispose(); ctrl = CameraController(selected, ResolutionPreset.high, enableAudio: true); await ctrl!.initialize(); if (mounted) setState(() {}); } catch (e) {} }
  Future<void> _switchCamera() async { setState(() => isFront = !isFront); await _startCamera(); }
  void _sendGift() async { try { await audioPlayer.play(AssetSource('sounds/gift.mp3')); } catch (_) {} ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gift bheja - Coins Wallet Connect - Rass Live Only'))); }
  @override void dispose() { ctrl?.dispose(); audioPlayer.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.black, title: Text('${widget.roomName} - Rass Live Only', style: const TextStyle(fontSize: 10)), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))), body: Stack(children: [
      if (ctrl != null && ctrl!.value.isInitialized) SizedBox.expand(child: CameraPreview(ctrl!)) else Container(color: Colors.black, child: const Center(child: Text('LIVE - Camera ON', style: TextStyle(color: Colors.white38)))),
      Positioned(top: 10, left: 10, right: 10, child: Wrap(spacing: 6, runSpacing: 6, children: List.generate(8, (i) => GestureDetector(onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gift ${i+1} bheja'))), child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(6)), child: Text('Gift ${i+1}', style: const TextStyle(color: Colors.white, fontSize: 11))))))),
      Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.all(8), child: Row(children: [const Expanded(child: TextField(style: TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'Say Hi...', hintStyle: TextStyle(color: Colors.white54), border: InputBorder.none))), IconButton(icon: Icon(isFront ? Icons.camera_rear : Icons.camera_front, color: Colors.yellow), onPressed: _switchCamera), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), onPressed: () {}, child: const Text('Go LIVE'))]))),
    ]));
  }
}

class PrivatePage extends StatelessWidget { const PrivatePage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Private 1v1 Room', style: TextStyle(color: Colors.white)))); }
class FamilyPage extends StatelessWidget { const FamilyPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Family Room 4 Seats', style: TextStyle(color: Colors.white)))); }
class VideoPage extends StatelessWidget { const VideoPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Video Feed', style: TextStyle(color: Colors.white)))); }
class MessengerPage extends StatelessWidget { const MessengerPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Messenger', style: TextStyle(color: Colors.white)))); }
class GamesPage extends StatelessWidget { const GamesPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Games', style: TextStyle(color: Colors.white)))); }
class WalletPage extends StatelessWidget { const WalletPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Wallet', style: TextStyle(color: Colors.white)))); }
class ProfilePage extends StatelessWidget { const ProfilePage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Profile', style: TextStyle(color: Colors.white)))); }
class VoiceLivePage extends StatelessWidget { const VoiceLivePage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Voice Live', style: TextStyle(color: Colors.white)))); }
class NineStarsPage extends StatelessWidget { final String roomName; const NineStarsPage({super.key, required this.roomName}); @override Widget build(BuildContext context) => Scaffold(body: Center(child: Text(roomName, style: const TextStyle(color: Colors.white)))); }
class RassPKPage extends StatelessWidget { const RassPKPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('PK Arena', style: TextStyle(color: Colors.white)))); }
