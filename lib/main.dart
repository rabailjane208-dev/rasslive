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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const MainNav(),
    );
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

class RassLiveScorePage extends StatefulWidget {
  const RassLiveScorePage({super.key});
  @override
  State<RassLiveScorePage> createState() => _RassLiveScorePageState();
}

class _RassLiveScorePageState extends State<RassLiveScorePage> {
  List<Map<String, dynamic>> rooms = [
    {'name': 'Rass World 🌍', 'v': 1257, 's': 100, 'num': '1'},
    {'name': 'Queen Live 👑', 'v': 892, 's': 85, 'num': '2'},
    {'name': 'Rass PK Arena', 'v': 543, 's': 70, 'num': '3'},
    {'name': '9 Stars Multi ⭐', 'v': 321, 's': 60, 'num': '4'},
    {'name': 'Voice Live 🔒', 'v': 210, 's': 50, 'num': '5'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('RASS LIVE - Score', style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.groups, size: 14, color: Colors.yellow),
                    const SizedBox(width: 4),
                    Text('PK King: Ali Khan', style: TextStyle(color: Colors.yellow.shade600, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (c, i) {
                final r = rooms[i];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    onTap: () {
                      if (r['name'].toString().contains('Voice')) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const VoiceLivePage()));
                      } else if (r['name'].toString().contains('9 Stars') || r['name'].toString().contains('Queen')) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => NineStarsPage(roomName: r['name'])));
                      } else if (r['name'].toString().contains('PK Arena')) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const PKBattlePage()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => LiveRoom(roomName: r['name'])));
                      }
                    },
                    leading: CircleAvatar(backgroundColor: Colors.pink, child: Text(r['num'], style: const TextStyle(color: Colors.white))),
                    title: Text(r['name'], style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                    subtitle: Text('Viewers: ${r['v']} | Score: ${r['s']}', style: const TextStyle(color: Colors.white54, fontSize: 11)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(onTap: () => setState(() => r['s']++), child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.green.shade900, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.arrow_upward, size: 12, color: Colors.white))),
                            const SizedBox(height: 4),
                            InkWell(onTap: () => setState(() => r['s']--), child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.brown.shade700, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.arrow_downward, size: 12, color: Colors.white))),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.orange.shade700, borderRadius: BorderRadius.circular(6)), child: Text('${r['s']}', style: const TextStyle(fontSize: 12))),
                        const SizedBox(width: 6),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)), child: const Text('Live', style: TextStyle(fontSize: 8))),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.emoji_events, size: 14, color: Colors.yellow),
                const SizedBox(width: 4),
                const Text('Live Legend: Queen Live', style: TextStyle(color: Colors.yellow, fontSize: 12)),
              ],
            ),
          ),
          Container(height: 30, color: Colors.black, child: const Center(child: Text('Live band - Camera OFF', style: TextStyle(color: Colors.white54, fontSize: 10)))),
        ],
      ),
    );
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
  bool isLive = false;

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
          else Container(color: Colors.black, child: const Center(child: Text('LIVE - Rass World Camera - Mask: None\nSTREAMING LIVE\nTAP Go LIVE TO START', textAlign: TextAlign.center, style: TextStyle(color: Colors.white38)))),
          Positioned(top: 10, left: 10, right: 10, child: Wrap(spacing: 6, runSpacing: 6, children: List.generate(8, (i) => GestureDetector(onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gift ${i+1} bheja - Coins +10 - Wallet Me Gaya'))), child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(6)), child: Text('Gift ${i+1}', style: const TextStyle(color: Colors.white, fontSize: 11))))))),
          Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.all(8), child: Column(
            children: [
              Row(children: [const Icon(Icons.people, size: 12, color: Colors.white54), const SizedBox(width: 4), const Text('Ali Khan 1.2M  Sara 860K  Zain 540K', style: TextStyle(color: Colors.white54, fontSize: 10)), const Spacer(), Text(isFront ? 'Front' : 'Back', style: const TextStyle(color: Colors.white30, fontSize: 10))]),
              const SizedBox(height: 6),
              Row(children: [
                const Expanded(child: TextField(style: TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'Say Hi in RassLive...', hintStyle: TextStyle(color: Colors.white54), border: InputBorder.none))),
                IconButton(icon: Icon(isFront ? Icons.camera_rear : Icons.camera_front, color: Colors.white), onPressed: _switchCamera),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), onPressed: () {}, child: const Text('Go LIVE', style: TextStyle(fontSize: 12))),
              ]),
            ],
          ))),
        ],
      ),
    );
  }
}

