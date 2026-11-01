import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class LiveRoomScreen extends StatefulWidget {
  final String roomID;
  final String userID;
  final String userName;
  final bool isPK;
  const LiveRoomScreen({super.key, required this.roomID, required this.userID, required this.userName, this.isPK = false});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  CameraController? ctrl;
  bool ready = false;
  bool isFollowing = false;
  int viewers = 22400;
  bool isCameraFront = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: ready && ctrl != null && ctrl!.value.isInitialized
                ? FittedBox(fit: BoxFit.cover, child: SizedBox(width: ctrl!.value.previewSize!.width, height: ctrl!.value.previewSize!.height, child: CameraPreview(ctrl!)))
                : const Center(child: CircularProgressIndicator(color: Colors.pink)),
          ),
          Positioned(top: 40, left: 10, right: 10, child: _buildTopBar()),
          if (widget.isPK) Positioned(top: 90, left: 0, right: 0, child: _buildPKBar()),
          if (widget.isPK) Positioned(top: 140, left: 80, right: 80, child: _buildX3Bar()),
          Positioned(right: 8, top: 200, child: _buildRightButtons(context)),
          Positioned(left: 10, right: 10, bottom: 20, child: _buildBottomBar(context)),
          Positioned(left: 10, bottom: 70, right: 80, child: _buildComments()),
        ],
      ),
    );
  }

  Widget _buildTopBar() => Row(children: [
        const CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.person, color: Colors.white)),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text("$viewers watching", style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ]),
        const Spacer(),
        ElevatedButton(onPressed: () => setState(() => isFollowing = !isFollowing), style: ElevatedButton.styleFrom(backgroundColor: isFollowing ? Colors.grey : Colors.red, shape: const StadiumBorder()), child: Text(isFollowing ? "Following" : "Subscribe", style: const TextStyle(color: Colors.white))),
        IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ]);

  Widget _buildPKBar() => Container(color: Colors.black54, padding: const EdgeInsets.all(5), child: Row(children: [
        Expanded(child: Container(color: Colors.red, child: const Center(child: Text("752718", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))))),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text("VS 1:40", style: TextStyle(color: Colors.white))),
        Expanded(child: Container(color: Colors.blue, child: const Center(child: Text("338881", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))))),
      ]));

  Widget _buildX3Bar() => Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5), decoration: BoxDecoration(color: Colors.red.withOpacity(0.8), borderRadius: BorderRadius.circular(20)), child: const Center(child: Text("x3 Gifting Points 29s", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))));

  Widget _buildRightButtons(BuildContext context) => Column(children: [
        _iconBtn(Icons.favorite, "32K"),
        GestureDetector(onTap: () => setState(() => isCameraFront = !isCameraFront), child: _iconBtn(Icons.cameraswitch, "Flip")),
        _iconBtn(Icons.chat_bubble, "341"),
        _iconBtn(Icons.share, "Share"),
        GestureDetector(onTap: () => _showGiftPanel(context), child: Column(children: [
          Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Colors.pink, shape: BoxShape.circle), child: const Icon(Icons.card_giftcard, color: Colors.white, size: 26)),
          const Text("Gift", style: TextStyle(color: Colors.white, fontSize: 11)),
        ])),
      ]);

  Widget _iconBtn(IconData icon, String txt) => Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Column(children: [Icon(icon, color: Colors.white, size: 28), Text(txt, style: const TextStyle(color: Colors.white, fontSize: 12))]));

  Widget _buildBottomBar(BuildContext context) => Row(children: [
        const Expanded(child: TextField(decoration: InputDecoration(hintText: "Add comment...", hintStyle: TextStyle(color: Colors.white70), filled: true, fillColor: Colors.black45, border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide.none)), style: TextStyle(color: Colors.white))),
        const SizedBox(width: 10),
        GestureDetector(onTap: () => _showGiftPanel(context), child: Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Colors.pink, shape: BoxShape.circle), child: const Icon(Icons.card_giftcard, color: Colors.white))),
      ]);

  Widget _buildComments() => const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Nawab sent Lion", style: TextStyle(color: Colors.white, fontSize: 13)),
        Text("User sent Rose", style: TextStyle(color: Colors.white, fontSize: 13)),
      ]);

  void _showGiftPanel(BuildContext context) {
    showModalBottomSheet(context: context, backgroundColor: Colors.black87, isScrollControlled: true, builder: (context) {
      return SizedBox(height: MediaQuery.of(context).size.height * 0.55, child: DefaultTabController(length: 5, child: Column(children: [
        const TabBar(tabs: [Tab(text: "New"), Tab(text: "Gift"), Tab(text: "Lucky"), Tab(text: "PK"), Tab(text: "Hot")], labelColor: Colors.white, isScrollable: true),
        Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.8), itemCount: 100, itemBuilder: (context, index) => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.card_giftcard, color: Colors.white30, size: 30),
          const SizedBox(height: 4),
          Text("${(index + 1) * 10}", style: const TextStyle(color: Colors.white, fontSize: 11)),
        ]))),
        Container(padding: const EdgeInsets.all(8), color: Colors.grey[900], child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Recharge", style: TextStyle(color: Colors.yellow)),
          const Row(children: [Text("x1", style: TextStyle(color: Colors.white)), SizedBox(width: 10), Text("x10", style: TextStyle(color: Colors.white)), SizedBox(width: 10), Text("x50", style: TextStyle(color: Colors.white))]),
          ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), child: const Text("SEND")),
        ])),
      ])));
    });
  }
}