import 'package:flutter/material.dart';

const int ZEGO_APP_ID = 1238213223;
const String ZEGO_APP_SIGN = "3cfba1ba4c90747bdd4e393935381fa216178c528dc70e558fa70fafde0fce9f";

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
  RassGift(id: "1", name: "Kiss", price: 10, emoji: "Kiss", color: Colors.pink),
  RassGift(id: "2", name: "Rose", price: 10, emoji: "Rose", color: Colors.red),
  RassGift(id: "3", name: "Applause", price: 30, emoji: "Clap", color: Colors.amber),
  RassGift(id: "4", name: "Lollipop", price: 50, emoji: "Lolli", color: Colors.purple),
  RassGift(id: "5", name: "Party Popper", price: 30, emoji: "Party", color: Colors.orange),
  RassGift(id: "6", name: "New Star", price: 100, emoji: "Star", color: Colors.yellow),
  RassGift(id: "7", name: "Solo", price: 150, emoji: "Mic", color: Colors.cyan),
  RassGift(id: "8", name: "Broom", price: 180, emoji: "Broom", color: Colors.brown),
  RassGift(id: "9", name: "Candy", price: 200, emoji: "Candy", color: Colors.pinkAccent),
  RassGift(id: "10", name: "Skull", price: 500, emoji: "Skull", color: Colors.white),
  RassGift(id: "11", name: "Lucky Box", price: 800, emoji: "Gift", color: Colors.green),
  RassGift(id: "12", name: "Fan Light", price: 100, emoji: "Light", color: Colors.yellow),
  RassGift(id: "13", name: "Cellphone", price: 200, emoji: "Phone", color: Colors.blue),
  RassGift(id: "14", name: "Hand Mirror", price: 300, emoji: "Mirror", color: Colors.pink),
  RassGift(id: "15", name: "Candy Star", price: 400, emoji: "CStar", color: Colors.purple),
  RassGift(id: "16", name: "Sparks", price: 500, emoji: "Spark", color: Colors.amber),
  RassGift(id: "17", name: "Wishing", price: 600, emoji: "Wish", color: Colors.cyan),
  RassGift(id: "18", name: "Gem Handbag", price: 800, emoji: "Bag", color: Colors.pink),
  RassGift(id: "19", name: "Medusa", price: 1000, emoji: "Snake", color: Colors.green),
  RassGift(id: "20", name: "Rose Route", price: 1200, emoji: "Route", color: Colors.red),
  RassGift(id: "21", name: "Hot Balloon", price: 1500, emoji: "Balloon", color: Colors.orange),
  RassGift(id: "22", name: "Wind Chime", price: 2000, emoji: "Chime", color: Colors.blue),
  RassGift(id: "23", name: "Rocking Horse", price: 2500, emoji: "Horse", color: Colors.brown),
  RassGift(id: "24", name: "Lily Valley", price: 3000, emoji: "Lily", color: Colors.pink, isBest: true),
  RassGift(id: "25", name: "Qatar Jet", price: 5000, emoji: "Jet", color: Colors.white, isBest: true),
  RassGift(id: "26", name: "Bumper Car", price: 8000, emoji: "Car", color: Colors.red),
  RassGift(id: "27", name: "Cloudy Wings", price: 10000, emoji: "Wings", color: Colors.white, isBest: true),
  RassGift(id: "28", name: "Wind Girl", price: 12000, emoji: "WindGirl", color: Colors.cyan, isBest: true),
  RassGift(id: "29", name: "Sleeping Beauty", price: 18000, emoji: "Beauty", color: Colors.pink, isBest: true),
  RassGift(id: "30", name: "Star Prince", price: 18000, emoji: "Prince", color: Colors.amber, isBest: true),
  RassGift(id: "31", name: "Rainbow", price: 25000, emoji: "Rainbow", color: Colors.purple, isBest: true),
  RassGift(id: "32", name: "Back Massage", price: 20000, emoji: "Massage", color: Colors.orange, isBest: true),
  RassGift(id: "33", name: "Donkey", price: 36000, emoji: "Donkey", color: Colors.brown, isBest: true),
  RassGift(id: "34", name: "Rose Afternoon", price: 38000, emoji: "Afternoon", color: Colors.redAccent, isBest: true),
  RassGift(id: "35", name: "Cloud Pavilion", price: 40000, emoji: "Pavilion", color: Colors.blueGrey, isBest: true),
  RassGift(id: "36", name: "Pirate Booty", price: 45000, emoji: "Booty", color: Colors.brown, isBest: true),
  RassGift(id: "37", name: "Coaster", price: 48000, emoji: "Coaster", color: Colors.blue, isBest: true),
  RassGift(id: "38", name: "Wishing Well", price: 50000, emoji: "Well", color: Colors.cyan, isBest: true),
  RassGift(id: "39", name: "Past Fountain", price: 52000, emoji: "Fountain", color: Colors.blueAccent, isBest: true),
  RassGift(id: "40", name: "Camel King", price: 60000, emoji: "Camel", color: Colors.amber, isBest: true),
  RassGift(id: "41", name: "Pirate Ship", price: 80000, emoji: "Ship", color: Colors.black, isBest: true),
  RassGift(id: "42", name: "Magic Castle", price: 100000, emoji: "Castle", color: Colors.purple, isBest: true),
  RassGift(id: "43", name: "Shark Sub", price: 100000, emoji: "Shark", color: Colors.blue, isBest: true),
  RassGift(id: "44", name: "Motor Gear", price: 100000, emoji: "Bike", color: Colors.black, isBest: true),
  RassGift(id: "45", name: "Diamond Rainbow", price: 120000, emoji: "DRainbow", color: Colors.cyan, isBest: true),
  RassGift(id: "46", name: "Phoenix", price: 150000, emoji: "Phoenix", color: Colors.orange, isBest: true),
  RassGift(id: "47", name: "Dragon King", price: 200000, emoji: "Dragon", color: Colors.red, isBest: true),
  RassGift(id: "48", name: "RASS Universe", price: 300000, emoji: "Universe", color: Colors.deepPurple, isBest: true),
  RassGift(id: "49", name: "RASS Legendary", price: 500000, emoji: "Legend", color: Colors.amberAccent, isBest: true),
  RassGift(id: "50", name: "RASS GOD", price: 1000000, emoji: "GOD", color: Colors.amber, isBest: true),
  RassGift(id: "51", name: "Heart Crown", price: 10, emoji: "Heart", color: Colors.pinkAccent),
  RassGift(id: "52", name: "Beer", price: 20, emoji: "Beer", color: Colors.amber),
  RassGift(id: "53", name: "Ice Cream", price: 80, emoji: "IceCream", color: Colors.cyan),
  RassGift(id: "54", name: "Coffee", price: 120, emoji: "Coffee", color: Colors.brown),
  RassGift(id: "55", name: "Butterfly", price: 250, emoji: "Butter", color: Colors.purple),
  RassGift(id: "56", name: "Fire", price: 350, emoji: "Fire", color: Colors.orange),
  RassGift(id: "57", name: "Unicorn", price: 700, emoji: "Uni", color: Colors.pink),
  RassGift(id: "58", name: "Crown", price: 900, emoji: "Crown", color: Colors.amber),
  RassGift(id: "59", name: "Diamond", price: 1100, emoji: "Diamond", color: Colors.cyan),
  RassGift(id: "60", name: "Rocket", price: 1800, emoji: "Rocket", color: Colors.blue),
  RassGift(id: "61", name: "Lion King", price: 2200, emoji: "Lion", color: Colors.orange, isBest: true),
  RassGift(id: "62", name: "Golden Rose", price: 2800, emoji: "GRose", color: Colors.amber, isBest: true),
  RassGift(id: "63", name: "Sports Car", price: 9000, emoji: "SportCar", color: Colors.red, isBest: true),
  RassGift(id: "64", name: "Yacht", price: 11000, emoji: "Yacht", color: Colors.blue, isBest: true),
  RassGift(id: "65", name: "Helicopter", price: 13000, emoji: "Heli", color: Colors.green, isBest: true),
  RassGift(id: "66", name: "Private Jet", price: 16000, emoji: "PJet", color: Colors.white, isBest: true),
  RassGift(id: "67", name: "Castle", price: 35000, emoji: "Castle2", color: Colors.purple, isBest: true),
  RassGift(id: "68", name: "Galaxy", price: 42000, emoji: "Galaxy", color: Colors.indigo, isBest: true),
  RassGift(id: "69", name: "Golden Eagle", price: 65000, emoji: "Eagle", color: Colors.amber, isBest: true),
  RassGift(id: "70", name: "Ocean King", price: 75000, emoji: "Ocean", color: Colors.blue, isBest: true),
  RassGift(id: "71", name: "Tiger King", price: 90000, emoji: "Tiger", color: Colors.orange, isBest: true),
  RassGift(id: "72", name: "Diamond Throne", price: 110000, emoji: "Throne", color: Colors.cyan, isBest: true),
  RassGift(id: "73", name: "Volcano", price: 130000, emoji: "Volcano", color: Colors.red, isBest: true),
  RassGift(id: "74", name: "Aurora", price: 160000, emoji: "Aurora", color: Colors.purple, isBest: true),
  RassGift(id: "75", name: "Titan", price: 180000, emoji: "Titan", color: Colors.black, isBest: true),
  RassGift(id: "76", name: "Mermaid Queen", price: 250000, emoji: "Mermaid", color: Colors.cyan, isBest: true),
  RassGift(id: "77", name: "Galaxy Throne", price: 400000, emoji: "GThrone", color: Colors.indigo, isBest: true),
  RassGift(id: "78", name: "RASS SUPREME", price: 750000, emoji: "Supreme", color: Colors.amber, isBest: true),
  RassGift(id: "79", name: "RASS ETERNAL", price: 1000000, emoji: "Eternal", color: Colors.pinkAccent, isBest: true),
  RassGift(id: "80", name: "RASS INFINITY", price: 1000000, emoji: "Infinity", color: Colors.amberAccent, isBest: true),
];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

