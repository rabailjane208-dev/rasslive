import 'package:flutter/material.dart';
import 'rass_world_live_screen.dart';
import 'rass_pk_arena_screen.dart';
import 'nine_stars_multi_screen.dart';
import 'queen_live_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MainNav()));
}

class MainNav extends StatefulWidget {
  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int idx = 0;
  final pages = [
    RassLiveScoreScreen(),
    Private1V1Room(),
    FamilyRoom(),
    VideoScreen(),
    MessengerScreen(),
    GameScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];
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
        onTap: (i) => setState(() => idx = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "Rass..."),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Priva..."),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Video"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Mess..."),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: "Gam..."),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class RassLiveScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {"t": "Rass World 🌍", "v": "1257", "s": "100", "w": const RassWorldLiveScreen()},
      {"t": "Queen Live 👑", "v": "892", "s": "85", "w": const QueenLiveScreen()},
      {"t": "Rass PK Arena", "v": "543", "s": "70", "w": const RassPkArenaScreen()},
      {"t": "9 Stars Multi ⭐", "v": "321", "s": "60", "w": const NineStarsMultiScreen()},
      {"t": "Voice Live 🎙️", "v": "210", "s": "50", "w": const RassWorldLiveScreen()},
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, title: const Text("RASS LIVE - Score", style: TextStyle(color: Color(0xFFE91E63), fontWeight: FontWeight.bold))),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) {
          final it = items[i];
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => it["w"] as Widget)),
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(14)),
              child: Row(children: [
                CircleAvatar(backgroundColor: const Color(0xFFE91E63), radius: 28, child: Text("${i + 1}", style: const TextStyle(color: Colors.white))),
                const SizedBox(width: 14),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(it["t"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("Viewers: ${it["v"]} | Score: ${it["s"]}", style: const TextStyle(color: Colors.white54, fontSize: 12)),
                ]),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class Private1V1Room extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Private 1V1 Room", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Private 1V1 Room", style: TextStyle(color: Colors.white))));
  }
}

class FamilyRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Family Room - 4 Seats", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Family Room 4 Seats", style: TextStyle(color: Colors.white))));
  }
}

class VideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Past Live Videos", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Video", style: TextStyle(color: Colors.white))));
  }
}

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Messenger", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Messenger", style: TextStyle(color: Colors.white))));
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Games", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Games", style: TextStyle(color: Colors.white))));
  }
}

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.black, body: Center(child: Text("Wallet", style: TextStyle(color: Colors.white))));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Profile", style: TextStyle(color: Colors.white))), body: const Center(child: Text("Profile - Rass Jigar", style: TextStyle(color: Colors.white))));
  }
}