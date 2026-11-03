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
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black), home: const MainNav());
  }
}

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _index = 0;
  final pages = [
    const RassLiveScorePage(),
    const PrivatePage(),
    const FamilyPage(),
    const VideoPage(),
    const MessengerPage(),
    const GamesPage(),
    const WalletPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF121212),
        selectedItemColor: const Color(0xFFE91E63),
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

class RassLiveScorePage extends StatelessWidget {
  const RassLiveScorePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.all(12), child: Text('RASS LIVE - Score', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18))),
      Expanded(child: ListView(children: [
        ListTile(title: const Text('Rass World 🌍 1257/100'), trailing: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveRoom(roomName: 'Rass World'))), child: const Text('Join LIVE'))),
        ListTile(title: const Text('Queen Live 👑 892/85'), trailing: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveRoom(roomName: 'Queen Live'))), child: const Text('Join LIVE'))),
        ListTile(title: const Text('Rass PK Arena 543/70'), trailing: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveRoom(roomName: 'Rass PK Arena'))), child: const Text('Join LIVE'))),
        ListTile(title: const Text('9 Stars Multi 321/60'), trailing: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveRoom(roomName: '9 Stars Multi'))), child: const Text('Join LIVE'))),
        ListTile(title: const Text('Voice Live 🔒 210/50'), trailing: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveRoom(roomName: 'Voice Live'))), child: const Text('Join LIVE'))),
      ])),
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

  @override
  void initState() { super.initState(); _startCamera(); }

  Future<void> _startCamera() async {
    try {
      allCams = await availableCameras();
      if (allCams.isEmpty) return;
      final frontCams = allCams.where((c) => c.lensDirection == CameraLensDirection.front).toList();
      final backCams = allCams.where((c) => c.lensDirection == CameraLensDirection.back).toList();
      CameraDescription selectedCam;
      if (isFront && frontCams.isNotEmpty) selectedCam = frontCams[0];
      else if (!isFront && backCams.isNotEmpty) selectedCam = backCams[0];
      else selectedCam = allCams[0];
      ctrl = CameraController(selectedCam, ResolutionPreset.high);
      await ctrl!.initialize();
      if (mounted) setState(() {});
    } catch (e) {}
  }

  Future<void> _switchCamera() async {
    setState(() => isFront = !isFront);
    await ctrl?.dispose();
    await _startCamera();
  }

  @override
  void dispose() { ctrl?.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: Text(widget.roomName, style: const TextStyle(fontSize: 14)), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))),
      body: Stack(
        children: [
          if (ctrl != null && ctrl!.value.isInitialized)
            SizedBox.expand(child: FittedBox(fit: BoxFit.cover, child: SizedBox(width: ctrl!.value.previewSize!.height, height: ctrl!.value.previewSize!.width, child: CameraPreview(ctrl!))))
          else Container(color: Colors.black, child: const Center(child: CircularProgressIndicator(color: Colors.pink))),
          Positioned(top: 10, left: 10, right: 10, child: Wrap(spacing: 6, runSpacing: 6, children: List.generate(8, (i) => GestureDetector(onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gift ${i+1} bheja'))), child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(6)), child: Text('Gift ${i+1}', style: const TextStyle(color: Colors.white, fontSize: 11))))))),
          Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.all(8), child: Row(children: [
            const Expanded(child: TextField(style: TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'Say Hi...', hintStyle: TextStyle(color: Colors.white54), border: InputBorder.none))),
            IconButton(icon: Icon(isFront ? Icons.camera_rear : Icons.camera_front, color: Colors.white), onPressed: _switchCamera),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), onPressed: () {}, child: const Text('Go LIVE')),
          ]))),
        ],
      ),
    );
  }
}

class PrivatePage extends StatelessWidget { const PrivatePage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Private 1v1 Room', style: TextStyle(color: Colors.white)))); }
class FamilyPage extends StatelessWidget { const FamilyPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Family Room 4 Seats', style: TextStyle(color: Colors.white)))); }
class VideoPage extends StatelessWidget { const VideoPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Video Feed', style: TextStyle(color: Colors.white)))); }
class MessengerPage extends StatelessWidget { const MessengerPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Messenger', style: TextStyle(color: Colors.white)))); }
class GamesPage extends StatelessWidget { const GamesPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Games', style: TextStyle(color: Colors.white)))); }
class WalletPage extends StatelessWidget { const WalletPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Wallet', style: TextStyle(color: Colors.white)))); }
class ProfilePage extends StatelessWidget { const ProfilePage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Profile', style: TextStyle(color: Colors.white)))); }