class RoomData {
  final String name;
  final String emoji;
  final int viewers;
  final int score;
  RoomData(this.name, this.emoji, this.viewers, this.score);
}

final rooms = [
  RoomData("Rass World", "W", 1257, 100),
  RoomData("Queen Live", "Q", 892, 85),
  RoomData("Rass PK Arena", "P", 543, 70),
  RoomData("9 Stars Multi", "S", 321, 60),
  RoomData("Voice Live", "V", 210, 50),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int bottomIndex = 0;
  final List<Widget> tabs = [
    RoomListScreen(),
    PrivateRoomScreen(),
    FamilyRoomScreen(),
    VideoFeedScreen(),
    MessengerScreen(),
    GamesScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  Widget _tab(IconData ic, String lb, int i) {
    bool s = bottomIndex == i;
    return GestureDetector(
      onTap: () => setState(() => bottomIndex = i),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: s ? const Color(0x33FF4081) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(ic, size: 20, color: s ? Colors.pinkAccent : Colors.white54),
            const SizedBox(height: 2),
            Text(lb, style: TextStyle(fontSize: 8, color: s ? Colors.pinkAccent : Colors.white54)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: tabs[bottomIndex],
      bottomNavigationBar: Container(
        height: 62,
        color: const Color(0xFF0F0F0F),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _tab(Icons.live_tv, "RassLive", 0),
              _tab(Icons.lock, "Private", 1),
              _tab(Icons.people, "Family", 2),
              _tab(Icons.video_library, "Video", 3),
              _tab(Icons.message, "Messen", 4),
              _tab(Icons.gamepad, "Games", 5),
              _tab(Icons.wallet, "Wallet", 6),
              _tab(Icons.person, "Profile", 7),
            ],
          ),
        ),
      ),
    );
  }
}