class PrivatePage extends StatelessWidget {
  const PrivatePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(12), child: Row(children: [Expanded(child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.pink)), child: const Column(children: [Icon(Icons.person, color: Colors.white), SizedBox(height: 4), Text('Host', style: TextStyle(color: Colors.white, fontSize: 12))]))), const SizedBox(width: 12), Expanded(child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)), child: const Column(children: [Icon(Icons.person_add, color: Colors.white54), SizedBox(height: 4), Text('Waiting Request', style: TextStyle(color: Colors.white54, fontSize: 12))])))])),
          Container(margin: const EdgeInsets.symmetric(horizontal: 12), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)), child: const Row(children: [Icon(Icons.play_arrow, size: 16, color: Colors.white54), SizedBox(width: 6), Text('Pehle Go LIVE karo (Lock)', style: TextStyle(color: Colors.white54, fontSize: 12))])),
          const Spacer(),
          Padding(padding: const EdgeInsets.all(12), child: Row(children: [IconButton(icon: const Icon(Icons.videocam, color: Colors.white54), onPressed: (){}), IconButton(icon: const Icon(Icons.mic, color: Colors.white54), onPressed: (){}), IconButton(icon: const Icon(Icons.add, color: Colors.white54), onPressed: (){}), const Icon(Icons.diamond, size: 16, color: Colors.orange), const Text(' 0', style: TextStyle(color: Colors.white)), const Spacer(), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), onPressed: (){}, child: const Text('Go LIVE'))])),
          Container(padding: const EdgeInsets.all(10), color: const Color(0xFF121212), child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: const [Column(children: [Icon(Icons.chair, size: 16, color: Colors.white54), Text('Seats', style: TextStyle(fontSize: 8, color: Colors.white54))]), Column(children: [Icon(Icons.color_lens, size: 16, color: Colors.white54), Text('Theme', style: TextStyle(fontSize: 8, color: Colors.white54))]), Column(children: [Icon(Icons.face, size: 16, color: Colors.white54), Text('Beauty', style: TextStyle(fontSize: 8, color: Colors.white54))]), Column(children: [Icon(Icons.auto_awesome, size: 16, color: Colors.white54), Text('Magic', style: TextStyle(fontSize: 8, color: Colors.white54))]), Column(children: [Icon(Icons.card_giftcard, size: 16, color: Colors.white54), Text('Gift', style: TextStyle(fontSize: 8, color: Colors.white54))]), Column(children: [Icon(Icons.score, size: 16, color: Colors.white54), Text('SCORE', style: TextStyle(fontSize: 8, color: Colors.white54))])])),
        ],
      ),
    );
  }
}

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8), child: Row(children: [const Icon(Icons.family_restroom, size: 16, color: Colors.pink), const SizedBox(width: 6), Text('Family Room 4', style: const TextStyle(color: Colors.white70, fontSize: 12))])),
          Expanded(
            child: GridView.count(crossAxisCount: 2, childAspectRatio: 1.2, padding: const EdgeInsets.all(8), children: [
              _hostBox('Host', true),
              _inviteBox(),
              _inviteBox(),
              _inviteBox(),
            ]),
          ),
          Padding(padding: const EdgeInsets.all(8), child: Row(children: [IconButton(icon: const Icon(Icons.mic, color: Colors.white54), onPressed: (){}), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), onPressed: (){}, child: const Text('Go LIVE', style: TextStyle(fontSize: 12))), const SizedBox(width: 8), Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.purple), onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Guest_32 ne join request bheji'))); }, child: const Text('Request Bhejo Test', style: TextStyle(fontSize: 10))))])),
        ],
      ),
    );
  }
  Widget _hostBox(String t, bool isHost) => Container(margin: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.pink)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const CircleAvatar(backgroundColor: Colors.pink, child: Icon(Icons.person, color: Colors.white)), const SizedBox(height: 6), Text(t, style: const TextStyle(color: Colors.white, fontSize: 12))]));
  Widget _inviteBox() => Container(margin: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.person_add, color: Colors.white24), const SizedBox(height: 6), const Text('Invite 🔒', style: TextStyle(color: Colors.white24, fontSize: 12))]));
}

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Row(children: [const Text('RassLive Videos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(12)), child: const Text('Go LIVE', style: TextStyle(fontSize: 10)))]),
          const SizedBox(height: 6),
          const Text('Top Creator: Sara', style: TextStyle(color: Colors.white54, fontSize: 10)),
          const SizedBox(height: 12),
          Container(height: 300, decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: const Center(child: Text('Video Feed 🎬 - RassLive\nTAP Go LIVE TO START', textAlign: TextAlign.center, style: TextStyle(color: Colors.white38)))),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: const [Column(children: [Icon(Icons.favorite, color: Colors.red, size: 20), Text('12500', style: TextStyle(color: Colors.white, fontSize: 10))]), Column(children: [Icon(Icons.comment, color: Colors.white, size: 20), Text('2100', style: TextStyle(color: Colors.white, fontSize: 10))]), Column(children: [Icon(Icons.card_giftcard, color: Colors.yellow, size: 20), Text('96', style: TextStyle(color: Colors.white, fontSize: 10))]), Column(children: [Icon(Icons.share, color: Colors.white, size: 20), Text('480', style: TextStyle(color: Colors.white, fontSize: 10))])]),
          const SizedBox(height: 10),
          const ListTile(leading: CircleAvatar(backgroundColor: Colors.pink, child: Text('P', style: TextStyle(fontSize: 12))), title: Text('@PKArena_Official  Follow', style: TextStyle(color: Colors.white, fontSize: 12)), subtitle: Text('Beach wala Heart Dil ❤️ #rasslive #pkarena\nSay something...', style: TextStyle(color: Colors.white54, fontSize: 11))),
        ],
      ),
    );
  }
}

