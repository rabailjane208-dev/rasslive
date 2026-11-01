import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:audioplayers/audioplayers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(RassLiveApp(cameras: cameras));
}

class RassLiveApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const RassLiveApp({super.key, required this.cameras});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RASS LIVE',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: RassHomePage(cameras: cameras),
    );
  }
}

// HOME - RASS LIVE SCORE like your screenshot
class RassHomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const RassHomePage({super.key, required this.cameras});
  @override
  State<RassHomePage> createState() => _RassHomePageState();
}

class _RassHomePageState extends State<RassHomePage> {
  int _selectedTab = 0;
  final List<Map<String, dynamic>> rooms = [
    {"id":1, "name":"Rass World 🌍", "viewers":1257, "score":100},
    {"id":2, "name":"Queen Live 👑", "viewers":892, "score":85},
    {"id":3, "name":"Rass PK Arena", "viewers":543, "score":70},
    {"id":4, "name":"9 Stars Multi ⭐", "viewers":321, "score":60},
    {"id":5, "name":"Voice Live 🎙️", "viewers":210, "score":50},
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text("RASS LIVE - Score", style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)), actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.live_tv, color: Colors.pink))]),
      body: ListView.builder(itemCount: rooms.length, itemBuilder: (c,i){
        var r = rooms[i];
        return GestureDetector(
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> RassLiveRoom(cameras: widget.cameras, roomName: r["name"]))),
          child: Container(margin: const EdgeInsets.symmetric(horizontal:12, vertical:6), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)), child: Row(children: [
            CircleAvatar(radius:28, backgroundColor: Colors.pink, child: Text("${r["id"]}", style: const TextStyle(fontSize:20, fontWeight: FontWeight.bold))),
            const SizedBox(width:12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(r["name"], style: const TextStyle(fontSize:16, fontWeight: FontWeight.bold)),
              const SizedBox(height:4),
              Text("Viewers: ${r["viewers"]} | Score: ${r["score"]}", style: const TextStyle(fontSize:12, color: Colors.white54)),
            ])
          ]))
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, backgroundColor: Colors.black, selectedItemColor: Colors.pink, unselectedItemColor: Colors.white54, currentIndex: _selectedTab, onTap: (v)=> setState(()=> _selectedTab=v), showUnselectedLabels: true, selectedFontSize: 10, unselectedFontSize: 9,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "Rass..."),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Priva..."),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Video"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Mess..."),
          BottomNavigationBarItem(icon: Icon(Icons.extension), label: "Gam..."),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// LIVE ROOM HD + SOUND
class RassLiveRoom extends StatefulWidget {
  final List<CameraDescription> cameras; final String roomName;
  const RassLiveRoom({super.key, required this.cameras, required this.roomName});
  @override
  State<RassLiveRoom> createState() => _RassLiveRoomState();
}

class _RassLiveRoomState extends State<RassLiveRoom> with TickerProviderStateMixin {
  CameraController? _cam; int _camIndex = 0; bool _isHD = true; bool _isBeauty = true; double _beauty = 0.7;
  bool _isPK = true; bool _showGift = false; bool _showBeauty = false;
  final AudioPlayer _audio = AudioPlayer();
  late AnimationController _giftAnim;
  GiftItem? _activeGift;
  int myScore = 752718; int otherScore = 338881;
  List<String> chats = ["Apple : ggg","Admin : arhaab ya close bhai ❤️","AD CHOUD: sent Rose x134","Nawab: sent Lion"];

  List<GiftItem> gifts = [
    GiftItem('Popper', Icons.celebration, Colors.yellow, 10, 'popper', 'pop'),
    GiftItem('New Star', Icons.star, Colors.cyan, 50, 'star', 'ding'),
    GiftItem('Spider', Icons.bug_report, Colors.purple, 100, 'spider', 'buzz'),
    GiftItem('Broom', Icons.cleaning_services, Colors.brown, 150, 'broom', 'whoosh'),
    GiftItem('Candy', Icons.cake, Colors.pink, 200, 'candy', 'pop'),
    GiftItem('Skull', Icons.skull, Colors.white, 500, 'skull', 'horror'),
    GiftItem('Lucky Box', Icons.card_giftcard, Colors.amber, 1000, 'chest', 'treasure'),
    GiftItem('Rose', Icons.local_florist, Colors.pink, 1, 'rose', 'rose'),
    GiftItem('Car', Icons.directions_car, Colors.pinkAccent, 9999, 'car', 'car'),
    GiftItem('Lion', Icons.pets, Colors.orange, 29999, 'lion', 'lion'),
    GiftItem('Dragon', Icons.whatshot, Colors.cyanAccent, 15000, 'dragon', 'dragon'),
    GiftItem('Kiss', Icons.favorite, Colors.red, 5, 'kiss', 'kiss'),
    GiftItem('Swan', Icons.flutter_dash, Colors.white, 50, 'swan', 'swan'),
    GiftItem('Cherry', Icons.eco, Colors.redAccent, 20, 'cherry', 'pop'),
  ];

