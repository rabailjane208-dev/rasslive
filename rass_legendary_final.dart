import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

const int zegoAppID = 2143547789;
const String zegoAppSign = "YOUR_32_CHAR_APP_SIGN_HERE_REPLACE_THIS";

List<CameraDescription> globalCameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await [Permission.camera, Permission.microphone].request();
    globalCameras = await availableCameras();
  } catch(e) {
    debugPrint("Camera init error: $e");
  }
  runApp(const RassLiveApp());
}

class RassGift {
  final String id; final String name; final int price; final String emoji; final Color color; final bool isBest;
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
  RassGift(id: "11", name: "Lucky Box", price: 800, emoji: "🎁", color: Colors.green),
  RassGift(id: "12", name: "Fan Light", price: 100, emoji: "💡", color: Colors.yellow),
  RassGift(id: "13", name: "Cellphone", price: 200, emoji: "📱", color: Colors.blue),
  RassGift(id: "14", name: "Hand Mirror", price: 300, emoji: "🪞", color: Colors.pink),
  RassGift(id: "15", name: "Candy Star", price: 400, emoji: "⭐", color: Colors.purple),
  RassGift(id: "16", name: "Sparks", price: 500, emoji: "✨", color: Colors.amber),
  RassGift(id: "17", name: "Wishing", price: 600, emoji: "🍶", color: Colors.cyan),
  RassGift(id: "18", name: "Gem Handbag", price: 800, emoji: "👜", color: Colors.pink),
  RassGift(id: "19", name: "Medusa", price: 1000, emoji: "🐍", color: Colors.green),
  RassGift(id: "20", name: "Rose Route", price: 1200, emoji: "🌹🛣️", color: Colors.red),
  RassGift(id: "21", name: "Hot Balloon", price: 1500, emoji: "🎈", color: Colors.orange),
  RassGift(id: "22", name: "Wind Chime", price: 2000, emoji: "🎐", color: Colors.blue),
  RassGift(id: "23", name: "Rocking Horse", price: 2500, emoji: "🐴", color: Colors.brown),
  RassGift(id: "24", name: "Lily Valley", price: 3000, emoji: "🌸", color: Colors.pink, isBest: true),
  RassGift(id: "25", name: "Qatar Jet", price: 5000, emoji: "✈️", color: Colors.white, isBest: true),
  RassGift(id: "26", name: "Bumper Car", price: 8000, emoji: "🚗", color: Colors.red),
  RassGift(id: "27", name: "Cloudy Wings", price: 10000, emoji: "🦋", color: Colors.white, isBest: true),
  RassGift(id: "28", name: "Wind Girl", price: 12000, emoji: "👧💨", color: Colors.cyan, isBest: true),
  RassGift(id: "29", name: "Sleeping Beauty", price: 18000, emoji: "👸", color: Colors.pink, isBest: true),
  RassGift(id: "30", name: "Star Prince", price: 18000, emoji: "🤴", color: Colors.amber, isBest: true),
  RassGift(id: "31", name: "Rainbow", price: 25000, emoji: "🌈", color: Colors.purple, isBest: true),
  RassGift(id: "32", name: "Back Massage", price: 20000, emoji: "💆", color: Colors.orange, isBest: true),
  RassGift(id: "33", name: "Donkey", price: 36000, emoji: "🫏", color: Colors.brown, isBest: true),
  RassGift(id: "34", name: "Rose Afternoon", price: 38000, emoji: "🌹☕", color: Colors.redAccent, isBest: true),
  RassGift(id: "35", name: "Cloud Pavilion", price: 40000, emoji: "🏯", color: Colors.blueGrey, isBest: true),
  RassGift(id: "36", name: "Pirate Booty", price: 45000, emoji: "💰", color: Colors.brown, isBest: true),
  RassGift(id: "37", name: "Coaster", price: 48000, emoji: "🎢", color: Colors.blue, isBest: true),
  RassGift(id: "38", name: "Wishing Well", price: 50000, emoji: "⛲", color: Colors.cyan, isBest: true),
  RassGift(id: "39", name: "Past Fountain", price: 52000, emoji: "⛲", color: Colors.blueAccent, isBest: true),
  RassGift(id: "40", name: "Camel King", price: 60000, emoji: "🐪👑", color: Colors.amber, isBest: true),
  RassGift(id: "41", name: "Pirate Ship", price: 80000, emoji: "🚢", color: Colors.black, isBest: true),
  RassGift(id: "42", name: "Magic Castle", price: 100000, emoji: "🏰", color: Colors.purple, isBest: true),
  RassGift(id: "43", name: "Shark Sub", price: 100000, emoji: "🦈", color: Colors.blue, isBest: true),
  RassGift(id: "44", name: "Motor Gear", price: 100000, emoji: "🏍️", color: Colors.black, isBest: true),
  RassGift(id: "45", name: "Diamond Rainbow", price: 120000, emoji: "💎🌈", color: Colors.cyan, isBest: true),
  RassGift(id: "46", name: "Phoenix", price: 150000, emoji: "🦅", color: Colors.orange, isBest: true),
  RassGift(id: "47", name: "Dragon King", price: 200000, emoji: "🐉👑", color: Colors.red, isBest: true),
  RassGift(id: "48", name: "RASS Universe", price: 300000, emoji: "🌌👑", color: Colors.deepPurple, isBest: true),
  RassGift(id: "49", name: "RASS Legendary", price: 500000, emoji: "🐉🌌💎", color: Colors.amberAccent, isBest: true),
  RassGift(id: "50", name: "RASS GOD", price: 1000000, emoji: "👑🔥🌌", color: Colors.amber, isBest: true),
];

