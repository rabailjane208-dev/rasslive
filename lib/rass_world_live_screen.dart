import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class RassWorldLiveScreen extends StatefulWidget {
  const RassWorldLiveScreen({super.key});
  @override
  State<RassWorldLiveScreen> createState() => _RassWorldLiveScreenState();
}

class GiftItem {
  final String name;
  final int price;
  final String emoji;
  const GiftItem(this.name, this.price, this.emoji);
}

class _RassWorldLiveScreenState extends State<RassWorldLiveScreen> {
  CameraController? _cam;
  bool _camReady = false;
  int viewers = 1257;
  int score = 100;
  int coins = 0;
  int selectedTab = 0;
  int qty = 1;
  GiftItem? selected;

  final tabs = const ["New", "Gift", "Lucky", "Fan Club", "Surprise"];

  final newGifts = const [
    GiftItem("Kiss", 15, "💋"), GiftItem("Rose", 15, "🌹"), GiftItem("Applause", 30, "👏"),
    GiftItem("Lollipop", 60, "🍭"), GiftItem("Party Popper", 90, "🎉"), GiftItem("New Star", 100, "⭐"),
    GiftItem("Solo", 100, "🎤"), GiftItem("Broom", 100, "🧹"), GiftItem("Candy", 200, "🍬"),
    GiftItem("Skull", 300, "💀"), GiftItem("Lucky Box", 200, "🎁"), GiftItem("Fan Light", 150, "💡"),
  ];

  final giftGifts = const [
    GiftItem("Pop Pass", 1000, "🎟️"), GiftItem("Fan Light Board", 1000, "🎆"), GiftItem("Heart Charger", 1500, "💖"),
    GiftItem("Blue Rose", 1500, "🌹"), GiftItem("Ha Ha Ha", 1500, "😂"), GiftItem("Frosty", 1500, "☃️"),
    GiftItem("I'm Here", 1500, "👋"), GiftItem("Face Palm", 1500, "🤦"), GiftItem("Back Massage", 25000, "💆"),
    GiftItem("Donkey", 30000, "🐴"), GiftItem("Rose Afternoon", 40000, "🌹"), GiftItem("Cloud Pavilion", 80000, "☁️"),
    GiftItem("Camel Knight", 90000, "🐪"), GiftItem("Romantic Ride", 90000, "🎠"), GiftItem("Marry Me", 100000, "💍"),
    GiftItem("Pirate Booty", 100000, "🏴‍☠️"), GiftItem("Cottage Coffee", 150000, "☕"), GiftItem("Castle", 200000, "🏰"),
    GiftItem("Sports Car", 500000, "🏎️"),
  ];

  final luckyGifts = const [
    GiftItem("Swan", 1000, "🦢"), GiftItem("Grace", 2000, "👑"), GiftItem("Cherry", 250, "🍒"),
    GiftItem("Lucky Star", 500, "🌟"), GiftItem("Bubble Gun", 800, "🔫"), GiftItem("Crystal Shoes", 1200, "👠"),
  ];

  final fanGifts = const [
    GiftItem("Sleeping Beauty", 36000, "👸"), GiftItem("Starving Prince", 38000, "🤴"), GiftItem("Rainbow", 28000, "🌈"),
  ];

  final surpriseGifts = const [
    GiftItem("Magic Book", 150000, "📖"), GiftItem("Wind Chime", 120000, "🎐"), GiftItem("Rocking Horse", 120000, "🐴"),
    GiftItem("Lily Of Jackson", 80000, "🌸"), GiftItem("Bumper Car", 100000, "🚗"),
  ];

  List<GiftItem> get currentGifts {
    switch (selectedTab) {
      case 0:
        return newGifts;
      case 1:
        return giftGifts;
      case 2:
        return luckyGifts;
      case 3:
        return fanGifts;
      case 4:
        return surpriseGifts;
      default:
        return newGifts;
    }
  }

  @override
  void initState() {
    super.initState();
    _initCam();
  }

  Future<void> _initCam() async {
    try {
      await Permission.camera.request();
      await Permission.microphone.request();
      final cams = await availableCameras();
      if (cams.isNotEmpty) {
        _cam = CameraController(cams.firstWhere((c) => c.lensDirection == CameraLensDirection.front, orElse: () => cams[0]), ResolutionPreset.medium);
        await _cam!.initialize();
        if (mounted) setState(() => _camReady = true);
      }
    } catch (e) {
      debugPrint("cam: $e");
    }
  }

