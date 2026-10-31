import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

List<CameraDescription> globalCameras = [];

class RassGift {
  final String id;
  final String name;
  final int price;
  final String emoji;
  final Color color;
  final bool isBest;
  const RassGift({required this.id, required this.name, required this.price, required this.emoji, required this.color, this.isBest = false});
}

final List<RassGift> rassGifts = [
  RassGift(id: "1", name: "Kiss", price: 10, emoji: "💋", color: Colors.pink),
  RassGift(id: "2", name: "Rose", price: 10, emoji: "🌹", color: Colors.red),
  RassGift(id: "3", name: "Applause", price: 30, emoji: "👏", color: Colors.amber),
  RassGift(id: "4", name: "Lollipop", price: 50, emoji: "🍭", color: Colors.purple),
  RassGift(id: "5", name: "Party Popper", price: 30, emoji: "🎉", color: Colors.orange),
  RassGift(id: "6", name: "New Star", price: 100, emoji: "🌟", color: Colors.yellow),
  RassGift(id: "7", name: "Solo", price: 150, emoji: "🎤", color: Colors.cyan),
  RassGift(id: "8", name: "Broom", price: 180, emoji: "🧹", color: Colors.brown),
  RassGift(id: "9", name: "Candy", price: 200, emoji: "🍬", color: Colors.pinkAccent),
  RassGift(id: "10", name: "Skull", price: 500, emoji: "💀", color: Colors.white),
  RassGift(id: "24", name: "Lily Valley", price: 3000, emoji: "🌸", color: Colors.pink, isBest: true),
  RassGift(id: "25", name: "Qatar Jet", price: 5000, emoji: "✈️", color: Colors.white, isBest: true),
  RassGift(id: "49", name: "RASS Legendary", price: 500000, emoji: "🐉🌌💎", color: Colors.amberAccent, isBest: true),
  RassGift(id: "50", name: "RASS GOD", price: 1000000, emoji: "👑🔥🌌", color: Colors.amber, isBest: true),
];

class RoomData {
  final String name;
  final String emoji;
  final int viewers;
  final int score;
  RoomData(this.name, this.emoji, this.viewers, this.score);
}

final rooms = [
  RoomData("Rass World", "🌍", 1257, 100),
  RoomData("Queen Live", "👑", 892, 85),
  RoomData("Rass PK Arena", "", 543, 70),
  RoomData("9 Stars Multi", "⭐", 321, 60),
  RoomData("Voice Live", "🎙️", 210, 50),
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await [Permission.camera, Permission.microphone].request();
    globalCameras = await availableCameras();
  } catch (e) {
    debugPrint("Camera init: $e");
  }
  runApp(const RassLiveApp());
}

class RassLiveApp extends StatelessWidget {
  const RassLiveApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RASS LIVE',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int bottomIndex = 0;
  final List<Widget> pages = const [
    RassLiveTab(),
    PrivateTab(),
    FamilyTab(),
    VideoTab(),
    MessengerTab(),
    GamesTab(),
    WalletTab(),
    ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[bottomIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0F0F0F),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        currentIndex: bottomIndex,
        onTap: (i) => setState(() => bottomIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "RassLive"),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Private"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Family"),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Video"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messen.."),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: "Games"),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// ---------- RASS LIVE TAB ----------