class RassLiveApp extends StatelessWidget{
  const RassLiveApp({super.key});
  @override Widget build(BuildContext context){
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'RASS LIVE', theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black), home: const MainScreen());
  }
}

class RoomData{
  final String name; final String emoji; final int viewers; final int score;
  RoomData(this.name, this.emoji, this.viewers, this.score);
}
final rooms = [
  RoomData("Rass World", "🌍", 1257, 100),
  RoomData("Queen Live", "👑", 892, 85),
  RoomData("Rass PK Arena", "", 543, 70),
  RoomData("9 Stars Multi", "⭐", 321, 60),
  RoomData("Voice Live", "🎙️", 210, 50),
];

class MainScreen extends StatefulWidget{ const MainScreen({super.key}); @override State<MainScreen> createState()=> _MainScreenState(); }
class _MainScreenState extends State<MainScreen>{
  int bottomIndex = 0;
  @override Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: bottomIndex==0 ? const RoomListScreen() : Center(child: Text(["RassLive","Private","Family","Video","Messenger","Games","Wallet","Profile"][bottomIndex], style: const TextStyle(color: Colors.white))),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0F0F0F),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        currentIndex: bottomIndex,
        onTap: (i)=> setState(()=> bottomIndex=i),
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

class RoomListScreen extends StatefulWidget{ const RoomListScreen({super.key}); @override State<RoomListScreen> createState()=> _RoomListScreenState(); }
class _RoomListScreenState extends State<RoomListScreen>{
  @override Widget build(BuildContext context){
    return SafeArea(
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), child: Row(children: [const Text("RASS LIVE - Score", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 20)), const Spacer(), IconButton(onPressed: (){}, icon: const Icon(Icons.live_tv, color: Colors.pink))])),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Align(alignment: Alignment.centerLeft, child: Text("👑 PK King: Ali Khan", style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold)))),
          const SizedBox(height: 8),
          Expanded(child: ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 10), itemCount: rooms.length, itemBuilder: (c,i){
            final r = rooms[i];
            return GestureDetector(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> LiveRoomScreen(room: r))),
              child: Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1a1a1a), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
                child: Row(children: [
                  CircleAvatar(radius: 26, backgroundColor: Colors.pink, child: Text("${i+1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("${r.name} ${r.emoji}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), const SizedBox(height:4), Text("Viewers: ${r.viewers} | Score: ${r.score}", style: const TextStyle(color: Colors.white54, fontSize: 11))])),
                  Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFF2a2a2a), borderRadius: BorderRadius.circular(12)), child: Column(children: [
                    Row(children: [Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.green.withOpacity(0.3), borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.arrow_upward, size: 14, color: Colors.green)), const SizedBox(width:4), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(6)), child: const Row(children: [Text("+", style: TextStyle(fontSize: 12)), SizedBox(width:2), Text("100", style: TextStyle(fontSize: 10, color: Colors.amber))]))]),
                    const SizedBox(height:4),
                    Row(children: [Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.red.withOpacity(0.3), borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.arrow_downward, size: 14, color: Colors.red)), const SizedBox(width:4), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(6)), child: const Text("-", style: TextStyle(fontSize: 12)))]),
                  ])),
                ]),
              ),
            );
          })),
          const Padding(padding: EdgeInsets.all(8), child: Text("🔥 Live Legend: Queen Live", style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}

class LiveRoomScreen extends StatefulWidget{
  final RoomData room; const LiveRoomScreen({super.key, required this.room});
  @override State<LiveRoomScreen> createState()=> _LiveRoomScreenState();
}
class _LiveRoomScreenState extends State<LiveRoomScreen>{
  RassGift? selected; int count=1; int myScore=0;
  CameraController? _cameraController;
  bool _isCamInit = false;
  bool useZego = false;

  bool get isZegoValid => !zegoAppSign.contains("YOUR") && zegoAppSign.length > 20 && zegoAppID != 0;

  @override void initState(){
    super.initState();
    _initCameraSafe();
    if(isZegoValid) useZego = true;
  }

  Future<void> _initCameraSafe() async {
    try {
      var status = await Permission.camera.request();
      await Permission.microphone.request();
      if(status.isDenied) return;
      if(globalCameras.isEmpty) {
        globalCameras = await availableCameras();
      }
      if(globalCameras.isNotEmpty){
        _cameraController = CameraController(globalCameras[0], ResolutionPreset.medium);
        await _cameraController!.initialize();
        if(mounted) setState(()=> _isCamInit = true);
      }
    } catch(e){
      debugPrint("Camera Error 0000 Safe: $e");
    }
  }

  @override void dispose(){
    try{ _cameraController?.dispose(); } catch(e){}
    super.dispose();
  }

  Widget _buildLiveView(){
    if(useZego && isZegoValid){
      try {
        return ZegoUIKitPrebuiltLiveStreaming(
          appID: zegoAppID,
          appSign: zegoAppSign,
          userID: "user_${DateTime.now().millisecondsSinceEpoch}",
          userName: widget.room.name,
          liveID: "rass_${widget.room.name}",
          config: ZegoUIKitPrebuiltLiveStreamingConfig.host(),
        );
      } catch(e){
        return _buildCameraFallback();
      }
    } else {
      return _buildCameraFallback();
    }
  }

  Widget _buildCameraFallback(){
    if(_isCamInit && _cameraController != null && _cameraController!.value.isInitialized){
      return CameraPreview(_cameraController!);
    } else {
      return const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircularProgressIndicator(color: Colors.pink),
        SizedBox(height:12),
        Text("Camera Starting... Permission Allow karo", style: TextStyle(color: Colors.white54, fontSize:12))
      ]));
    }
  }

  @override Widget build(BuildContext context){
    return Scaffold(
      body: Stack(children: [
        SizedBox(width: double.infinity, height: double.infinity, child: _buildLiveView()),
        SafeArea(child: Column(children: [
          Padding(padding: const EdgeInsets.all(10), child: Row(children: [
            IconButton(onPressed: ()=> Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.white)),
            CircleAvatar(backgroundColor: Colors.pink, child: Text(widget.room.name[0])),
            const SizedBox(width:8),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.room.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
              Text("ID: ${widget.room.viewers} • ${isZegoValid ? (useZego ? 'ZEGO LIVE' : 'CAM') : 'CAMERA'}", style: const TextStyle(fontSize:10, color: Colors.white70))
            ]),
            const Spacer(),
            if(isZegoValid) GestureDetector(
              onTap: ()=> setState(()=> useZego = !useZego),
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: useZego ? Colors.green : Colors.red, borderRadius: BorderRadius.circular(12)), child: Text(useZego ? "ZEGO ON" : "CAM ON", style: const TextStyle(fontSize:10, fontWeight: FontWeight.bold, color: Colors.white))),
            ),
            const SizedBox(width:6),
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)), child: Text("💎 $myScore", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 11))),
          ])),
          const Spacer(),
        ])),
        DraggableScrollableSheet(initialChildSize: 0.52, minChildSize: 0.4, maxChildSize: 0.85, builder: (context, sc){
          return Container(decoration: const BoxDecoration(color: Color(0xFF1c1c1e), borderRadius: BorderRadius.vertical(top: Radius.circular(16))), child: Column(children: [
            const SizedBox(height:8), Container(width:36, height:4, decoration: BoxDecoration(color: Colors.grey[600], borderRadius: BorderRadius.circular(2))), const SizedBox(height:8),
            Padding(padding: const EdgeInsets.symmetric(horizontal:12), child: Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal:8, vertical:3), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)), child: const Text("Gift Pack", style: TextStyle(fontSize:10, fontWeight: FontWeight.bold))), const SizedBox(width:8), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("XP Needed: 3000", style: TextStyle(fontSize:9, color: Colors.white70)), LinearProgressIndicator(value: 0.72, backgroundColor: Colors.white12, color: Colors.orange, minHeight: 3)])), const Text("72%", style: TextStyle(fontSize:10, color: Colors.orange)), const SizedBox(width:8), Container(padding: const EdgeInsets.symmetric(horizontal:6, vertical:2), decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(6)), child: const Text("Surprise Shop", style: TextStyle(fontSize:9)))])),
            const SizedBox(height:8),
            Expanded(child: GridView.builder(controller: sc, padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 0.78), itemCount: rassGifts.length, itemBuilder: (c,i){
              final g = rassGifts[i]; final isSel = selected?.id==g.id;
              return GestureDetector(onTap: ()=> setState(()=> selected=g), child: Container(decoration: BoxDecoration(color: isSel? Colors.amber.withOpacity(0.25): const Color(0xFF2c2c2e), borderRadius: BorderRadius.circular(10), border: isSel? Border.all(color: Colors.amber, width:1.5): g.isBest? Border.all(color: Colors.amber.withOpacity(0.6)): null), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(g.emoji, style: TextStyle(fontSize: g.isBest?26:22)), Text(g.name, style: const TextStyle(fontSize:8, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines:2), Container(margin: const EdgeInsets.only(top:2), padding: const EdgeInsets.symmetric(horizontal:4, vertical:1), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)), child: Text("🪙 ${g.price}", style: TextStyle(fontSize:7, color: Colors.amber[200], fontWeight: FontWeight.bold))), if(g.isBest) Container(margin: const EdgeInsets.only(top:2), padding: const EdgeInsets.symmetric(horizontal:4, vertical:1), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)), child: const Text("BEST", style: TextStyle(fontSize:5, color: Colors.black, fontWeight: FontWeight.bold)))])));
            })),
            Container(padding: const EdgeInsets.symmetric(horizontal:10, vertical:8), decoration: const BoxDecoration(color: Color(0xFF121212), border: Border(top: BorderSide(color: Colors.white12))), child: Row(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal:10, vertical:6), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(16)), child: const Text("First Recharge", style: TextStyle(fontSize:10, fontWeight: FontWeight.bold))),
              const SizedBox(width:8),
              Expanded(child: Row(children: [1,10,50].map((n)=> GestureDetector(onTap: ()=> setState(()=> count=n), child: Container(margin: const EdgeInsets.only(right:6), width:30, height:28, decoration: BoxDecoration(color: count==n? Colors.white: Colors.white12, borderRadius: BorderRadius.circular(8)), child: Center(child: Text("$n", style: TextStyle(fontSize:11, color: count==n? Colors.black: Colors.white, fontWeight: FontWeight.bold)))))).toList())),
              GestureDetector(onTap: (){ if(selected!=null){ setState(()=> myScore+= selected!.price*count); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${selected!.emoji} ${selected!.name} x$count Sent!", style: const TextStyle(fontWeight: FontWeight.bold)), backgroundColor: selected!.color, duration: const Duration(milliseconds: 700))); }}, child: Container(padding: const EdgeInsets.symmetric(horizontal:20, vertical:8), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF00c6ff), Color(0xFF0072ff)]), borderRadius: BorderRadius.circular(20)), child: const Text("Send", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
            ])),
          ]));
        }),
      ]),
    );
  }
}