class RoomListScreen extends StatelessWidget {
  RoomListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: const [
                Text("RASS LIVE - Score", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 16)),
                Spacer(),
                Icon(Icons.live_tv, color: Colors.pink, size: 18),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(alignment: Alignment.centerLeft, child: Text("PK King: Ali Khan", style: TextStyle(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.bold))),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: rooms.length,
              itemBuilder: (c, i) {
                final r = rooms[i];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LiveRoomScreen(room: r))),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: const Color(0xFF1a1a1a), borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 18, backgroundColor: Colors.pink, child: Text("${i + 1}", style: const TextStyle(fontSize: 11))),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(r.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              Text("Viewers: ${r.viewers} | Score: ${r.score}", style: const TextStyle(color: Colors.white54, fontSize: 9)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(5)),
                          child: Text("${r.score}", style: const TextStyle(color: Colors.amber, fontSize: 10)),
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

class PrivateRoomScreen extends StatelessWidget {
  PrivateRoomScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Private 1V1 - Sound ON", style: TextStyle(color: Colors.white)));
  }
}

class FamilyRoomScreen extends StatelessWidget {
  FamilyRoomScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      children: List.generate(4, (i) => Container(margin: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFF1a1a1a), borderRadius: BorderRadius.circular(10)), child: Center(child: Text(i == 0 ? "Host" : "Invite", style: const TextStyle(color: Colors.white, fontSize: 12))))),
    );
  }
}

class VideoFeedScreen extends StatelessWidget {
  VideoFeedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Video Feed", style: TextStyle(color: Colors.white)));
  }
}

class MessengerScreen extends StatelessWidget {
  MessengerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: const [
        ListTile(leading: CircleAvatar(radius: 14, child: Text("P", style: TextStyle(fontSize: 10))), title: Text("PKArena_Official", style: TextStyle(color: Colors.white, fontSize: 12)), subtitle: Text("Gift sound best", style: TextStyle(color: Colors.white54, fontSize: 10))),
        ListTile(leading: CircleAvatar(radius: 14, child: Text("Q", style: TextStyle(fontSize: 10))), title: Text("Queen Live", style: TextStyle(color: Colors.white, fontSize: 12)), subtitle: Text("PK karoge?", style: TextStyle(color: Colors.white54, fontSize: 10))),
      ],
    );
  }
}