  @override
  void initState(){
    super.initState();
    _initCam();
    _giftAnim = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    Timer.periodic(const Duration(seconds: 4), (t){ if(mounted) setState(()=> chats.insert(0, "User${Random().nextInt(500)}: ❤️❤️🔥")); });
  }

  Future<void> _initCam() async {
    if(widget.cameras.isEmpty) return;
    _cam = CameraController(widget.cameras[_camIndex], _isHD ? ResolutionPreset.high : ResolutionPreset.medium, enableAudio: false);
    await _cam!.initialize(); if(mounted) setState((){});
  }

  Future<void> _switchCam() async {
    _camIndex = (_camIndex+1) % widget.cameras.length;
    await _cam?.dispose(); await _initCam();
  }

  void _sendGift(GiftItem g) async {
    setState((){ _activeGift=g; _showGift=false; chats.insert(0, "You sent ${g.name} x1"); if(g.type=='lion') otherScore+=29999; });
    _giftAnim.forward(from: 0);
    // SOUND SYSTEM - gift ka sound
    try{
      // simple beep sounds via audioplayers - ap apni mp3 add kar sakte ho assets me
      await _audio.play(AssetSource('sounds/${g.sound}.mp3')).catchError((_){});
    }catch(e){}
    // vibration feel ke liye haptic bhi
    Future.delayed(const Duration(seconds: 3), (){ if(mounted) setState(()=> _activeGift=null); });
  }

  @override
  void dispose(){ _cam?.dispose(); _giftAnim.dispose(); _audio.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context){
    return Scaffold(body: Stack(children: [
      Positioned.fill(child: _cam!=null && _cam!.value.isInitialized ? ColorFiltered(
        colorFilter: _isBeauty ? ColorFilter.matrix([1+_beauty*0.2,0,0,0,20*_beauty,0,1+_beauty*0.1,0,0,20*_beauty,0,0,1+_beauty*0.1,0,20*_beauty,0,0,0,1,0]) : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
        child: _isPK ? _pkView() : CameraPreview(_cam!),
      ) : const Center(child: CircularProgressIndicator())),
      _topBar(),
      if(_activeGift!=null) _giftAnimWidget(_activeGift!),
      _chat(),
      _bottomBar(),
      if(_showGift) _giftPanel(),
      if(_showBeauty) _beautyPanel(),
    ]));
  }

