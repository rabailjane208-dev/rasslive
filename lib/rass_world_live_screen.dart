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
  CameraController? ctrl;
  bool ready = false;
  String tab = "New";
  int qty = 1;
  int coins = 0;
  GiftItem? selected;
  String? toast;
  String? animEmoji;
  bool showAnim = false;

  final tabs = const ["Halloween", "New", "Gift", "Lucky", "Fan Club"];

  final halloweenGifts = const [
    GiftItem("Pumpkin", 50, "🎃"), GiftItem("Ghost", 80, "👻"), GiftItem("Bat", 60, "🦇"),
    GiftItem("Witch", 120, "🧙"), GiftItem("Skull", 300, "💀"), GiftItem("Candy", 200, "🍬"),
    GiftItem("Spider", 90, "🕷️"), GiftItem("Zombie", 150, "🧟"),
  ];

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

  List<GiftItem> get currentGifts {
    switch (tab) {
      case "Halloween":
        return halloweenGifts;
      case "New":
        return newGifts;
      case "Gift":
        return giftGifts;
      case "Lucky":
        return luckyGifts;
      case "Fan Club":
        return fanGifts;
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
      ctrl = CameraController(cams.isNotEmpty ? cams[cams.length > 1 ? 1 : 0] : cams[0], ResolutionPreset.medium, enableAudio: true);
      await ctrl!.initialize();
      if (mounted) setState(() => ready = true);
    } catch (e) {}
  }

  @override
  void dispose() {
    ctrl?.dispose();
    super.dispose();
  }

  void _sendGift(GiftItem g) {
    setState(() {
      coins += g.price * qty;
      toast = "You sent ${g.name} x$qty";
      // full screen animation for special gifts
      if (g.name == "Sports Car") {
        animEmoji = "🏎️";
        showAnim = true;
      } else if (g.name == "Castle") {
        animEmoji = "🐉";
        showAnim = true;
      } else if (g.name == "Pirate Booty") {
        animEmoji = "📦";
        showAnim = true;
      }
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => toast = null);
    });
    if (showAnim) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => showAnim = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera full screen
          Positioned.fill(
            child: ready && ctrl != null && ctrl!.value.isInitialized
                ? FittedBox(fit: BoxFit.cover, child: SizedBox(width: ctrl!.value.previewSize!.width, height: ctrl!.value.previewSize!.height, child: CameraPreview(ctrl!)))
                : const Center(child: CircularProgressIndicator(color: Colors.pink)),
          ),
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
                      const Text("Rass World LIVE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      const SizedBox(width: 8),
                      _pill("Viewers 1257"),
                      const SizedBox(width: 4),
                      _pill("Score 100"),
                      const SizedBox(width: 4),
                      _pill("Timer 03:06"),
                      const Spacer(),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)), child: const Text("WIN x3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                // x3 Gifting Points red bar center
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                    child: const Text("x3 Gifting Points", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ),
                const Spacer(),
                // Right side icons
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        _SideIcon(Icons.favorite, "Heart"),
                        _SideIcon(Icons.comment, "Comment"),
                        _SideIcon(Icons.share, "Share"),
                        _SideIcon(Icons.card_giftcard, "Gift"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Gift panel
                Container(
                  height: 360,
                  decoration: BoxDecoration(color: const Color(0xFF121212), borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: tabs.map((t) => GestureDetector(
                              onTap: () => setState(() => tab = t),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                decoration: BoxDecoration(color: tab == t ? Colors.pink : const Color(0xFF2A2A2A), borderRadius: BorderRadius.circular(20)),
                                child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                            )).toList(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 0.92),
                          itemCount: currentGifts.length,
                          itemBuilder: (_, i) {
                            final g = currentGifts[i];
                            final isSel = selected?.name == g.name;
                            return GestureDetector(
                              onTap: () => setState(() => selected = g),
                              child: Container(
                                decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(14), border: Border.all(color: isSel ? Colors.amber : Colors.white12)),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Text(g.emoji, style: const TextStyle(fontSize: 26)),
                                  const SizedBox(height: 4),
                                  Text(g.name, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w500), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 2),
                                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    const Icon(Icons.monetization_on, color: Colors.yellow, size: 10),
                                    const SizedBox(width: 2),
                                    Text("${g.price}", style: const TextStyle(color: Colors.yellow, fontSize: 9, fontWeight: FontWeight.bold)),
                                  ]),
                                ]),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
                        decoration: const BoxDecoration(color: Color(0xFF1A1A1A)),
                        child: Row(children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)), child: Text("$qty", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12))),
                          const SizedBox(width: 6),
                          ...[1, 10, 50].map((q) => GestureDetector(
                            onTap: () => setState(() => qty = q),
                            child: Container(margin: const EdgeInsets.only(right: 4), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: qty == q ? Colors.white : const Color(0xFF2A2A2A), borderRadius: BorderRadius.circular(8)), child: Text("$q", style: TextStyle(color: qty == q ? Colors.black : Colors.white, fontSize: 11))),
                          )),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              if (selected != null) _sendGift(selected!);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1976D2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10)),
                            child: const Text("Send", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Toast
          if (toast != null)
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
                  child: Text(toast!, style: const TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ),
          // Full screen animation
          if (showAnim && animEmoji != null)
            Positioned.fill(
              child: Center(
                child: Text(animEmoji!, style: const TextStyle(fontSize: 120)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _pill(String t) => Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)), child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 10)));

  void _sendGift(GiftItem g) {
    setState(() {
      coins += g.price * qty;
      toast = "You sent ${g.name} x$qty";
      if (g.name == "Sports Car" || g.name == "Castle" || g.name == "Pirate Booty") {
        animEmoji = g.name == "Sports Car" ? "🏎️" : g.name == "Castle" ? "🐉" : "📦";
        showAnim = true;
      }
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => toast = null);
    });
    if (showAnim) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => showAnim = false);
      });
    }
  }
}

class _SideIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SideIcon(this.icon, this.label);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(children: [
        Container(width: 40, height: 40, decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: Icon(icon, color: Colors.white, size: 20)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 9)),
      ]),
    );
  }
}