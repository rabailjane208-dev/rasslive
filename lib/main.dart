// RASS LIVE - ONLY APP ID + APP SIGN - NO TRACKING - NO PERSONAL NUMBER
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

// ========= SIRF APP ID + APP SIGN =========
const int RASS_APP_ID = 1238213223;
const String RASS_APP_SIGN = "3cfba1ba4c90747bdd4e393935381fa216178c528dc70e558fa70fafde0fce9f";
// ============================================

List<CameraDescription> globalCameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await [Permission.camera, Permission.microphone].request();
  try { globalCameras = await availableCameras(); } catch(e){ globalCameras=[]; }
  runApp(const RassLiveFullApp());
}

class RassLiveFullApp extends StatelessWidget {
  const RassLiveFullApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'RASS LIVE', theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF0A0A0A)), home: const MainTabs());
  }
}
class MainTabs extends StatefulWidget { const MainTabs({super.key}); @override State<MainTabs> createState()=>_MainTabsState(); }
class _MainTabsState extends State<MainTabs> {
  int idx=0;
  final pages=[const RassScorePage(), const PrivateRoomPage(), const FamilyRoomPage(), const VideoFeedPage(), const MessengerPage(), const GamesPage(), const WalletPage(), const ProfilePage()];
  @override Widget build(BuildContext c){return Scaffold(body: pages[idx], bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.fixed, backgroundColor: Colors.black, selectedItemColor: const Color(0xFFFF2E63), unselectedItemColor: Colors.white54, currentIndex: idx, onTap: (v)=>setState(()=>idx=v), selectedFontSize: 9, unselectedFontSize: 8, items: const [BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "RassLive"), BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Private"), BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"), BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Video"), BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messeng."), BottomNavigationBarItem(icon: Icon(Icons.extension), label: "Games"), BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"), BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")],));}
}

class RassScorePage extends StatelessWidget {
  const RassScorePage({super.key});
  @override Widget build(BuildContext context){
    final rooms=[
      {"id":1, "name":"Rass World 🌍", "viewers":1257, "score":100, "type":"solo"},
      {"id":2, "name":"Queen Live 👑", "viewers":892, "score":85, "type":"queen"},
      {"id":3, "name":"Rass PK Arena", "viewers":543, "score":70, "type":"pk"},
      {"id":4, "name":"9 Stars Multi ⭐", "viewers":321, "score":60, "type":"multi"},
      {"id":5, "name":"Voice Live 🎙️", "viewers":210, "score":50, "type":"voice"},
    ];
    return Scaffold(backgroundColor: const Color(0xFF121212), appBar: AppBar(backgroundColor: Colors.black, title: const Text("RASS LIVE", style: TextStyle(color: Color(0xFFFF3B30), fontWeight: FontWeight.bold, fontSize: 14))),
      body: ListView.builder(itemCount: rooms.length, itemBuilder: (ctx,i){var r=rooms[i]; return GestureDetector(onTap: ()=> Navigator.push(ctx, MaterialPageRoute(builder: (_)=> LiveRoomDetail(room: r))), child: Container(margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Row(children: [CircleAvatar(radius: 24, backgroundColor: const Color(0xFFFF2E63), child: Text("${r["id"]}", style: const TextStyle(fontWeight: FontWeight.bold))), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(r["name"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text("Viewers: ${r["viewers"]} | Score: ${r["score"]}", style: const TextStyle(color: Colors.white54, fontSize: 10))]))]))); }),
    );
  }
}

class LiveRoomDetail extends StatefulWidget { final Map room; const LiveRoomDetail({super.key, required this.room}); @override State<LiveRoomDetail> createState()=>_LiveRoomDetailState(); }
class _LiveRoomDetailState extends State<LiveRoomDetail> with TickerProviderStateMixin {
  CameraController? cam; int camIdx=0; bool camReady=false; bool isHD=true; bool isBeauty=true; double beauty=0.7;
  late AnimationController giftAnim; Map? activeGift; bool showGift=false; bool showBeauty=false;
  String selectedTab="Gift";
  int myScore=4864, otherScore=2784;
  List<String> chats=["RASS LIVE Connected ✅", "Zain: Kya baat hai!", "Ali Khan: Hi sab log"];
  List<Map> allGifts=[];
  final tabs=["Halloween","New","Gift","Lucky","Fan Club","Surprise Shop"];