class MessengerPage extends StatelessWidget {
  const MessengerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(12), child: Row(children: [const Text('Messenger', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)), const Spacer(), const Icon(Icons.diamond, size: 14, color: Colors.orange), const Text(' 5000', style: TextStyle(color: Colors.white, fontSize: 12)), const SizedBox(width: 12), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(6)), child: const Text('Recharge', style: TextStyle(fontSize: 10)))])),
          Row(children: [Expanded(child: Container(margin: const EdgeInsets.only(left: 12), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.pink.shade900, borderRadius: BorderRadius.circular(8)), child: const Row(children: [Icon(Icons.chat, size: 14, color: Colors.white), SizedBox(width: 6), Text('Chats', style: TextStyle(color: Colors.white, fontSize: 12)), Spacer(), Text('Host', style: TextStyle(color: Colors.white54, fontSize: 10)), Icon(Icons.monetization_on, size: 12, color: Colors.yellow), Text(' 5000 Coins', style: TextStyle(color: Colors.white54, fontSize: 10))]))), const SizedBox(width: 8), Expanded(child: Container(margin: const EdgeInsets.only(right: 12), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)), child: const Row(children: [Icon(Icons.person_add, size: 14, color: Colors.white54), SizedBox(width: 6), Text('Requests', style: TextStyle(color: Colors.white54, fontSize: 12)), Spacer(), Text('Recharge', style: TextStyle(color: Colors.white54, fontSize: 10))])))]),
          const SizedBox(height: 10),
          Expanded(child: ListView(children: const [
            ListTile(leading: CircleAvatar(backgroundColor: Colors.orange, child: Icon(Icons.person, size: 16)), title: Text('PKArena_Officia l', style: TextStyle(color: Colors.white, fontSize: 13)), subtitle: Text('Beach wala Heart...', style: TextStyle(color: Colors.white54, fontSize: 11)), trailing: Icon(Icons.favorite, color: Colors.red, size: 14)),
            ListTile(leading: CircleAvatar(backgroundColor: Colors.purple, child: Icon(Icons.person, size: 16)), title: Text('Queen Live', style: TextStyle(color: Colors.white, fontSize: 13)), subtitle: Text('PK karoge?', style: TextStyle(color: Colors.white54, fontSize: 11)), trailing: Text('12500', style: TextStyle(color: Colors.white54, fontSize: 10))),
            ListTile(leading: CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.person, size: 16)), title: Text('Rass World', style: TextStyle(color: Colors.white, fontSize: 13)), subtitle: Text('Score 100', style: TextStyle(color: Colors.white54, fontSize: 11)), trailing: Icon(Icons.play_circle, color: Colors.red, size: 16)),
          ])),
        ],
      ),
    );
  }
}

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(12), child: Row(children: [const Text('Games', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const Spacer(), const Text('Game Master: Zain', style: TextStyle(color: Colors.white54, fontSize: 10)), const SizedBox(width: 8), const Icon(Icons.diamond, size: 12, color: Colors.orange), const Text(' 5000 Coins', style: TextStyle(color: Colors.white, fontSize: 10)), const SizedBox(width: 6), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(4)), child: const Text('Recharge', style: TextStyle(fontSize: 8)))])),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Row(children: [ _cat('All', true), _cat('Casual', false), _cat('Card', false), _cat('Battle', false)])),
          const SizedBox(height: 8),
          Expanded(child: GridView.count(crossAxisCount: 2, padding: const EdgeInsets.all(8), children: [
            _gameCard('PK Battle', '71 Games Inside', Icons.sports_kabaddi),
            _gameCard('Ludo', '6 Games Inside', Icons.casino),
            _gameCard('Card', '10 Games Inside', Icons.style),
            _gameCard('Football', '9 Games Inside', Icons.sports_soccer),
          ])),
        ],
      ),
    );
  }
  Widget _cat(String t, bool sel) => Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: sel ? Colors.pink : Colors.white10, borderRadius: BorderRadius.circular(20)), child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 10)));
  Widget _gameCard(String title, String sub, IconData icon) => Container(margin: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: Colors.white70, size: 30), const SizedBox(height: 8), Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)), Text(sub, style: const TextStyle(color: Colors.white54, fontSize: 8)), const SizedBox(height: 4), const Text('Entry 50 Win 90\nGift Marzi\nWinner 90% Wallet', textAlign: TextAlign.center, style: TextStyle(color: Colors.white24, fontSize: 7))])),
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('RASS WORLD WALLET', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          Row(children: [ _walletTab('Coins', true), _walletTab('Diamonds', false), _walletTab('History', false)]),
          const SizedBox(height: 12),
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFF3A2E00), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.orange)), child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.monetization_on, color: Colors.yellow, size: 30), const SizedBox(width: 8), const Text('5,000', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)), const SizedBox(width: 8), const Text('Coins', style: TextStyle(color: Colors.white70))]), const Text('~ \$39.60 USD', style: TextStyle(color: Colors.white54)), const SizedBox(height: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)), child: const Text('Recharge Available in 193 Countries', style: TextStyle(color: Colors.yellow, fontSize: 10)))])),
          const SizedBox(height: 12),
          _infoRow('Country', 'United States 🇺🇸'),
          _infoRow('Currency', 'USD (1 USD = 1.0)'),
          _infoRow('Gateway', 'Stripe (175 countries)'),
          const SizedBox(height: 12),
          const Text('Top Up Packs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _pack('100', '\$1.99 USD'),
          _pack('330', '\$5.97 USD'),
          const SizedBox(height: 12),
          Container(width: double.infinity, padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(8)), child: const Center(child: Text('Recharge - 195 Mulk PKR/SAR/AED/USD - Stripe + JazzCash + Easypaisa', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
        ],
      ),
    );
  }
  Widget _walletTab(String t, bool sel) => Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: sel ? Colors.pink : Colors.white10, borderRadius: BorderRadius.circular(20)), child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 12)));
  Widget _infoRow(String k, String v) => Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(8)), child: Row(children: [Text(k, style: const TextStyle(color: Colors.white54, fontSize: 12)), const Spacer(), Text(v, style: const TextStyle(color: Colors.white, fontSize: 12))])),
  Widget _pack(String c, String p) => Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(8)), child: Row(children: [const Icon(Icons.monetization_on, color: Colors.yellow, size: 18), const SizedBox(width: 8), Text(c, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)), const Spacer(), Text(p, style: const TextStyle(color: Colors.white54, fontSize: 12))])),
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  bool hostMode = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [const Text('Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const Spacer(), Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))]),
          const SizedBox(height: 6),
          Row(children: [ _pTab('Overview', true), _pTab('Social', false), _pTab('Activity', false), _pTab('Stats', false)]),
          const SizedBox(height: 20),
          Center(child: Column(children: [const CircleAvatar(radius: 40, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 40, color: Colors.white)), const SizedBox(height: 8), const Text('Rass Jigar', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const Text('@rass_jigar', style: TextStyle(color: Colors.white54, fontSize: 12))])),
          const SizedBox(height: 20),
          SwitchListTile(value: hostMode, onChanged: (v) => setState(() => hostMode = v), title: const Text('Host Mode', style: TextStyle(color: Colors.white, fontSize: 14)), subtitle: const Text('Live jaane ke liye ON karo', style: TextStyle(color: Colors.white54, fontSize: 10)), activeColor: Colors.pink),
          ListTile(leading: const Icon(Icons.diamond, color: Colors.pink), title: const Text('My Diamonds', style: TextStyle(color: Colors.white, fontSize: 14)), trailing: Row(mainAxisSize: MainAxisSize.min, children: [const Text('1256', style: TextStyle(color: Colors.white)), const SizedBox(width: 6), const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white54)]), onTap: (){}),
          ListTile(leading: const Icon(Icons.card_giftcard, color: Colors.orange), title: const Text('Gift History', style: TextStyle(color: Colors.white, fontSize: 14)), trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white54), onTap: (){}),
          ListTile(leading: const Icon(Icons.settings, color: Colors.white54), title: const Text('Settings', style: TextStyle(color: Colors.white, fontSize: 14)), trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white54), onTap: (){}),
          ListTile(leading: const Icon(Icons.logout, color: Colors.red), title: const Text('Logout', style: TextStyle(color: Colors.red, fontSize: 14)), onTap: (){}),
          const SizedBox(height: 10),
          const Text('Level 8 1250/2000 XP\nMy Diamonds 1250 | My Videos 12\n287 Likes | 38K Views | 168 Comments | Live History | Beauty HD', style: TextStyle(color: Colors.white54, fontSize: 11)),
        ],
      ),
    );
  }
  Widget _pTab(String t, bool sel) => Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: sel ? Colors.pink : Colors.transparent, borderRadius: BorderRadius.circular(6), border: Border.all(color: sel ? Colors.pink : Colors.white10)), child: Text(t, style: TextStyle(color: sel ? Colors.white : Colors.white54, fontSize: 10)));
}