  @override
  void dispose() {
    _cam?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(child: _camReady && _cam != null && _cam!.value.isInitialized ? CameraPreview(_cam!) : const Center(child: CircularProgressIndicator(color: Colors.pink))),
          SafeArea(
            child: Column(
              children: [
                // Top bar
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const Text("Rass World LIVE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(width: 8),
                      _pill("👥 $viewers"),
                      const SizedBox(width: 6),
                      _pill("🏆 $score"),
                      const SizedBox(width: 6),
                      _pill("ID 1257"),
                      const Spacer(),
                      _pill("14:00"),
                      const SizedBox(width: 6),
                      _pill("🔋44%"),
                    ],
                  ),
                ),
                const Spacer(),
                // Right side buttons
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _roundBtn(Icons.face, "Beauty"),
                          _roundBtn(Icons.flip_camera_ios, "Flip"),
                          _roundBtn(Icons.mic, "Mic"),
                          _roundBtn(Icons.people, "Viewers"),
                          _roundBtn(Icons.card_giftcard, "Gift"),
                          _roundBtn(Icons.share, "Share"),
                          _roundBtn(Icons.more_horiz, "More"),
                        ],
                      ),
                    ),
                  ),
                ),
                // Chat
                SizedBox(
                  height: 160,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    children: const [
                      _ChatBubble(text: "MR SALMAN OFFICIAL: hii", color: Colors.green),
                      _ChatBubble(text: "CHEE MRAZ: Hiii", color: Colors.yellow),
                      _ChatBubble(text: "Arsoo6199: Hi Dear!", color: Colors.pink),
                      _ChatBubble(text: "Me: wc to bente boaad", color: Colors.cyan),
                      _ChatBubble(text: "fhed joined 🇦🇪", color: Colors.white70),
                    ],
                  ),
                ),
                // Comment input
                Container(
                  height: 36,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: const [
                      Icon(Icons.emoji_emotions, color: Colors.white54, size: 18),
                      SizedBox(width: 6),
                      Expanded(child: Text("Comment... wc to bente boaad", style: TextStyle(color: Colors.white38, fontSize: 12))),
                      Icon(Icons.send, color: Colors.white54, size: 18),
                    ],
                  ),
                ),
                // Gift shop
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      // Tabs
                      SizedBox(
                        height: 36,
                        child: Row(
                          children: List.generate(tabs.length, (i) => Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => selectedTab = i),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selectedTab == i ? Colors.pink : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(tabs[i], style: TextStyle(color: selectedTab == i ? Colors.white : Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )),
                        ),
                      ),
                      // Qty row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            ...[1, 10, 50].map((n) => GestureDetector(
                              onTap: () => setState(() => qty = n),
                              child: Container(
                                margin: const EdgeInsets.only(right: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: qty == n ? Colors.white : Colors.white12, borderRadius: BorderRadius.circular(8)),
                                child: Text("$n", style: TextStyle(color: qty == n ? Colors.black : Colors.white, fontSize: 11)),
                              ),
                            )),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                if (selected != null) {
                                  setState(() => coins += selected!.price * qty);
                                }
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                              child: const Text("Send"),
                            ),
                          ],
                        ),
                      ),
                      // Gift grid
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 0.90),
                          itemCount: currentGifts.length,
                          itemBuilder: (c, i) {
                            final g = currentGifts[i];
                            final isSel = selected?.name == g.name;
                            return GestureDetector(
                              onTap: () => setState(() => selected = g),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: isSel ? Colors.amber : Colors.white12),
                                ),
                                padding: const EdgeInsets.all(6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(g.emoji, style: const TextStyle(fontSize: 32)),
                                    const SizedBox(height: 2),
                                    Text(g.name, style: const TextStyle(color: Colors.white, fontSize: 9), textAlign: TextAlign.center, maxLines: 1),
                                    const SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.monetization_on, color: Colors.amber, size: 10),
                                        Text(" ${g.price}", style: const TextStyle(color: Colors.amber, fontSize: 10)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Bottom bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        color: Colors.black54,
                        child: Row(
                          children: [
                            const Text("Coin 0", style: TextStyle(color: Colors.amber, fontSize: 11)),
                            const SizedBox(width: 6),
                            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)), child: const Text("First Recharge", style: TextStyle(color: Colors.white, fontSize: 9))),
                            const Spacer(),
                            ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child: const Text("Go LIVE", style: TextStyle(fontSize: 11))),
                            const SizedBox(width: 6),
                            const Icon(Icons.favorite, color: Colors.red, size: 18),
                            Text(" 12500", style: const TextStyle(color: Colors.white54, fontSize: 10)),
                            const SizedBox(width: 6),
                            Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(color: Colors.pink, shape: BoxShape.circle), child: const Icon(Icons.card_giftcard, color: Colors.white, size: 16)),
                            const SizedBox(width: 6),
                            ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow), child: const Text("Follow+", style: TextStyle(color: Colors.black, fontSize: 10))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String t) => Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)), child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 10)));

  Widget _roundBtn(IconData icon, String label) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.pink, Colors.purple]), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.pink.withOpacity(0.4), blurRadius: 6)]),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 9)),
          ],
        ),
      );
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final Color color;
  const _ChatBubble({required this.text, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(color: color, fontSize: 11)),
    );
  }
}