  Widget _pkView()=> Row(children: [Expanded(child: Stack(children: [CameraPreview(_cam!), Positioned(top:50, left:8, child: _badge("WIN x3"))])), Container(width:2, color: Colors.white24), Expanded(child: Container(color: Colors.grey[900], child: const Center(child: Icon(Icons.person, size:80))))]);
  Widget _badge(String t)=> Container(padding: const EdgeInsets.symmetric(horizontal:6, vertical:2), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(10)), child: Text(t, style: const TextStyle(fontSize:10, fontWeight: FontWeight.bold)));
  Widget _topBar()=> Positioned(top:0, left:0, right:0, child: SafeArea(child: Column(children: [
    Padding(padding: const EdgeInsets.all(8), child: Row(children: [
      const CircleAvatar(radius:14, backgroundColor: Colors.orange, child: Icon(Icons.person, size:14)),
      const SizedBox(width:6), Text(widget.roomName, style: const TextStyle(fontSize:12, fontWeight: FontWeight.bold)), const Spacer(),
      IconButton(icon: const Icon(Icons.cameraswitch, size:20), onPressed: _switchCam), // front/back HD
      IconButton(icon: Icon(_isHD? Icons.hd: Icons.sd, size:20, color: _isHD? Colors.pink: Colors.white), onPressed: (){ setState(()=> _isHD=!_isHD); _initCam(); }),
      Container(padding: const EdgeInsets.symmetric(horizontal:8, vertical:4), decoration: BoxDecoration(color: _isPK? Colors.red: Colors.black54, borderRadius: BorderRadius.circular(12)), child: GestureDetector(onTap: ()=> setState(()=> _isPK=!_isPK), child: Text(_isPK? "PK": "Solo", style: const TextStyle(fontSize:10)))),
      const SizedBox(width:6), GestureDetector(onTap: ()=> Navigator.pop(context), child: const Icon(Icons.close, size:20)),
    ])),
    Container(margin: const EdgeInsets.symmetric(horizontal:8), height:22, decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)), child: Row(children: [Expanded(child: Container(alignment: Alignment.centerLeft, padding: const EdgeInsets.only(left:6), decoration: const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))), child: Text("$myScore", style: const TextStyle(fontSize:11, fontWeight: FontWeight.bold)))), const Padding(padding: EdgeInsets.symmetric(horizontal:6), child: Text("VS 1:40", style: TextStyle(fontSize:10))), Expanded(child: Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(right:6), decoration: const BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))), child: Text("$otherScore", style: const TextStyle(fontSize:11, fontWeight: FontWeight.bold))))])),
  ])));
  Widget _giftAnimWidget(GiftItem g)=> Positioned.fill(child: AnimatedBuilder(animation: _giftAnim, builder: (c,_){ double v=_giftAnim.value; return Stack(alignment: Alignment.center, children: [
    if(g.type=='chest') Transform.scale(scale: 0.8+v*0.5, child: Icon(Icons.card_giftcard, size:100, color: Colors.amber)),
    if(g.type=='car') Transform.translate(offset: Offset(-200+v*400, 0), child: Icon(Icons.directions_car, size:80, color: Colors.pinkAccent)),
    if(g.type=='lion') Transform.scale(scale: v, child: Icon(Icons.pets, size:100, color: Colors.orange)),
    if(g.type=='rose') ...List.generate(12, (i)=> Positioned(bottom: 100+v*400, left: MediaQuery.of(context).size.width/2 + (Random().nextDouble()-0.5)*200, child: Opacity(opacity: 1-v, child: Icon(Icons.local_florist, color: Colors.pink, size:20+Random().nextDouble()*20)))),
    if(g.type!='rose') Center(child: Text(g.name, style: TextStyle(fontSize:30, fontWeight: FontWeight.bold, color: g.color, shadows: [Shadow(blurRadius:20, color: g.color)]))),
  ]); }));
  Widget _chat()=> Positioned(left:8, bottom:70, right:80, child: SizedBox(height:110, child: ListView.builder(reverse:true, itemCount: chats.length, itemBuilder: (c,i)=> Container(margin: const EdgeInsets.only(bottom:2), padding: const EdgeInsets.symmetric(horizontal:6, vertical:2), decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(8)), child: Text(chats[i], style: const TextStyle(fontSize:11))))));
  Widget _bottomBar()=> Positioned(bottom:0, left:0, right:0, child: SafeArea(child: Padding(padding: const EdgeInsets.all(8), child: Row(children: [
    _sIcon(Icons.chat_bubble_outline, (){}), const SizedBox(width:8), _sIcon(Icons.menu, (){}), const SizedBox(width:8), _sIcon(Icons.group, (){}), const SizedBox(width:8), _sIcon(Icons.auto_fix_high, ()=> setState(()=> _showBeauty=!_showBeauty)), const Spacer(),
    GestureDetector(onTap: ()=> setState(()=> _showGift=true), child: Container(padding: const EdgeInsets.symmetric(horizontal:16, vertical:8), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.pink, Colors.orange]), borderRadius: BorderRadius.circular(20)), child: const Row(children: [Icon(Icons.card_giftcard, size:16), SizedBox(width:4), Text("Gift", style: TextStyle(fontSize:12, fontWeight: FontWeight.bold))]))),
  ]))));
  Widget _sIcon(IconData ic, VoidCallback f)=> GestureDetector(onTap:f, child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle, border: Border.all(color: Colors.white24)), child: Icon(ic, size:14)));
  Widget _giftPanel()=> Positioned(bottom:0, left:0, right:0, child: Container(height: 320, decoration: const BoxDecoration(color: Color(0xFF1A1A2E), borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))), child: Column(children: [
    Padding(padding: const EdgeInsets.all(8), child: Row(children: [const Text("Gift Pack - New Gift Lucky Fan Club", style: TextStyle(fontSize:12, fontWeight: FontWeight.bold, color: Colors.amber)), const Spacer(), IconButton(icon: const Icon(Icons.close, size:18), onPressed: ()=> setState(()=> _showGift=false))])),
    Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4, childAspectRatio:0.85, crossAxisSpacing:8, mainAxisSpacing:8), itemCount: gifts.length, itemBuilder: (c,i){ final g=gifts[i]; return GestureDetector(onTap: ()=> _sendGift(g), child: Container(decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(g.icon, color: g.color, size:26), const SizedBox(height:4), Text(g.name, style: const TextStyle(fontSize:9)), Text("${g.price}", style: TextStyle(fontSize:8, color: g.color)), Container(margin: const EdgeInsets.only(top:2), padding: const EdgeInsets.symmetric(horizontal:6, vertical:2), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(6)), child: const Text("Send", style: TextStyle(fontSize:8))]))); })),
  ])));
  Widget _beautyPanel()=> Positioned(bottom:60, left:8, right:8, child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white24)), child: Column(children: [
    Row(children: [const Icon(Icons.face_retouching_natural, size:16), const SizedBox(width:6), const Text("Rass Beauty - Face Saaf HD + Choty Bal", style: TextStyle(fontSize:11, fontWeight: FontWeight.bold)), const Spacer(), Switch(value: _isBeauty, onChanged: (v)=> setState(()=> _isBeauty=v), activeColor: Colors.pink)]),
    Row(children: [const Text("Smooth", style: TextStyle(fontSize:10)), Expanded(child: Slider(value: _beauty, min:0, max:1, activeColor: Colors.pink, onChanged: (v)=> setState(()=> _beauty=v))), Text("${(_beauty*100).toInt()}%", style: const TextStyle(fontSize:10))]),
    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_bBtn(Icons.face, "Face Clean"), _bBtn(Icons.content_cut, "Choty Bal"), _bBtn(Icons.brightness_6, "HD Bright"), _bBtn(Icons.cameraswitch, "Back Cam")]),
  ])));
  Widget _bBtn(IconData ic, String l)=> Column(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: _isBeauty? Colors.pink: Colors.white12, shape: BoxShape.circle), child: Icon(ic, size:16)), const SizedBox(height:2), Text(l, style: const TextStyle(fontSize:8))]);
}