class VoiceLivePage extends StatelessWidget {
  const VoiceLivePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text('Voice Live 🔒', style: TextStyle(fontSize: 14)), actions: [Container(margin: const EdgeInsets.all(8), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(4)), child: const Text('210 👁️', style: TextStyle(fontSize: 10)))]),
      body: Column(
        children: [
          Container(margin: const EdgeInsets.all(12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Row(children: [const CircleAvatar(backgroundColor: Colors.pink, radius: 24, child: Icon(Icons.mic, color: Colors.white)), const SizedBox(width: 12), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('210 log sun rahe hain', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), SizedBox(height: 2), Text('Public Room - Camera ki zarurat nahi', style: TextStyle(color: Colors.white54, fontSize: 10))])), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)), child: const Text('LIVE', style: TextStyle(fontSize: 10)))])),
          const Padding(padding: EdgeInsets.all(12), child: Align(alignment: Alignment.centerLeft, child: Text('Live Comments (Public)', style: TextStyle(color: Colors.white54, fontSize: 12)))),
          Expanded(child: ListView(padding: const EdgeInsets.all(12), children: const [
            ListTile(leading: CircleAvatar(radius: 10, child: Text('Z', style: TextStyle(fontSize: 8))), title: Text('Zain: Kya baat hai!', style: TextStyle(color: Colors.white, fontSize: 12)), subtitle: Text('14:42', style: TextStyle(color: Colors.white24, fontSize: 8))),
            ListTile(leading: CircleAvatar(radius: 10, child: Text('A', style: TextStyle(fontSize: 8))), title: Text('Ali Khan: Hi sab log', style: TextStyle(color: Colors.white, fontSize: 12)), subtitle: Text('14:42', style: TextStyle(color: Colors.white24, fontSize: 8))),
            ListTile(leading: CircleAvatar(radius: 10, child: Text('S', style: TextStyle(fontSize: 8))), title: Text('Sara: Voice Live mast hai', style: TextStyle(color: Colors.white, fontSize: 12)), subtitle: Text('14:42', style: TextStyle(color: Colors.white24, fontSize: 8))),
          ])),
          Container(padding: const EdgeInsets.all(8), color: const Color(0xFF121212), child: Row(children: [const Expanded(child: TextField(style: TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'Say Hi in RassLive...', hintStyle: TextStyle(color: Colors.white54), border: InputBorder.none))), IconButton(icon: const Icon(Icons.send, color: Colors.pink), onPressed: (){}), const Icon(Icons.emoji_emotions, color: Colors.yellow), const SizedBox(width: 8), const Icon(Icons.card_giftcard, color: Colors.orange)])),
          Container(padding: const EdgeInsets.all(8), child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, minimumSize: const Size(double.infinity, 40)), onPressed: (){}, child: const Text('Go LIVE in RassLive'))),
        ],
      ),
    );
  }
}