  @override void initState(){ super.initState(); giftAnim=AnimationController(vsync: this, duration: const Duration(seconds: 3)); _genGifts(); _initCam(); }
  void _genGifts(){
    List base=[{"n":"Party Popper","i":Icons.celebration,"c":Colors.yellow,"p":30},{"n":"Spider","i":Icons.bug_report,"c":Colors.purple,"p":100},{"n":"Candy","i":Icons.cake,"c":Colors.pink,"p":200},{{"n":"Skull","i":Icons.dangerous,"c":Colors.white,"p":300},{"n":"Lucky Box","i":Icons.card_giftcard,"c":Colors.amber,"p":500},{"n":"Rose","i":Icons.local_florist,"c":Colors.pink,"p":1}];
    for(int i=0;i<120;i++){var b=base[i%base.length]; allGifts.add({"name":b["n"],"icon":b["i"],"color":b["c"],"price":b["p"]+i,"cat": tabs[i%tabs.length]});}
  }
  Future<void> _initCam() async {
    if(globalCameras.isEmpty){ globalCameras = await availableCameras(); }
    if(globalCameras.isEmpty) return;
    camIdx = globalCameras.length>1 ? 1 : 0;
    cam = CameraController(globalCameras[camIdx], isHD? ResolutionPreset.high: ResolutionPreset.medium, enableAudio: true);
    await cam!.initialize(); if(mounted) setState(()=> camReady=true);
  }
  Future<void> _switchCam() async {
    if(globalCameras.length<2) return;
    camIdx = (camIdx+1)%globalCameras.length;
    await cam?.dispose(); setState(()=> camReady=false);
    cam = CameraController(globalCameras[camIdx], isHD? ResolutionPreset.high: ResolutionPreset.medium, enableAudio: true);
    await cam!.initialize(); if(mounted) setState(()=> camReady=true);
  }
  void _sendGift(Map g){ setState((){activeGift=g; showGift=false;}); giftAnim.forward(from:0); Future.delayed(const Duration(seconds: 3), ()=> setState(()=> activeGift=null));}
  @override void dispose(){cam?.dispose(); giftAnim.dispose(); super.dispose();}

  @override Widget build(BuildContext c){
    String type=widget.room["type"];
    return Scaffold(backgroundColor: Colors.black,
      body: Stack(children: [
        Positioned.fill(child: camReady && cam!=null && cam!.value.isInitialized ? (type=="multi"? _bestSeatGrid() : CameraPreview(cam!)) : Container(color: const Color(0xFF1E1E1E), child: const Center(child: CircularProgressIndicator(color: Colors.pink)))) ,
        Positioned(top: 0, left: 0, right: 0, child: SafeArea(child: Container(padding: const EdgeInsets.all(8), color: Colors.black54, child: Row(children: [
          CircleAvatar(radius: 14, backgroundColor: Colors.orange, child: Text("${widget.room["id"]}", style: const TextStyle(fontSize: 10))),
          const SizedBox(width: 6),
          Expanded(child: Text("${widget.room["name"]} - ${widget.room["viewers"]} Watching", style: const TextStyle(fontSize: 9))),
          IconButton(icon: const Icon(Icons.cameraswitch, size: 20), onPressed: _switchCam),
          GestureDetector(onTap: ()=> Navigator.pop(context), child: const Icon(Icons.close, size: 18)),
        ])))),
        if(activeGift!=null) Positioned.fill(child: Center(child: Icon(activeGift!["icon"], size: 80, color: activeGift!["color"]))),
        Positioned(bottom: 0, left: 0, right: 0, child: SafeArea(child: Container(padding: const EdgeInsets.all(8), color: const Color(0xFF1A1A1A), child: Row(children: [
          const Spacer(),
          GestureDetector(onTap: ()=> setState(()=> showGift=true), child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.pink, Colors.orange]), borderRadius: BorderRadius.circular(20)), child: const Text("Gift 🎁", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)))),
        ])))),
        if(showGift) _giftPackPanel(),
      ]),
    );
  }
  Widget _bestSeatGrid()=> GridView.count(crossAxisCount: 3, childAspectRatio: 0.9, children: List.generate(9, (i){
    bool isHost = i==0;
    return Container(margin: const EdgeInsets.all(2), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(8), border: Border.all(color: isHost? Colors.pink: Colors.white12)), 
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircleAvatar(radius: isHost?28:22, backgroundColor: isHost? Colors.pink: Colors.grey[800], child: Icon(Icons.person, size: isHost?28:20)),
        const SizedBox(height: 4),
        Text(isHost? "BEST SEAT\nHost":"Seat ${i+1}", textAlign: TextAlign.center, style: const TextStyle(fontSize: 8)),
      ]),
    );
  }));
  Widget _giftPackPanel()=> Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 420, decoration: const BoxDecoration(color: Color(0xFF1A1A2E), borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))), child: Column(children: [
    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), child: Row(children: [
      for(var t in tabs) GestureDetector(onTap: ()=> setState(()=> selectedTab=t), child: Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: selectedTab==t? Colors.pink: Colors.white10, borderRadius: BorderRadius.circular(12)), child: Text(t, style: TextStyle(fontSize: 9, color: selectedTab==t? Colors.white: Colors.white70)))),
      const Spacer(), IconButton(icon: const Icon(Icons.close, size: 18), onPressed: ()=> setState(()=> showGift=false)),
    ])),
    Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.75), itemCount: allGifts.where((g)=> g["cat"]==selectedTab).length, itemBuilder: (c,i){
      var filtered = allGifts.where((g)=> g["cat"]==selectedTab).toList(); var g=filtered[i];
      return GestureDetector(onTap: ()=> _sendGift(g), child: Container(decoration: BoxDecoration(color: const Color(0xFF2A2A4A), borderRadius: BorderRadius.circular(10)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(g["icon"], color: g["color"], size: 28), Text(g["name"], style: const TextStyle(fontSize: 7), maxLines: 1), Text("${g["price"]}", style: TextStyle(fontSize: 7, color: g["color"]))])));
    })),
  ]))); }
}