class GiftItem {
  final String name; final IconData icon; final Color color; final int price; final String type; final String sound;
  GiftItem(this.name, this.icon, this.color, this.price, this.type, this.sound);
}
              // RASS LIVE - ULTIMATE ALL-IN-ONE - 1000 Gifts + 30 Games + All Rooms
import 'dart:async'; import 'dart:math';
import 'package:flutter/material.dart'; import 'package:camera/camera.dart'; import 'package:audioplayers/audioplayers.dart';

void main() async { WidgetsFlutterBinding.ensureInitialized(); final cams = await availableCameras(); runApp(RassApp(cams: cams)); }
class RassApp extends StatelessWidget { final List<CameraDescription> cams; const RassApp({super.key, required this.cams}); @override Widget build(BuildContext context) { return MaterialApp(debugShowCheckedModeBanner: false, title: 'RASS LIVE', theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black), home: MainTabs(cams: cams)); } }

// MAIN TABS
class MainTabs extends StatefulWidget { final List<CameraDescription> cams; const MainTabs({super.key, required this.cams}); @override State<MainTabs> createState()=> _MainTabsState(); }
class _MainTabsState extends State<MainTabs> {
  int idx=0;
  late List<Widget> pages;
  @override void initState(){ super.initState(); pages=[RassScorePage(cams: widget.cams), PrivateRoomPage(), FamilyRoomPage(), VideoPage(), MessengerPage(), Games30Page(), WalletPage(), ProfilePage()]; }
  @override Widget build(BuildContext context){ return Scaffold(body: pages[idx], bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.fixed, backgroundColor: Colors.black, selectedItemColor: Colors.pink, unselectedItemColor: Colors.white54, currentIndex: idx, onTap: (v)=> setState(()=> idx=v), selectedFontSize:10, unselectedFontSize:9, items: const [BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "Rass"), BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Private"), BottomNavigationBarItem(icon: Icon(Icons.group), label: "Family"), BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Video"), BottomNavigationBarItem(icon: Icon(Icons.message), label: "Mess..."), BottomNavigationBarItem(icon: Icon(Icons.extension), label: "Games"), BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"), BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")],)); }
}