class NineStarsPage extends StatelessWidget {
  final String roomName;
  const NineStarsPage({super.key, required this.roomName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple.shade900, title: Text('$roomName - No PK - For Live', style: const TextStyle(fontSize: 12)), actions: [Container(margin: const EdgeInsets.all(8), padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)), child: const Text('2400 Watching  Rank #12', style: TextStyle(fontSize: 8)))]),
      body: Column(
        children: [
          Container(padding: const EdgeInsets.all(12), color: const Color(0xFF1E1E1E), child: Row(children: [const CircleAvatar(backgroundColor: Colors.blue, child: Text('R')), const SizedBox(width: 8), const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Rass World', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)), Text('K600  4.6K', style: TextStyle(color: Colors.white54, fontSize: 8))]), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(12)), child: const Text('Follow', style: TextStyle(fontSize: 10)))])),
          Expanded(child: Container(color: Colors.black, child: const Center(child: Text('LIVE - Rass World Camera - Mask: None\nSTREAMING LIVE\nTAP Go LIVE TO START', textAlign: TextAlign.center, style: TextStyle(color: Colors.white24, fontSize: 12))))),
          Container(padding: const EdgeInsets.all(8), color: const Color(0xFF121212), child: Row(children: const [Icon(Icons.emoji_events, size: 12, color: Colors.yellow), SizedBox(width: 4), Text('Ali Khan 1.2M', style: TextStyle(color: Colors.white, fontSize: 10)), SizedBox(width: 12), Text('Sara 860K', style: TextStyle(color: Colors.white54, fontSize: 10)), SizedBox(width: 12), Text('Zain 540K', style: TextStyle(color: Colors.white54, fontSize: 10))])),
          Container(padding: const EdgeInsets.all(8), child: Row(children: [const Expanded(child: TextField(style: TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'Say Hi in RassLive...', hintStyle: TextStyle(color: Colors.white54), border: InputBorder.none))), IconButton(icon: const Icon(Icons.send, color: Colors.pink), onPressed: (){})])),
        ],
      ),
    );
  }
}