class PrivateRoomPage extends StatelessWidget { const PrivateRoomPage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, appBar: AppBar(title: const Text("Private 1v1 - Best Seat", style: TextStyle(fontSize: 12)), backgroundColor: Colors.black), body: const Center(child: Text("Private Room\nBest Seat + Camera", textAlign: TextAlign.center)));}}
class FamilyRoomPage extends StatelessWidget { const FamilyRoomPage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, appBar: AppBar(title: const Text("Family Room - Best Seat", style: TextStyle(fontSize: 12)), backgroundColor: Colors.black), body: GridView.count(crossAxisCount: 3, children: List.generate(9, (i)=> Container(margin: const EdgeInsets.all(4), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12), border: Border.all(color: i==0? Colors.pink: Colors.white12)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircleAvatar(radius: 20, backgroundColor: i==0? Colors.pink: Colors.grey, child: Icon(i==0? Icons.star: Icons.person, size: 18)), SizedBox(height: 4), Text(i==0? "BEST SEAT\nHost":"Seat ${i+1}", textAlign: TextAlign.center, style: TextStyle(fontSize: 8))])))));}}
class VideoFeedPage extends StatelessWidget { const VideoFeedPage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, body: const Center(child: Text("Video Play / Edit / Upload")));}}
class MessengerPage extends StatelessWidget { const MessengerPage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, appBar: AppBar(title: const Text("Messenger", style: TextStyle(fontSize: 12)), backgroundColor: Colors.black), body: const Center(child: Text("Messenger - 5000 Coins")));}}
class GamesPage extends StatelessWidget { const GamesPage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, appBar: AppBar(title: const Text("Games - 30 Best", style: TextStyle(fontSize: 12)), backgroundColor: Colors.black), body: GridView.count(crossAxisCount: 2, children: List.generate(30, (i)=> Card(color: const Color(0xFF1E1E1E), child: Center(child: Text("Game ${i+1}", style: TextStyle(fontSize: 10)))))));}}
class WalletPage extends StatelessWidget { const WalletPage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, appBar: AppBar(title: const Text("Wallet", style: TextStyle(fontSize: 12)), backgroundColor: Colors.black), body: const Center(child: Text("Wallet - 5000 Coins")));}}
class ProfilePage extends StatelessWidget { const ProfilePage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, appBar: AppBar(title: const Text("Profile - Rass Jigar", style: TextStyle(fontSize: 14)), backgroundColor: Colors.black), body: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircleAvatar(radius: 40, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 40)), SizedBox(height: 10), Text("Rass Jigar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text("@rass_jigar", style: TextStyle(color: Colors.white54)), SizedBox(height: 20), Text("RASS LIVE - Clean", style: TextStyle(color: Colors.green, fontSize: 12))])));}}