class GamesScreen extends StatelessWidget {
  GamesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(10),
      children: const [
        Card(color: Color(0xFF1a1a1a), child: Center(child: Text("PK Battle", style: TextStyle(color: Colors.white, fontSize: 11)))),
        Card(color: Color(0xFF1a1a1a), child: Center(child: Text("Ludo", style: TextStyle(color: Colors.white, fontSize: 11)))),
        Card(color: Color(0xFF1a1a1a), child: Center(child: Text("Card", style: TextStyle(color: Colors.white, fontSize: 11)))),
        Card(color: Color(0xFF1a1a1a), child: Center(child: Text("Football", style: TextStyle(color: Colors.white, fontSize: 11)))),
      ],
    );
  }
}

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("5,000 Coins", style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
          Text("~ \$99.50 USD", style: TextStyle(color: Colors.white54, fontSize: 11)),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 30, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 30)),
          SizedBox(height: 6),
          Text("Rass Jigar @rass_jigar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          Text("Host Mode ON - 1250 Diamonds", style: TextStyle(color: Colors.white54, fontSize: 10)),
        ],
      ),
    );
  }
}

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
  bool isLive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF2a1a4a), Colors.black])),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.white, size: 18)),
                        CircleAvatar(radius: 14, backgroundColor: Colors.pink, child: Text(widget.room.name[0], style: const TextStyle(fontSize: 10))),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.room.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                            Text("ID: ${widget.room.viewers}", style: const TextStyle(fontSize: 8, color: Colors.white70)),
                          ],
                        ),
                        const Spacer(),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)), child: Text(isLive ? "LIVE" : "No PK", style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold))),
                        const SizedBox(width: 4),
                        Text("${myScore}", style: const TextStyle(color: Colors.amber, fontSize: 10)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.all(14),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white24)),
                    child: Column(
                      children: [
                        Icon(isLive ? Icons.videocam : Icons.videocam_off, size: 28, color: isLive ? Colors.green : Colors.grey),
                        const SizedBox(height: 6),
                        Text(isLive ? "LIVE - ${widget.room.name}" : "Camera OFF", textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 9)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () => setState(() => isLive = !isLive),
                      style: ElevatedButton.styleFrom(backgroundColor: isLive ? Colors.red : Colors.blue, minimumSize: const Size(double.infinity, 36)),
                      child: Text(isLive ? "END LIVE" : "Go LIVE", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ),
                  const SizedBox(height: 300),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.46,
            minChildSize: 0.32,
            maxChildSize: 0.82,
            builder: (context, sc) {
              return Container(
                decoration: const BoxDecoration(color: Color(0xFF1c1c1e), borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Container(width: 28, height: 3, decoration: BoxDecoration(color: const Color(0xFF666666), borderRadius: BorderRadius.circular(2))),
                    const SizedBox(height: 5),
                    Expanded(
                      child: GridView.builder(
                        controller: sc,
                        padding: const EdgeInsets.all(5),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 0.70),
                        itemCount: rassGifts.length,
                        itemBuilder: (c, i) {
                          final g = rassGifts[i];
                          final isSel = selected?.id == g.id;
                          return GestureDetector(
                            onTap: () => setState(() => selected = g),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSel ? const Color(0xFF4a3a00) : const Color(0xFF2c2c2e),
                                borderRadius: BorderRadius.circular(6),
                                border: isSel ? Border.all(color: Colors.amber, width: 1) : null,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(g.emoji, style: TextStyle(fontSize: g.isBest ? 10 : 9, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 1),
                                  Text(g.name, style: const TextStyle(fontSize: 5, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 2),
                                  Text("${g.price}", style: const TextStyle(fontSize: 5, color: Colors.amber)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Color(0xFF121212), border: Border(top: BorderSide(color: Colors.white12))),
                      child: Row(
                        children: [
                          Row(
                            children: [1, 5, 10, 20].map((n) => GestureDetector(onTap: () => setState(() => count = n), child: Container(margin: const EdgeInsets.only(right: 3), width: 24, height: 22, decoration: BoxDecoration(color: count == n ? Colors.white : const Color(0xFF333333), borderRadius: BorderRadius.circular(4)), child: Center(child: Text("$n", style: TextStyle(fontSize: 9, color: count == n ? Colors.black : Colors.white, fontWeight: FontWeight.bold)))))).toList(),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (selected != null) {
                                setState(() => myScore += selected!.price * count);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${selected!.emoji} ${selected!.name} x$count Sent!"), backgroundColor: selected!.color, duration: const Duration(milliseconds: 700)));
                              }
                            },
                            child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(14)), child: const Text("Send", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 11))),
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