// 1. RASS SCORE - Rass World, Queen Live, PK Arena, 9 Stars, Voice
class RassScorePage extends StatelessWidget {
  final List<CameraDescription> cams; RassScorePage({super.key, required this.cams});
  final rooms=[{"id":1,"name":"Rass World 🌍","type":"solo","viewers":1257,"score":100},{"id":2,"name":"Queen Live 👑","type":"queen","viewers":892,"score":85},{"id":3,"name":"Rass PK Arena","type":"pk","viewers":543,"score":70},{"id":4,"name":"9 Stars Multi ⭐","type":"multi","viewers":321,"score":60},{"id":5,"name":"Voice Live 🎙️","type":"voice","viewers":210,"score":50}];
  @override Widget build(BuildContext c){ return Scaffold(appBar: AppBar(backgroundColor: Colors.black, title: const Text("RASS LIVE - Score", style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)), actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.live_tv, color: Colors.pink))]), body: ListView.builder(itemCount: rooms.length, itemBuilder: (ctx,i){ var r=rooms[i]; return GestureDetector(onTap: ()=> Navigator.push(ctx, MaterialPageRoute(builder: (_)=> UltimateLiveRoom(cams: cams, room: r))), child: Container(margin: const EdgeInsets.symmetric(horizontal:12, vertical:6), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Row(children: [CircleAvatar(radius:28, backgroundColor: Colors.pink, child: Text("${r["id"]}", style: const TextStyle(fontSize:20, fontWeight: FontWeight.bold))), const SizedBox(width:12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(r["name"] as String, style: const TextStyle(fontSize:16, fontWeight: FontWeight.bold)), Text("Viewers: ${r["viewers"]} | Score: ${r["score"]} | Type: ${r["type"]}", style: const TextStyle(fontSize:11, color: Colors.white54))])]))); }); }
}