class PKBattlePage extends StatefulWidget {
  const PKBattlePage({super.key});
  @override
  State<PKBattlePage> createState() => _PKBattlePageState();
}
class _PKBattlePageState extends State<PKBattlePage> {
  int timer = 134;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text('Live ... PRIVATE...', style: TextStyle(fontSize: 12)), actions: [Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)), child: const Text('Pot: 128  PK 84...', style: TextStyle(fontSize: 8)))]),
      body: Column(
        children: [
          Container(padding: const EdgeInsets.all(8), color: const Color(0xFF1E1E1E), child: Row(children: [Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.purple.shade700, borderRadius: BorderRadius.circular(12)), child: const Column(children: [Text('LEAGUE MATCH  WIN x0  WIN x1', style: TextStyle(color: Colors.white54, fontSize: 8)), SizedBox(height: 8), Text('4,864', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 4), Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(4)), child: Text('LEAD +2k', style: TextStyle(color: Colors.black, fontSize: 8)))]))), const SizedBox(width: 8), Column(children: [Text('${timer ~/ 60}:${(timer % 60).toString().padLeft(2, '0')}', style: const TextStyle(color: Colors.white, fontSize: 12)), const SizedBox(height: 4), const Text('VS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(color: Colors.yellow, shape: BoxShape.circle), child: const Icon(Icons.bolt, size: 12, color: Colors.black))]), const SizedBox(width: 8), Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.blue.shade900, borderRadius: BorderRadius.circular(12)), child: const Column(children: [Text('LEAGUE MATCH', style: TextStyle(color: Colors.white54, fontSize: 8)), SizedBox(height: 8), Text('2,784', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))])))])),
          Padding(padding: const EdgeInsets.all(12), child: Row(children: [Expanded(child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.pets, color: Colors.white54), SizedBox(width: 4), Text('Olivia - 62%', style: TextStyle(color: Colors.white, fontSize: 10))]), const SizedBox(height: 4), LinearProgressIndicator(value: 0.62, backgroundColor: Colors.white10, color: Colors.purple)])), const SizedBox(width: 12), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(20)), child: const Text('PK', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12))), const SizedBox(width: 12), Expanded(child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.pets, color: Colors.white54), SizedBox(width: 4), Text('Ethan - 38%', style: TextStyle(color: Colors.white, fontSize: 10))]), const SizedBox(height: 4), LinearProgressIndicator(value: 0.38, backgroundColor: Colors.white10, color: Colors.blue)]))])),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Row(children: [Expanded(child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)), child: const Row(children: [Icon(Icons.people, size: 12, color: Colors.white54), SizedBox(width: 4), Text('Ali Khan 12.300', style: TextStyle(color: Colors.white, fontSize: 8))]))), const SizedBox(width: 6), Expanded(child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)), child: const Row(children: [Icon(Icons.people, size: 12, color: Colors.white54), SizedBox(width: 4), Text('Sara 9.850', style: TextStyle(color: Colors.white, fontSize: 8))]))), const SizedBox(width: 6), Expanded(child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)), child: const Row(children: [Icon(Icons.people, size: 12, color: Colors.white54), SizedBox(width: 4), Text('Zain 7.4', style: TextStyle(color: Colors.white, fontSize: 8))])))])),
          const Spacer(),
          Container(margin: const EdgeInsets.all(12), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)), child: const Row(children: [Text('Sara: Ethan ka glass bhardo', style: TextStyle(color: Colors.white, fontSize: 10)), Spacer(), Text('x3 GIFTING POINTS | 6s', style: TextStyle(color: Colors.yellow, fontSize: 8))])),
          Container(padding: const EdgeInsets.all(8), color: const Color(0xFF121212), child: Row(children: [const Expanded(child: TextField(style: TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'Say somethin...', hintStyle: TextStyle(color: Colors.white54), border: InputBorder.none))), Container(margin: const EdgeInsets.only(right: 4), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)), child: const Text('Gift', style: TextStyle(color: Colors.white, fontSize: 10)))])),
        ],
      ),
    );
  }
}