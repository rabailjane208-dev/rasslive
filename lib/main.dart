import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

const A = 1238213223;
List<CameraDescription> C = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await [Permission.camera, Permission.microphone].request();
    C = await availableCameras();
  } catch (_) {}
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark(), home: const Tabs());
}

class Tabs extends StatefulWidget {
  const Tabs({super.key});
  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int i = 0;
  final pages = [const R(), const P1(), const P2(), const P3(), const P4(), const P5(), const P6(), const P7()];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: pages[i.clamp(0, 7)],
    bottomNavigationBar: Container(
      color: Colors.black,
      height: 70,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: List.generate(8, (idx) {
          var icons = [Icons.live_tv, Icons.lock, Icons.group, Icons.video_library, Icons.message, Icons.extension, Icons.wallet, Icons.person];
          var labels = ["RassLive", "Private", "Family", "Video", "Mess.", "Games", "Wallet", "Profile"];
          bool sel = i == idx;
          return InkWell(
            onTap: () => setState(() => i = idx),
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8), child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(icons[idx], color: sel ? Colors.pink : Colors.white54),
              Text(labels[idx], style: TextStyle(fontSize: 10, color: sel ? Colors.pink : Colors.white54)),
            ])),
          );
        })),
      ),
    ),
  );
}

class R extends StatelessWidget {
  const R({super.key});
  @override
  Widget build(BuildContext context) {
    final list = [{"n": "Rass World 🌍", "t": "solo"}, {"n": "Queen Live 👑", "t": "queen"}, {"n": "Rass PK Arena ⚔️", "t": "pk"}, {"n": "9 Stars Multi ⭐", "t": "multi"}, {"n": "Voice Live 🎙️", "t": "voice"}];
    return Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("RASS LIVE - Score", style: TextStyle(color: Colors.red, fontSize: 14))), body: ListView.builder(itemCount: list.length, itemBuilder: (c, y) {
      var r = list[y];
      return ListTile(
        leading: CircleAvatar(backgroundColor: Colors.pink, child: Text("${y + 1}")),
        title: Text(r["n"] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        subtitle: Text("Viewers: ${[1257, 892, 543, 321, 210][y]} | Score: ${[100, 85, 70, 60, 50][y]}"),
        trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)), child: const Text("LIVE", style: TextStyle(fontSize: 8))),
        onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => D(room: r))),
      );
    }));
  }
}

class D extends StatefulWidget {
  final Map room;
  const D({super.key, required this.room});
  @override
  State<D> createState() => _DState();
}

class _DState extends State<D> {
  CameraController? cam;
  bool ok = false;
  bool front = true;

  @override
  void initState() {
    super.initState();
    _initCam();
  }

  Future<void> _initCam() async {
    try {
      if (C.isEmpty) {
        C = await availableCameras();
      }
      if (C.isNotEmpty) {
        cam = CameraController(C[0], ResolutionPreset.high, enableAudio: true);
        await cam!.initialize();
        if (mounted) setState(() => ok = true);
      }
    } catch (e) {
      debugPrint("cam: $e");
    }
  }

  @override
  void dispose() {
    cam?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Positioned.fill(child: ok && cam != null && cam!.value.isInitialized ? CameraPreview(cam!) : const Center(child: CircularProgressIndicator(color: Colors.pink))),
        Positioned(top: 40, left: 10, right: 10, child: Row(children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
          Text(widget.room["n"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const Spacer(),
          IconButton(icon: const Icon(Icons.cameraswitch, color: Colors.white), onPressed: () => setState(() => front = !front)),
        ])),
        Positioned(bottom: 10, left: 10, right: 10, child: Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
          child: Column(children: [
            Expanded(child: GridView.count(crossAxisCount: 4, children: List.generate(8, (i) => Container(margin: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)), child: Center(child: Text("Gift ${i + 1}", style: const TextStyle(color: Colors.white, fontSize: 10))))))),
            Row(children: [
              Expanded(child: TextField(style: const TextStyle(color: Colors.white), decoration: const InputDecoration(hintText: "Comment...", hintStyle: TextStyle(color: Colors.white54), border: InputBorder.none))),
              ElevatedButton(onPressed: () {}, child: const Text("Send")),
            ]),
          ]),
        )),
      ]),
    );
  }
}

class P1 extends StatelessWidget { const P1({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Private", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Private", style: TextStyle(color: Colors.white)))); }
class P2 extends StatelessWidget { const P2({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Family", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Family", style: TextStyle(color: Colors.white)))); }
class P3 extends StatelessWidget { const P3({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Video", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Video", style: TextStyle(color: Colors.white)))); }
class P4 extends StatelessWidget { const P4({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Messenger", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Messenger", style: TextStyle(color: Colors.white)))); }
class P5 extends StatelessWidget { const P5({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Games", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Games", style: TextStyle(color: Colors.white)))); }
class P6 extends StatelessWidget { const P6({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Wallet", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Wallet", style: TextStyle(color: Colors.white)))); }
class P7 extends StatelessWidget { const P7({super.key}); @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Profile", style: TextStyle(color: Colors.pink))), body: const Center(child: Text("Profile", style: TextStyle(color: Colors.white)))); }