// ULTIMATE LIVE ROOM - All features
class UltimateLiveRoom extends StatefulWidget { final List<CameraDescription> cams; final Map room; const UltimateLiveRoom({super.key, required this.cams, required this.room}); @override State<UltimateLiveRoom> createState()=> _UltimateLiveRoomState(); }
class _UltimateLiveRoomState extends State<UltimateLiveRoom> with TickerProviderStateMixin {
  CameraController? cam; int camIdx=0; bool isHD=true; bool isBeauty=true; double beauty=0.7; bool showGift=false; bool showBeauty=false; final AudioPlayer audio=AudioPlayer(); late AnimationController giftAnim; Map? activeGift; int diamonds=50000; int coins=100000; int beans=358000; List<String> chats=["Apple: ggg","Admin: arhaab ya close bhai","AD: sent Rose x134","Nawab: sent Lion"]; List<Map> allGifts=[];
  @override void initState(){ super.initState(); _initCam(); giftAnim=AnimationController(vsync: this, duration: const Duration(seconds: 3)); _generate1000Gifts(); Timer.periodic(const Duration(seconds: 3), (t){ if(mounted) setState(()=> chats.insert(0, "User${Random().nextInt(999)}: ❤️🔥")); }); }
  void _generate1000Gifts(){ List<String> cats=["Halloween","New","Gift","Lucky","Fan Club","Surprise Shop"]; List<Map> base=[{"n":"Party Popper","i":Icons.celebration,"c":Colors.yellow,"p":30},{"n":"New Star","i":Icons.star,"c":Colors.cyan,"p":100},{"n":"Spider","i":Icons.bug_report,"c":Colors.purple,"p":200},{"n":"Broom","i":Icons.cleaning_services,"c":Colors.brown,"p":250},{"n":"Candy","i":Icons.cake,"c":Colors.pink,"p":300},{"n":"Skull","i":Icons.skull,"c":Colors.white,"p":500},{"n":"Lucky Box","i":Icons.card_giftcard,"c":Colors.amber,"p":1000},{"n":"Rose","i":Icons.local_florist,"c":Colors.pink,"p":1},{"n":"Kiss","i":Icons.favorite,"c":Colors.red,"p":5},{"n":"Swan","i":Icons.flutter_dash,"c":Colors.white,"p":50},{"n":"Lion","i":Icons.pets,"c":Colors.orange,"p":29999},{"n":"Sports Car","i":Icons.directions_car,"c":Colors.pinkAccent,"p":9999},{"n":"Dragon","i":Icons.whatshot,"c":Colors.cyanAccent,"p":15000},{"n":"Universe","i":Icons.public,"c":Colors.purple,"p":40000}]; for(int i=0;i<1000;i++){ var b=base[i%base.length]; allGifts.add({"id":i,"name":"${b["n"]} ${i>13?i:''}","icon":b["i"],"color":b["c"],"price":b["p"]+i,"cat":cats[i%cats.length],"type": i%3==0?"car": i%3==1?"lion":"rose","sound":"pop"}); } }
  Future<void> _initCam() async { if(widget.cams.isEmpty) return; cam=CameraController(widget.cams[camIdx], isHD?ResolutionPreset.high:ResolutionPreset.medium, enableAudio: false); await cam!.initialize(); if(mounted) setState((){}); }
  Future<void> _switchCam() async { camIdx=(camIdx+1)%widget.cams.length; await cam?.dispose(); await _initCam(); }
  void _sendGift(Map g) async { setState((){ activeGift=g; showGift=false; chats.insert(0, "You sent ${g["name"]}"); diamonds-= (g["price"] as int)~/100; if(diamonds<0) diamonds=0; beans+= g["price"] as int; }); giftAnim.forward(from:0); try{ await audio.play(AssetSource('sounds/pop.mp3')); }catch(e){} Future.delayed(const Duration(seconds:3), (){ if(mounted) setState(()=> activeGift=null); }); }
  @override void dispose(){ cam?.dispose(); giftAnim.dispose(); audio.dispose(); super.dispose(); }
  @override Widget build(BuildContext c){ String type=widget.room["type"]; return Scaffold(body: Stack(children: [
    Positioned.fill(child: cam!=null && cam!.value.isInitialized ? ColorFiltered(colorFilter: isBeauty? ColorFilter.matrix([1+beauty*0.2,0,0,0,20*beauty,0,1+beauty*0.1,0,0,20*beauty,0,0,1+beauty*0.1,0,20*beauty,0,0,0,1,0]): const ColorFilter.mode(Colors.transparent, BlendMode.multiply), child: type=="multi"? _multiGrid() : type=="pk"? _pkView() : type=="voice"? _voiceView() : CameraPreview(cam!)): Container(color: Colors.black)),
    _topBar(), if(activeGift!=null) _giftAnimWidget(), _chat(), _bottomBar(), if(showGift) _giftPanel1000(), if(showBeauty) _beautyPanel(),
  ])); }
  Widget _pkView()=> Row(children: [Expanded(child: Stack(children: [CameraPreview(cam!), Positioned(top:50, left:8, child: _badge("WIN x3"))])), Container(width:2, color: Colors.white24), Expanded(child: Container(color: Colors.grey[900], child: const Center(child: Icon(Icons.person, size:60))))]);
  Widget _multiGrid()=> GridView.count(crossAxisCount:3, children: List.generate(9, (i)=> Container(margin: const EdgeInsets.all(1), color: Colors.grey[900], child: i==0 && cam!=null? CameraPreview(cam!): Center(child: Text("User ${i+1}", style: const TextStyle(fontSize:10))))));
  Widget _voiceView()=> Container(color: const Color(0xFF1A1A2E), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.mic, size:60, color: Colors.pink), const SizedBox(height:10), Text(widget.room["name"], style: const TextStyle(fontSize:18, fontWeight: FontWeight.bold)), const Text("Voice Live - Only Audio", style: TextStyle(color: Colors.white54))]))); 
  Widget _badge(String t)=> Container(padding: const EdgeInsets.symmetric(horizontal:6, vertical:2), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(10)), child: Text(t, style: const TextStyle(fontSize:10, fontWeight: FontWeight.bold)));
  Widget _topBar()=> Positioned(top:0, left:0, right:0, child: SafeArea(child: Column(children: [Padding(padding: const EdgeInsets.all(8), child: Row(children: [const CircleAvatar(radius:14, backgroundColor: Colors.orange, child: Icon(Icons.person, size:14)), const SizedBox(width:6), Expanded(child: Text(widget.room["name"], style: const TextStyle(fontSize:12, fontWeight: FontWeight.bold))), IconButton(icon: const Icon(Icons.cameraswitch, size:18), onPressed: _switchCam), IconButton(icon: Icon(isHD? Icons.hd: Icons.sd, size:18, color: isHD? Colors.pink: Colors.white), onPressed: (){ setState(()=> isHD=!isHD); _initCam(); }), Container(padding: const EdgeInsets.symmetric(horizontal:6, vertical:2), decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(10)), child: Text("$beans beans | 💎$diamonds", style: const TextStyle(fontSize:9))), const SizedBox(width:4), GestureDetector(onTap: ()=> Navigator.pop(context), child: const Icon(Icons.close, size:20))]))])));
  Widget _giftAnimWidget()=> Positioned.fill(child: AnimatedBuilder(animation: giftAnim, builder: (c,_){ double v=giftAnim.value; return Stack(alignment: Alignment.center, children: [if(activeGift!["type"]=="car") Transform.translate(offset: Offset(-200+v*400, 0), child: Icon(activeGift!["icon"], size:80, color: activeGift!["color"])), if(activeGift!["type"]=="lion") Transform.scale(scale: v, child: Icon(activeGift!["icon"], size:100, color: activeGift!["color"])), if(activeGift!["type"]=="rose") ...List.generate(10, (i)=> Positioned(bottom: 100+v*300, left: MediaQuery.of(context).size.width/2 + (Random().nextDouble()-0.5)*200, child: Opacity(opacity: 1-v, child: Icon(Icons.local_florist, color: Colors.pink, size:20)))), Center(child: Opacity(opacity: 1-v, child: Text(activeGift!["name"], style: TextStyle(fontSize:22, fontWeight: FontWeight.bold, color: activeGift!["color"]))))]); }));
  Widget _chat()=> Positioned(left:8, bottom:70, right:80, child: SizedBox(height:100, child: ListView.builder(reverse:true, itemCount: chats.length, itemBuilder: (c,i)=> Container(margin: const EdgeInsets.only(bottom:2), padding: const EdgeInsets.symmetric(horizontal:6, vertical:2), decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(6)), child: Text(chats[i], style: const TextStyle(fontSize:10))))));
  Widget _bottomBar()=> Positioned(bottom:0, left:0, right:0, child: SafeArea(child: Padding(padding: const EdgeInsets.all(8), child: Row(children: [ _sIcon(Icons.chat_bubble_outline, (){}), const SizedBox(width:6), _sIcon(Icons.menu, (){}), const SizedBox(width:6), _sIcon(Icons.group, (){}), const SizedBox(width:6), _sIcon(Icons.auto_fix_high, ()=> setState(()=> showBeauty=!showBeauty)), const Spacer(), GestureDetector(onTap: ()=> setState(()=> showGift=true), child: Container(padding: const EdgeInsets.symmetric(horizontal:14, vertical:7), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.pink, Colors.orange]), borderRadius: BorderRadius.circular(20)), child: const Text("Gift 🎁", style: TextStyle(fontSize:11, fontWeight: FontWeight.bold))))]))));
  Widget _sIcon(IconData ic, VoidCallback f)=> GestureDetector(onTap:f, child: Container(padding: const EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle, border: Border.all(color: Colors.white24)), child: Icon(ic, size:13)));
  Widget _giftPanel1000()=> Positioned(bottom:0, left:0, right:0, child: Container(height: 360, decoration: const BoxDecoration(color: Color(0xFF1A1A2E), borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))), child: Column(children: [Padding(padding: const EdgeInsets.all(8), child: Row(children: [Text("Gift Pack - 1000 Gifts | 💎$diamonds 🪙$coins", style: const TextStyle(fontSize:11, fontWeight: FontWeight.bold, color: Colors.amber)), const Spacer(), IconButton(icon: const Icon(Icons.close, size:18), onPressed: ()=> setState(()=> showGift=false))])), Expanded(child: GridView.builder(padding: const EdgeInsets.all(6), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4, childAspectRatio:0.8, crossAxisSpacing:6, mainAxisSpacing:6), itemCount: allGifts.length, itemBuilder: (c,i){ final g=allGifts[i]; return GestureDetector(onTap: ()=> _sendGift(g), child: Container(decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(g["icon"], color: g["color"], size:22), const SizedBox(height:2), Text(g["name"], style: const TextStyle(fontSize:7), maxLines:1, overflow: TextOverflow.ellipsis), Text("${g["price"]}", style: TextStyle(fontSize:7, color: g["color"])), Text(g["cat"], style: const TextStyle(fontSize:6, color: Colors.white38)), Container(margin: const EdgeInsets.only(top:2), padding: const EdgeInsets.symmetric(horizontal:4, vertical:1), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)), child: const Text("Send", style: TextStyle(fontSize:7)))]))); }))]))); }
  Widget _beautyPanel()=> Positioned(bottom:60, left:8, right:8, child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(14)), child: Column(children: [Row(children: [const Icon(Icons.face_retouching_natural, size:14), const SizedBox(width:4), const Text("Beauty HD - Face Saaf + Choty Bal", style: TextStyle(fontSize:10, fontWeight: FontWeight.bold)), const Spacer(), Switch(value: isBeauty, onChanged: (v)=> setState(()=> isBeauty=v), activeColor: Colors.pink)]), Row(children: [const Text("Smooth", style: TextStyle(fontSize:9)), Expanded(child: Slider(value: beauty, min:0, max:1, activeColor: Colors.pink, onChanged: (v)=> setState(()=> beauty=v))), Text("${(beauty*100).toInt()}%", style: const TextStyle(fontSize:9))])]))); 
}

