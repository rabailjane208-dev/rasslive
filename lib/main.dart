import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screens/live_room_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await [Permission.camera, Permission.microphone].request();
  runApp(const RassLiveApp());
}

class RassLiveApp extends StatelessWidget {
  const RassLiveApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RassLive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const MainNavScreen(),
    );
  }
}

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});
  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int currentIndex = 0;
  final String userID = "12345";
  final String userName = "Rass Jigar";
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      RassScoreScreen(userID: userID, userName: userName),
      const PrivateRoomScreen(),
      const FamilyRoomScreen(),
      const VideoScreen(),
      const MessengerScreen(),
      const GameScreen(),
      const WalletScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.white54,
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "Rass"),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Private"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Video"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messenger"),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: "Games"),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class RassScoreScreen extends StatelessWidget {
  final String userID;
  final String userName;
  const RassScoreScreen({super.key, required this.userID, required this.userName});
  @override
  Widget build(BuildContext context) {
    final rooms = [
      {"title": "Rass World", "roomID": "1", "viewers": "1257", "isPK": false},
      {"title": "Queen Live", "roomID": "2", "viewers": "892", "isPK": false},
      {"title": "Rass PK Arena", "roomID": "3", "viewers": "543", "isPK": true},
      {"title": "9 Stars Multi", "roomID": "4", "viewers": "321", "isPK": false},
      {"title": "Voice Live", "roomID": "5", "viewers": "210", "isPK": false},
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, title: const Text("RASS LIVE", style: TextStyle(color: Color(0xFFE91E63), fontWeight: FontWeight.bold))),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, i) {
          final r = rooms[i];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LiveRoomScreen(roomID: r["roomID"] as String, userID: userID, userName: userName, isPK: r["isPK"] as bool))),
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(14)),
              child: Row(children: [
                CircleAvatar(backgroundColor: const Color(0xFFE91E63), radius: 28, child: Text("${i + 1}", style: const TextStyle(color: Colors.white))),
                const SizedBox(width: 14),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r["title"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("Viewers: ${r["viewers"]}", style: const TextStyle(color: Colors.white54, fontSize: 12)),
                ]),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 14),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class PrivateRoomScreen extends StatelessWidget { const PrivateRoomScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Private Room", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Private Room", style: TextStyle(color: Colors.white)))); }
class FamilyRoomScreen extends StatelessWidget { const FamilyRoomScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Family Room", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Family Room", style: TextStyle(color: Colors.white)))); }
class VideoScreen extends StatelessWidget { const VideoScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Videos", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Videos", style: TextStyle(color: Colors.white)))); }
class MessengerScreen extends StatelessWidget { const MessengerScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Messenger", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Messenger", style: TextStyle(color: Colors.white)))); }
class GameScreen extends StatelessWidget { const GameScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Games", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Games", style: TextStyle(color: Colors.white)))); }
class WalletScreen extends StatelessWidget { const WalletScreen({super.key}); @override Widget build(BuildContext context) => const Scaffold(backgroundColor: Colors.black, body: Center(child: Text("Wallet", style: TextStyle(color: Colors.white)))); }
class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Profile", style: TextStyle(color: Colors.white))), body: const Center(child: Text("Profile", style: TextStyle(color: Colors.white)))); }