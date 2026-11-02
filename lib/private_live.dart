import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class PrivateLiveScreen extends StatefulWidget {
  final String roomID;
  final bool isHost;
  const PrivateLiveScreen({super.key, required this.roomID, this.isHost = true});

  @override
  State<PrivateLiveScreen> createState() => _PrivateLiveScreenState();
}

class _PrivateLiveScreenState extends State<PrivateLiveScreen> {
  CameraController? ctrl;
  bool ready = false;
  bool isFront = true;
  List<Map<String, dynamic>> filters = [
    {"name": "None", "icon": "🚫", "emoji": ""},
    {"name": "Dog", "icon": "🐶", "emoji": "🐶"},
    {"name": "Glasses", "icon": "😎", "emoji": "😎"},
    {"name": "Crown", "icon": "👑", "emoji": "👑"},
    {"name": "Heart", "icon": "❤️", "emoji": "❤️"},
    {"name": "Devil", "icon": "😈", "emoji": "😈"},
    {"name": "Clown", "icon": "🤡", "emoji": "🤡"},
  ];
  int selectedFilter = 0;
  final TextEditingController commentController = TextEditingController();
  List<String> comments = [];
  int likeCount = 0;
  int walletBalance = 0;
  bool micOn = true;
  bool beauty = true;

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
    commentController.dispose();
    super.dispose();
  }

  void sendComment() {
    if (commentController.text.trim().isNotEmpty) {
      setState(() {
        comments.insert(0, "Jigar: ${commentController.text.trim()}");
        commentController.clear();
      });
    }
  }

  void addLike() => setState(() => likeCount++);
  void sendGift(int coins) => setState(() => walletBalance += coins);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Positioned.fill(
          child: ready && ctrl != null && ctrl!.value.isInitialized
              ? FittedBox(fit: BoxFit.cover, child: SizedBox(width: ctrl!.value.previewSize!.width, height: ctrl!.value.previewSize!.height, child: CameraPreview(ctrl!)))
              : const Center(child: CircularProgressIndicator(color: Colors.pink)),
        ),
        Positioned(top: 40, left: 10, right: 10, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
          const Text("Private 1v1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          IconButton(icon: const Icon(Icons.cameraswitch, color: Colors.white), onPressed: () => setState(() => isFront = !isFront)),
        ])),
        Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.symmetric(vertical: 15), child: Column(children: [
          SizedBox(height: 80, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: filters.length, itemBuilder: (ctx, i) {
            final isSelected = i == selectedFilter;
            return GestureDetector(onTap: () => setState(() => selectedFilter = i), child: Container(margin: const EdgeInsets.symmetric(horizontal: 8), width: 60, decoration: BoxDecoration(color: isSelected ? Colors.pink : Colors.white24, shape: BoxShape.circle, border: Border.all(color: isSelected ? Colors.white : Colors.transparent, width: 2)), child: Center(child: Text(filters[i]["icon"], style: const TextStyle(fontSize: 30)))));
          })),
          const SizedBox(height: 10),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Row(children: [
            Expanded(child: TextField(controller: commentController, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: "Comment...", hintStyle: const TextStyle(color: Colors.white54), border: OutlineInputBorder()), onSubmitted: (_) => sendComment())),
            const SizedBox(width: 10),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), onPressed: () {}, child: const Text("gift")),
            const SizedBox(width: 10),
            IconButton(icon: const Icon(Icons.call_end, color: Colors.red, size: 35), onPressed: () => Navigator.pop(context)),
          ])),
        ]))),
      ]),
    );
  }
}