// OTHER TABS - Simplified but functional
class PrivateRoomPage extends StatelessWidget { @override Widget build(BuildContext c){ return Scaffold(appBar: AppBar(title: const Text("Private Room 🔒"), backgroundColor: Colors.black), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.lock, size:50, color: Colors.pink), const SizedBox(height:10), const Text("Private Room - Password Protected"), const SizedBox(height:10), ElevatedButton(onPressed: (){}, child: const Text("Create Private Room - Invite Only")), const Padding(padding: EdgeInsets.all(12), child: TextField(decoration: InputDecoration(hintText: "Enter Room Password", border: OutlineInputBorder(), prefixIcon: Icon(Icons.key))))]))); } }
class FamilyRoomPage extends StatelessWidget { @override Widget build(BuildContext c){ return Scaffold(appBar: AppBar(title: const Text("Family Room 👨‍👩‍👧‍👦"), backgroundColor: Colors.black), body: GridView.count(crossAxisCount:3, children: List.generate(9, (i)=> Card(color: const Color(0xFF1E1E1E), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircleAvatar(child: Text("${i+1}")), Text("Member ${i+1}", style: const TextStyle(fontSize:10)), const Text("Admin/Member", style: TextStyle(fontSize:8, color: Colors.white54)), Row(mainAxisAlignment: MainAxisAlignment.center, children: [IconButton(icon: const Icon(Icons.mic_off, size:14), onPressed: (){}), IconButton(icon: const Icon(Icons.block, size:14), onPressed: (){})])]))))); } }
class VideoPage extends StatelessWidget { @override Widget build(BuildContext c){ return Scaffold(appBar: AppBar(title: const Text("Video Play / Edit / Upload"), backgroundColor: Colors.black), body: ListView(children: [ListTile(leading: const Icon(Icons.video_library, color: Colors.pink), title: const Text("My Videos"), subtitle: const Text("Play, Edit, Trim, Filter"), trailing: ElevatedButton(onPressed: (){}, child: const Text("Upload"))), const Divider(), const Padding(padding: EdgeInsets.all(8), child: Text("Video Editor: Trim, Filter, Music, Text, HD Export", style: TextStyle(fontSize:12))), Wrap(children: [Chip(label: const Text("Trim")), Chip(label: const Text("Filter HD")), Chip(label: const Text("Music")), Chip(label: const Text("Text")), Chip(label: const Text("Upload to Rass"))])])); } }
class MessengerPage extends StatelessWidget { @override Widget build(BuildContext c){ return Scaffold(appBar: AppBar(title: const Text("Messenger - Voice + Gift"), backgroundColor: Colors.black), body: ListView(children: [ListTile(leading: const CircleAvatar(child: Icon(Icons.mic)), title: const Text("Voice Chat Room"), subtitle: const Text("x3 gifting points 29s"), trailing: ElevatedButton(onPressed: (){}, child: const Text("Join"))), const Divider(), ListTile(title: const Text("Gift Request System"), subtitle: const Text("User A requested Lion - Confirm?"), trailing: Row(mainAxisSize: MainAxisSize.min, children: [TextButton(onPressed: (){}, child: const Text("Decline")), ElevatedButton(onPressed: (){}, child: const Text("Confirm"))])), ListTile(leading: const Icon(Icons.voice_chat, color: Colors.pink), title: const Text("Voice Message"), subtitle: const Text("Hold to record voice + Send Gift"))])); } }
class Games30Page extends StatelessWidget { final games=["Ludo","Carrom","Teen Patti","Poker","8 Ball Pool","Car Racing","Fruit Slots","Quiz","Chess","Snake","Billiards","Domino","Rummy","Blackjack","Bingo","Bowling","Archery","Boxing","Football","Cricket","Basketball","Volleyball","Tennis","Golf","Hockey","Racing","Fishing","Hunting","Puzzle","Memory"]; @override Widget build(BuildContext c){ return Scaffold(appBar: AppBar(title: const Text("Games - 30 Best"), backgroundColor: Colors.black), body: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, childAspectRatio:0.9, crossAxisSpacing:8, mainAxisSpacing:8), itemCount: games.length, itemBuilder: (ctx,i){ return Card(color: const Color(0xFF1E1E1E), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.sports_esports, color: Colors.pink, size:30), const SizedBox(height:6), Text(games[i], style: const TextStyle(fontSize:11, fontWeight: FontWeight.bold), textAlign: TextAlign.center), const SizedBox(height:4), ElevatedButton(onPressed: (){}, child: const Text("Play", style: TextStyle(fontSize:9)))])); })); } }
class WalletPage extends StatelessWidget { @override Widget build(BuildContext c){ return Scaffold(appBar: AppBar(title: const Text("Wallet - Diamonds Coins"), backgroundColor: Colors.black), body: Padding(padding: const EdgeInsets.all(12), child: Column(children: [Card(color: const Color(0xFF1E1E1E), child: Padding(padding: const EdgeInsets.all(16), child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Column(children: [const Icon(Icons.diamond, color: Colors.cyan, size:30), const SizedBox(height:4), const Text("Diamonds", style: TextStyl                       
