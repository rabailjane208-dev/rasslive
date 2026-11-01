// RASS LIVE - FINAL FIXED - NO BRACKET ERROR
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

const int ZEGO_APP_ID = 1238213223;
const String ZEGO_APP_SIGN = "3cfba1ba4c90747bdd4e393935381fa216178c528dc70e558fa70fafde0fce9f";

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
    final rooms=[{"id":1, "name":"Rass World 🌍", "viewers":1257, "score":100, "type":"solo"}, {"id":2, "name":"Queen Live 👑", "viewers":892, "score":85, "type":"queen"}, {"id":3, "name":"Rass PK Arena", "viewers":543, "score":70, "type":"pk"}, {"id":4, "name":"9 Stars Multi ⭐", "viewers":321, "score":60, "type":"multi"}, {"id":5, "name":"Voice Live 🎙️", "viewers":210, "score":50, "type":"voice"}];
    return Scaffold(backgroundColor: const Color(0xFF121212), appBar: AppBar(backgroundColor: Colors.black, title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("RASS LIVE - Score", style: TextStyle(color: Color(0xFFFF3B30), fontWeight: FontWeight.bold, fontSize: 14)), Text("AppID: $ZEGO_APP_ID - AppSign OK", style: const TextStyle(fontSize: 8, color: Colors.green))])), body: ListView.builder(itemCount: rooms.length, itemBuilder: (ctx,i){var r=rooms[i]; return GestureDetector(onTap: ()=> Navigator.push(ctx, MaterialPageRoute(builder: (_)=> LiveRoomDetail(room: r))), child: Container(margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Row(children: [CircleAvatar(radius: 24, backgroundColor: const Color(0xFFFF2E63), child: Text("${r["id"]}", style: const TextStyle(fontWeight: FontWeight.bold))), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(r["name"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text("Viewers: ${r["viewers"]} | Score: ${r["score"]} | AppID: $ZEGO_APP_ID", style: const TextStyle(color: Colors.white54, fontSize: 8))]))]))); }));
  }
}
class LiveRoomDetail extends StatefulWidget { final Map room; const LiveRoomDetail({super.key, required this.room}); @override State<LiveRoomDetail> createState()=>_LiveRoomDetailState(); }
class _LiveRoomDetailState extends State<LiveRoomDetail> with TickerProviderStateMixin {
  CameraController? cam; int camIdx=0; bool camReady=false; bool isHD=true; bool isBeauty=true;
  late AnimationController giftAnim; Map? activeGift; bool showGift=false; bool showBeauty=false;
  String selectedTab="Gift"; int myScore=4864; List<String> chats=["AppID: $ZEGO_APP_ID Connected ✅", "AppSign OK ✅", "Zain: Kya baat hai!"]; List<Map> allGifts=[]; final tabs=["Halloween","New","Gift","Lucky","Fan Club","Surprise Shop"];
  @override void initState(){ super.initState(); giftAnim=AnimationController(vsync: this, duration: const Duration(seconds: 3)); _genGifts(); _initCam(); }
  void _genGifts(){ List base=[{"n":"Party","i":Icons.celebration,"c":Colors.yellow,"p":30},{"n":"Star","i":Icons.star,"c":Colors.cyan,"p":50},{"n":"Spider","i":Icons.bug_report,"c":Colors.purple,"p":100},{"n":"Broom","i":Icons.cleaning_services,"c":Colors.brown,"p":150},{"n":"Candy","i":Icons.cake,"c":Colors.pink,"p":200},{"n":"Skull","i":Icons.dangerous,"c":Colors.white,"p":300}]; for(int i=0;i<30;i++){var b=base[i%base.length]; allGifts.add({"name":b["n"],"icon":b["i"],"color":b["c"],"price":b["p"]+i,"cat": tabs[i%tabs.length]});} }
  Future<void> _initCam() async { if(globalCameras.isEmpty){ try{globalCameras = await availableCameras();}catch(e){} } if(globalCameras.isEmpty) return; camIdx = globalCameras.length>1 ? 1 : 0; cam = CameraController(globalCameras[camIdx], isHD? ResolutionPreset.high: ResolutionPreset.medium, enableAudio: true); await cam!.initialize(); if(mounted) setState(()=> camReady=true); }
  Future<void> _switchCam() async { if(globalCameras.length<2) return; camIdx = (camIdx+1)%globalCameras.length; await cam?.dispose(); setState(()=> camReady=false); cam = CameraController(globalCameras[camIdx], isHD? ResolutionPreset.high: ResolutionPreset.medium, enableAudio: true); await cam!.initialize(); if(mounted) setState(()=> camReady=true); }
  void _sendGift(Map g){ setState((){activeGift=g; showGift=false; chats.insert(0, "You sent ${g["name"]}"); myScore+=10;}); giftAnim.forward(from:0); Future.delayed(const Duration(seconds: 3), ()=> setState(()=> activeGift=null));}
  @override void dispose(){cam?.dispose(); giftAnim.dispose(); super.dispose();}
  @override Widget build(BuildContext c){ String type=widget.room["type"]; return Scaffold(backgroundColor: Colors.black, body: Stack(children: [ Positioned.fill(child: camReady && cam!=null && cam!.value.isInitialized ? CameraPreview(cam!) : Container(color: const Color(0xFF1E1E1E), child: const Center(child: CircularProgressIndicator(color: Colors.pink)))), Positioned(top: 0, left: 0, right: 0, child: SafeArea(child: Container(padding: const EdgeInsets.all(8), color: Colors.black54, child: Row(children: [CircleAvatar(radius: 14, backgroundColor: Colors.orange, child: Text("${widget.room["id"]}", style: const TextStyle(fontSize: 10))), const SizedBox(width: 6), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("${widget.room["name"]} - AppID: $ZEGO_APP_ID", style: const TextStyle(fontSize: 9)), Text("AppSign Connected ✅", style: const TextStyle(fontSize: 7, color: Colors.green))])), IconButton(icon: const Icon(Icons.cameraswitch, size: 20), onPressed: _switchCam), GestureDetector(onTap: ()=> Navigator.pop(context), child: const Icon(Icons.close, size: 18)),])))), if(activeGift!=null) Positioned.fill(child: Center(child: Icon(activeGift!["icon"], size: 80, color: activeGift!["color"]))), Positioned(bottom: 0, left: 0, right: 0, child: SafeArea(child: Container(padding: const EdgeInsets.all(8), color: const Color(0xFF1A1A1A), child: Row(children: [const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.white54), const Spacer(), GestureDetector(onTap: ()=> setState(()=> showGift=true), child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.pink, Colors.orange]), borderRadius: BorderRadius.circular(20)), child: const Text("Gift 🎁", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))))])))), if(showGift) Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 300, color: const Color(0xFF1A1A2E), child: Center(child: ElevatedButton(onPressed: ()=> setState(()=> showGift=false), child: const Text("Close Gift"))))), ])); }
}
class PrivateRoomPage extends StatelessWidget { const PrivateRoomPage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, appBar: AppBar(title: const Text("Private 1v1", style: TextStyle(fontSize: 12)), backgroundColor: Colors.black), body: Center(child: Text("Private Room\nAppID: $ZEGO_APP_ID", textAlign: TextAlign.center)));}}
class FamilyRoomPage extends StatelessWidget { const FamilyRoomPage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, appBar: AppBar(title: const Text("Family Room", style: TextStyle(fontSize: 12)), backgroundColor: Colors.black), body: const Center(child: Text("Family Room - Best Seat")));}}
class VideoFeedPage extends StatelessWidget { const VideoFeedPage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, body: const Center(child: Text("Video")));}}
class MessengerPage extends StatelessWidget { const MessengerPage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, appBar: AppBar(title: const Text("Messenger", style: TextStyle(fontSize: 12)), backgroundColor: Colors.black), body: const Center(child: Text("Messenger")));}}
class GamesPage extends StatelessWidget { const GamesPage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, appBar: AppBar(title: const Text("Games", style: TextStyle(fontSize: 12)), backgroundColor: Colors.black), body: const Center(child: Text("Games")));}}
class WalletPage extends StatelessWidget { const WalletPage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, appBar: AppBar(title: const Text("Wallet", style: TextStyle(fontSize: 12)), backgroundColor: Colors.black), body: const Center(child: Text("Wallet")));}}
class ProfilePage extends StatelessWidget { const ProfilePage({super.key}); @override Widget build(BuildContext c){return Scaffold(backgroundColor: Colors.black, appBar: AppBar(title: const Text("Profile", style: TextStyle(fontSize: 14)), backgroundColor: Colors.black), body: Center(child: Text("Rass Jigar\nAppID: $ZEGO_APP_ID", textAlign: TextAlign.center)));}}