class RassLiveTab extends StatelessWidget {
  const RassLiveTab({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Text("RASS LIVE - Score", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 20)),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.live_tv, color: Colors.pink)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: rooms.length,
              itemBuilder: (c, i) {
                final r = rooms[i];
                return GestureDetector(
                  onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => LiveRoomScreen(room: r))),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFF1a1a1a), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 26, backgroundColor: Colors.pink, child: Text("${i + 1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${r.name} ${r.emoji}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              const SizedBox(height: 4),
                              Text("Viewers: ${r.viewers} | Score: ${r.score}", style: const TextStyle(color: Colors.white54, fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- LIVE ROOM ----------
class LiveRoomScreen extends StatefulWidget {
  final RoomData room;
  const LiveRoomScreen({super.key, required this.room});
  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  RassGift? selected;
  int count = 1;
  int myScore = 0;
  CameraController? _cameraController;
  bool _isCamInit = false;

  @override
  void initState() {
    super.initState();
    _initCameraSafe();
  }

  Future<void> _initCameraSafe() async {
    try {
      var status = await Permission.camera.request();
      await Permission.microphone.request();
      if (status.isDenied) return;
      if (globalCameras.isEmpty) globalCameras = await availableCameras();
      if (globalCameras.isNotEmpty) {
        _cameraController = CameraController(
          globalCameras.firstWhere((c) => c.lensDirection == CameraLensDirection.front, orElse: () => globalCameras[0]),
          ResolutionPreset.medium,
        );
        await _cameraController!.initialize();
        if (mounted) setState(() => _isCamInit = true);
      }
    } catch (e) {
      debugPrint("Camera 0000 Safe: $e");
    }
  }

  @override
  void dispose() {
    try {
      _cameraController?.dispose();
    } catch (e) {}
    super.dispose();
  }

  Widget _buildLiveView() {
    if (_isCamInit && _cameraController != null && _cameraController!.value.isInitialized) {
      return CameraPreview(_cameraController!);
    } else {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.pink),
            SizedBox(height: 12),
            Text("Camera Starting... Allow Permission", style: TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(width: double.infinity, height: double.infinity, child: _buildLiveView()),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                      Text(widget.room.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
                        child: Text("💎 $myScore", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.52,
            minChildSize: 0.4,
            maxChildSize: 0.85,
            builder: (context, sc) {
              return Container(
                decoration: const BoxDecoration(color: Color(0xFF1c1c1e), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        controller: sc,
                        padding: const EdgeInsets.all(8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 0.78),
                        itemCount: rassGifts.length,
                        itemBuilder: (c, i) {
                          final g = rassGifts[i];
                          final isSel = selected?.id == g.id;
                          return GestureDetector(
                            onTap: () => setState(() => selected = g),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSel ? Colors.amber.withOpacity(0.25) : const Color(0xFF2c2c2e),
                                borderRadius: BorderRadius.circular(10),
                                border: isSel ? Border.all(color: Colors.amber, width: 1.5) : (g.isBest ? Border.all(color: Colors.amber.withOpacity(0.6)) : null),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(g.emoji, style: TextStyle(fontSize: g.isBest ? 26 : 22)),
                                  Text(g.name, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 2),
                                  Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                                    child: Text("🪙 ${g.price}", style: TextStyle(fontSize: 7, color: Colors.amber[200], fontWeight: FontWeight.bold)),
                                  ),
                                  if (g.isBest)
                                    Container(
                                      margin: const EdgeInsets.only(top: 2),
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                      decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)),
                                      child: const Text("BEST", style: TextStyle(fontSize: 5, color: Colors.black, fontWeight: FontWeight.bold)),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: const BoxDecoration(color: Color(0xFF121212), border: Border(top: BorderSide(color: Colors.white12))),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [1, 10, 50].map((n) => GestureDetector(
                                onTap: () => setState(() => count = n),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  width: 30,
                                  height: 28,
                                  decoration: BoxDecoration(color: count == n ? Colors.white : Colors.white12, borderRadius: BorderRadius.circular(8)),
                                  child: Center(child: Text("$n", style: TextStyle(fontSize: 11, color: count == n ? Colors.black : Colors.white, fontWeight: FontWeight.bold))),
                                ),
                              )).toList(),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (selected != null) {
                                setState(() => myScore += selected!.price * count);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF00c6ff), Color(0xFF0072ff)]), borderRadius: BorderRadius.circular(20)),
                              child: const Text("Send", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------- PRIVATE TAB ----------
class PrivateTab extends StatelessWidget {
  const PrivateTab({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(12), child: Text("Private 1V1 Room", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 20))),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _card("Host", "Start a private 1V1 room", Icons.person),
                _card("Waiting Request", "No pending requests", Icons.hourglass_empty),
                _card("Go LIVE", "Start live streaming", Icons.live_tv),
                _card("Seats", "1 seat available", Icons.chair),
                _card("Theme", "Change room theme", Icons.palette),
                _card("Beauty", "Beauty filters", Icons.auto_fix_high),
                _card("Magic", "Magic effects", Icons.auto_awesome),
                _card("Gift", "Send gifts", Icons.card_giftcard),
                _card("Coins", "5000 coins", Icons.monetization_on),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- FAMILY TAB ----------
class FamilyTab extends StatefulWidget {
  const FamilyTab({super.key});
  @override
  State<FamilyTab> createState() => _FamilyTabState();
}

class _FamilyTabState extends State<FamilyTab> {
  final List<String> requests = ["User A", "User B"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(12), child: Text("Family Room - 4 Seats", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 20))),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(12),
              children: [
                _seat("Host", true),
                _seat("Invite 1", false),
                _seat("Invite 2", false),
                _seat("Invite 3", false),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(8), child: Text("Join Requests", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold))),
          Expanded(
            child: ListView.builder(
              itemCount: requests.length,
              itemBuilder: (c, i) => ListTile(
                title: Text(requests[i], style: const TextStyle(color: Colors.white)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: () => setState(() => requests.removeAt(i)), child: const Text("Approve", style: TextStyle(color: Colors.green))),
                    TextButton(onPressed: () => setState(() => requests.removeAt(i)), child: const Text("Reject", style: TextStyle(color: Colors.red))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- VIDEO TAB ----------
class VideoTab extends StatelessWidget {
  const VideoTab({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(12), child: Text("RassLive Videos", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 20))),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (c, i) => Card(
                color: const Color(0xFF1a1a1a),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: const Icon(Icons.play_circle, color: Colors.pink, size: 40),
                  title: Text("Video ${i + 1}", style: const TextStyle(color: Colors.white)),
                  subtitle: const Text("@PKArena_Official", style: TextStyle(color: Colors.white54)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.favorite, color: Colors.red, size: 18),
                      SizedBox(width: 4),
                      Text("120", style: TextStyle(color: Colors.white54, fontSize: 12)),
                      SizedBox(width: 8),
                      Icon(Icons.person_add, color: Colors.pink, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- MESSENGER TAB ----------
class MessengerTab extends StatelessWidget {
  const MessengerTab({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(12), child: Text("Messenger", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 20))),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: const [
                Text("Coins: 5000", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                Spacer(),
                Text("Recharge", style: TextStyle(color: Colors.pink)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (c, i) => ListTile(
                leading: CircleAvatar(backgroundColor: Colors.pink, child: Text("${i + 1}")),
                title: Text("Chat ${i + 1}", style: const TextStyle(color: Colors.white)),
                subtitle: const Text("Last message...", style: TextStyle(color: Colors.white54)),
                trailing: const Icon(Icons.chevron_right, color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- GAMES TAB ----------
class GamesTab extends StatelessWidget {
  const GamesTab({super.key});
  @override
  Widget build(BuildContext context) {
    final games = ["PK Battle", "Ludo", "Card", "Football", "Casual", "Battle"];
    return SafeArea(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(12), child: Text("Games", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 20))),
          Padding(padding: const EdgeInsets.all(8), child: Text("Game Master: Zain", style: const TextStyle(color: Colors.amber))),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(12),
              children: games.map((g) => Card(
                color: const Color(0xFF1a1a1a),
                child: Center(child: Text(g, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- WALLET TAB ----------
class WalletTab extends StatelessWidget {
  const WalletTab({super.key});
  @override
  Widget build(BuildContext context) {
    final packs = ["\$1.99", "\$5.97"];
    return SafeArea(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(12), child: Text("RASS WORLD WALLET", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 20))),
          Padding(padding: const EdgeInsets.all(8), child: Column(children: const [
            Text("Coins: 5000 = \$39.60", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
            Text("Diamonds: 1256", style: TextStyle(color: Colors.cyan)),
            Text("Country: United States (USD)", style: TextStyle(color: Colors.white54)),
            Text("Payment: Stripe", style: TextStyle(color: Colors.white54)),
          ])),
          const Padding(padding: EdgeInsets.all(8), child: Text("Top Up Packs", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold))),
          Expanded(
            child: ListView.builder(
              itemCount: packs.length,
              itemBuilder: (c, i) => ListTile(
                title: Text("Pack ${packs[i]}", style: const TextStyle(color: Colors.white)),
                trailing: ElevatedButton(onPressed: () {}, child: const Text("Buy")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- PROFILE TAB ----------
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(12), child: Text("Profile", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 20))),
          const CircleAvatar(radius: 40, backgroundColor: Colors.pink, child: Text("RJ", style: TextStyle(color: Colors.white, fontSize: 24))),
          const SizedBox(height: 8),
          const Text("Rass Jigar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          const Text("@rass_jigar", style: TextStyle(color: Colors.white54)),
          const SizedBox(height: 8),
          const Text("Host Mode: ON", style: TextStyle(color: Colors.green)),
          const Text("My Diamonds: 1256", style: TextStyle(color: Colors.cyan)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                ListTile(leading: const Icon(Icons.history, color: Colors.white), title: const Text("Gift History", style: TextStyle(color: Colors.white)), onTap: () {}),
                ListTile(leading: const Icon(Icons.settings, color: Colors.white), title: const Text("Settings", style: TextStyle(color: Colors.white)), onTap: () {}),
                ListTile(leading: const Icon(Icons.logout, color: Colors.red), title: const Text("Logout", style: TextStyle(color: Colors.red)), onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- HELPERS ----------
Widget _card(String title, String sub, IconData icon) {
  return Card(
    color: const Color(0xFF1a1a1a),
    margin: const EdgeInsets.only(bottom: 8),
    child: ListTile(
      leading: Icon(icon, color: Colors.pink),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(sub, style: const TextStyle(color: Colors.white54)),
    ),
  );
}

Widget _seat(String label, bool isHost) {
  return Card(
    color: const Color(0xFF1a1a1a),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isHost ? Icons.star : Icons.person_add, color: isHost ? Colors.amber : Colors.white54, size: 40),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}