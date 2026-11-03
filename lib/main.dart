import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:record/record.dart';
import 'dart:io';

const A = 1238213223;
List<CameraDescription> C = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await [Permission.camera, Permission.microphone].request();
  try { C = await availableCameras(); } catch (_) {}
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override Widget build(BuildContext context) => MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark(), home: const Tabs());
}

class Tabs extends StatefulWidget {
  const Tabs({super.key});
  @override State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int i = 0;
  int coins = 5000; int diamonds = 1250;
  @override Widget build(BuildContext context) {
    final pages = [
      RassLiveScorePage(onGift: (c){ setState(()=> coins-=c); }),
      PrivateRoomPage(coins: coins, onCoinUse: (c){ setState(()=> coins-=c); }),
      FamilyRoomPage(),
      VideoFeedPage(onFollow: (){ setState(()=> diamonds+=10); }),
      MessengerPage(coins: coins),
      GamesPageFull(coins: coins),
      WalletPage(coins: coins),
      ProfilePage(diamonds: diamonds),
    ];
    return Scaffold(
      body: pages[i],
      bottomNavigationBar: Container(color: Colors.black, height: 70, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
        navItem(0, Icons.live_tv, "RassLive"), navItem(1, Icons.lock, "Private"), navItem(2, Icons.family_restroom, "Family"), navItem(3, Icons.video_library, "Video"),
        navItem(4, Icons.mic, "Messen."), navItem(5, Icons.videogame_asset, "Games"), navItem(6, Icons.wallet, "Wallet"), navItem(7, Icons.person, "Profile"),
      ]))),
    );
  }
  Widget navItem(int idx, IconData ic, String label){
    bool sel = i==idx;
    return InkWell(onTap: ()=> setState(()=> i=idx), child: Container(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6), child: Column(children: [
      Icon(ic, color: sel? Colors.pinkAccent: Colors.white54), Text(label, style: TextStyle(fontSize: 10, color: sel? Colors.pinkAccent: Colors.white54))
    ])));
  }
}

class RassLiveScorePage extends StatelessWidget {
  final Function(int) onGift; RassLiveScorePage({required this.onGift});
  final rooms = [
    {"name": "Rass World", "viewers": "1257", "score": "100"},
    {"name": "Rass PK Arena", "viewers": "543", "score": "70"},
    {"name": "9 Stars Multi", "viewers": "321", "score": "60"},
    {"name": "Voice Live", "viewers": "210", "score": "50"},
    {"name": "Rass Queen", "viewers": "892", "score": "85"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("RASS LIVE - Score", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)), backgroundColor: Colors.black),
      body: ListView.builder(itemCount: rooms.length, itemBuilder: (c,i){
        var r=rooms[i];
        return InkWell(onTap: (){ Navigator.push(c, MaterialPageRoute(builder: (_)=> LiveRoomDetail(name: r["name"]!, viewers: r["viewers"]!, onGift: onGift))); },
          child: Container(margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Row(children: [
            CircleAvatar(backgroundColor: Colors.pink, child: Text("${i+1}")),
            SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(r["name"]!, style: TextStyle(fontWeight: FontWeight.bold)), Text("Viewers: ${r["viewers"]} | Score: ${r["score"]} | TAP TO LIVE", style: TextStyle(fontSize: 11, color: Colors.green))])),
            giftChip("🏆 ${r["score"]}"),
          ])),
        );
      }),
    );
  }
  Widget giftChip(String t)=> Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade900, borderRadius: BorderRadius.circular(4)), child: Text(t, style: TextStyle(fontSize: 10)));
}

class LiveRoomDetail extends StatefulWidget { final String name, viewers; final Function(int) onGift; LiveRoomDetail({required this.name, required this.viewers, required this.onGift}); @override _LiveRoomDetailState createState()=> _LiveRoomDetailState(); }
class _LiveRoomDetailState extends State<LiveRoomDetail> {
  CameraController? ctrl; bool camInit=false; List<String> comments=["Ali: Kya baat hai!", "Sara: Rass best hai"]; TextEditingController cmt=TextEditingController();
  @override
  void initState(){ super.initState(); initCam(); }
  initCam() async {
    await [Permission.camera, Permission.microphone].request();
    var front = C.where((c)=> c.lensDirection==CameraLensDirection.front).toList();
    var cam = front.isNotEmpty? front.first: C.first;
    ctrl = CameraController(cam, ResolutionPreset.high, enableAudio: true); await ctrl!.initialize(); setState(()=> camInit=true);
  }
  switchCam() async {
    var isFront = ctrl!.description.lensDirection==CameraLensDirection.front;
    var newList = C.where((c)=> c.lensDirection== (isFront? CameraLensDirection.back: CameraLensDirection.front)).toList();
    if(newList.isEmpty) return;
    ctrl = CameraController(newList.first, ResolutionPreset.high, enableAudio: true); await ctrl!.initialize(); setState((){});
  }
  @override
  void dispose(){ ctrl?.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.name), backgroundColor: Colors.black, actions: [IconButton(icon: Icon(Icons.cameraswitch), onPressed: switchCam)]),
      body: Column(children: [
        Container(height: 320, color: Colors.black, child: camInit? CameraPreview(ctrl!): Center(child: CircularProgressIndicator())),
        Expanded(child: ListView(children: comments.map((c)=> ListTile(dense: true, title: Text(c, style: TextStyle(fontSize: 12)))).toList())),
        Row(children: [Expanded(child: TextField(controller: cmt, decoration: InputDecoration(hintText: "Say Hi in RassLive...", contentPadding: EdgeInsets.symmetric(horizontal: 12)))), IconButton(icon: Icon(Icons.card_giftcard, color: Colors.yellow), onPressed: ()=> showGiftShop(context)), IconButton(icon: Icon(Icons.send, color: Colors.pink), onPressed: (){ if(cmt.text.isNotEmpty){ setState(()=> comments.add("You: ${cmt.text}")); cmt.clear(); } })]),
        Container(padding: EdgeInsets.symmetric(vertical: 6), color: Colors.black, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [tool("Seats","🪑"), tool("Theme","🎨"), tool("Beauty","✨"), tool("Magic","🪄"), tool("Gift","🎁"), tool("SCORE","🏆")])),
      ]),
    );
  }
  Widget tool(String t, String e)=> Column(children: [Text(e, style: TextStyle(fontSize: 16)), Text(t, style: TextStyle(fontSize: 9, color: Colors.white54))]);
  void showGiftShop(BuildContext ctx){
    showModalBottomSheet(context: ctx, backgroundColor: Color(0xFF121212), builder: (_)=> Container(height: 200, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [giftI("❤️",10), giftI("🌹",50), giftI("👑",100), giftI("🦁",500)])));
  }
  Widget giftI(String e, int c)=> InkWell(onTap: (){ widget.onGift(c); Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e Gift Sent - Full Screen Animation!"))); }, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(e, style: TextStyle(fontSize: 30)), Text("$c", style: TextStyle(fontSize: 10, color: Colors.yellow)), Container(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(4)), child: Text("Send", style: TextStyle(fontSize: 8)))]));
}

class PrivateRoomPage extends StatefulWidget { final int coins; final Function(int) onCoinUse; PrivateRoomPage({required this.coins, required this.onCoinUse}); @override _PrivateRoomPageState createState()=> _PrivateRoomPageState(); }
class _PrivateRoomPageState extends State<PrivateRoomPage> {
  String seat1="Host"; String seat2="Empty"; List<String> waiting=["Ali Khan","Sara"]; bool camOn=true; bool micOn=true; bool isLive=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Private 1v1 Room - Hidden + Voice + Gift"), backgroundColor: Colors.black),
      body: Column(children: [
        Row(children: [
          Expanded(child: Container(margin: EdgeInsets.all(8), padding: EdgeInsets.all(14), decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.pink)), child: Column(children: [CircleAvatar(backgroundColor: Colors.pink, child: Icon(Icons.person)), Text(seat1)]))),
          Expanded(child: Container(margin: EdgeInsets.all(8), padding: EdgeInsets.all(14), decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Column(children: [Icon(Icons.person_add), Text(waiting.isNotEmpty? "Request: ${waiting[0]}": "No Request"), if(waiting.isNotEmpty) Row(mainAxisAlignment: MainAxisAlignment.center, children: [TextButton(onPressed: (){ setState(()=> seat2=waiting[0]); waiting.removeAt(0); }, child: Text("Approve", style: TextStyle(color: Colors.green))), TextButton(onPressed: (){ setState(()=> waiting.removeAt(0)); }, child: Text("Reject", style: TextStyle(color: Colors.red)))])]))),
        ]),
        Text("${widget.coins} Coins - Gift Shop Andar Hai", style: TextStyle(color: Colors.yellow)),
        Expanded(child: Container(color: Colors.black87, child: Center(child: Text(isLive? "LIVE - Cam ${camOn? "ON": "OFF"} - Front/Back Permission OK": "Go LIVE dabao - Camera permission granted", style: TextStyle(color: Colors.white54))))),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(icon: Icon(camOn? Icons.videocam: Icons.videocam_off), onPressed: ()=> setState(()=> camOn=!camOn)),
          IconButton(icon: Icon(micOn? Icons.mic: Icons.mic_off), onPressed: ()=> setState(()=> micOn=!micOn)),
          IconButton(icon: Icon(Icons.card_giftcard, color: Colors.yellow), onPressed: ()=> showGiftSheet(context)),
          ElevatedButton(onPressed: ()=> setState(()=> isLive=!isLive), style: ElevatedButton.styleFrom(backgroundColor: isLive? Colors.grey: Colors.pink), child: Text(isLive? "END": "Go LIVE")),
        ]),
      ]),
    );
  }
  void showGiftSheet(BuildContext ctx){ showModalBottomSheet(context: ctx, backgroundColor: Color(0xFF121212), builder: (_)=> Container(height: 200, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [giftI("❤️",10), giftI("🌹",50), giftI("👑",100), giftI("🦁",500)]))); }
  Widget giftI(String e, int c)=> InkWell(onTap: (){ widget.onCoinUse(c); Navigator.pop(context); }, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(e, style: TextStyle(fontSize: 30)), Text("$c", style: TextStyle(fontSize: 10, color: Colors.yellow)), Container(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(4)), child: Text("Send", style: TextStyle(fontSize: 8)))]));
}

class FamilyRoomPage extends StatefulWidget { @override _FamilyRoomPageState createState()=> _FamilyRoomPageState(); }
class _FamilyRoomPageState extends State<FamilyRoomPage> {
  List<String> seats=["You (Host)","Empty","Empty","Empty","Empty","Empty"]; List<String> requests=["Guest_32","Ali Khan"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Family Room - 6 Log - 2 Video + 4 Voice"), backgroundColor: Colors.black),
      body: Column(children: [
        Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.2), itemCount: 6, itemBuilder: (c,i)=> Container(margin: EdgeInsets.all(6), decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.pink)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircleAvatar(child: Icon(i==0? Icons.person: Icons.person_add)), Text(seats[i], style: TextStyle(fontSize: 11)), Text(i<2? "Video+Voice": "Voice Only", style: TextStyle(fontSize: 8, color: Colors.green)), if(seats[i]=="Empty") ElevatedButton(onPressed: (){ if(requests.isNotEmpty){ setState(()=> seats[i]=requests[0]); requests.removeAt(0); } }, child: Text("Invite", style: TextStyle(fontSize: 9))) ])))),
        if(requests.isNotEmpty) Container(color: Color(0xFF1E1E1E), padding: EdgeInsets.all(8), child: Column(children: List.from(requests).map((r)=> Row(children: [Text("Join: $r"), Spacer(), TextButton(onPressed: (){ setState(()=> requests.remove(r)); }, child: Text("Approve", style: TextStyle(color: Colors.green))), TextButton(onPressed: (){ setState(()=> requests.remove(r)); }, child: Text("Reject", style: TextStyle(color: Colors.red))) ])).toList())),
        Row(children: [ElevatedButton(onPressed: (){ setState(()=> requests.add("Guest_${requests.length+33}")); }, child: Text("Request Bhejo Test")), Spacer(), ElevatedButton(onPressed: (){}, child: Text("Go LIVE"))]),
      ]),
    );
  }
}

class VideoFeedPage extends StatefulWidget { final VoidCallback onFollow; VideoFeedPage({required this.onFollow}); @override _VideoFeedPageState createState()=> _VideoFeedPageState(); }
class _VideoFeedPageState extends State<VideoFeedPage> {
  List<Map<String,dynamic>> videos=[{"user":"@RassWorld","desc":"My Rass Live Best","likes":12500,"liked":false}];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Rass Videos - Upload Edit Play"), backgroundColor: Colors.black, actions: [IconButton(icon: Icon(Icons.upload), onPressed: (){ setState(()=> videos.insert(0,{"user":"@You","desc":"My video ${videos.length+1}","likes":0,"liked":false})); })]),
      body: ListView.builder(itemCount: videos.length, itemBuilder: (c,i){ var v=videos[i]; return Container(margin: EdgeInsets.all(10), height: 400, decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Stack(children: [const Center(child: Icon(Icons.play_circle_fill, size: 60, color: Colors.white24)), Positioned(top: 10, left: 10, child: Text(v["user"], style: TextStyle(fontWeight: FontWeight.bold))), Positioned(bottom: 20, left: 10, child: Text(v["desc"])), Positioned(right: 10, bottom: 20, child: Column(children: [IconButton(icon: Icon(Icons.favorite, color: v["liked"]? Colors.red: Colors.white54), onPressed: (){ setState(()=> {v["liked"]=!v["liked"], v["likes"]+= v["liked"]? 1: -1}); }), Text("${v["likes"]}")]))])); }),
    );
  }
}
class MessengerPage extends StatefulWidget { final int coins; MessengerPage({required this.coins}); @override _MessengerPageState createState()=> _MessengerPageState(); }
class _MessengerPageState extends State<MessengerPage> {
  List<String> msgs=["Ali: Hi","Sara: Voice bhejo"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Messenger - Voice Only + Gift - ${widget.coins} Coins"), backgroundColor: Colors.black),
      body: Column(children: [
        Expanded(child: ListView(children: msgs.map((m)=> Align(alignment: m.startsWith("You")? Alignment.centerRight: Alignment.centerLeft, child: Container(margin: EdgeInsets.all(6), padding: EdgeInsets.all(10), decoration: BoxDecoration(color: m.startsWith("You")? Colors.pink: Colors.white12, borderRadius: BorderRadius.circular(12)), child: Text(m.startsWith("VOICE")? "🎤 Voice Message": m)))).toList())),
        Row(children: [
          IconButton(icon: Icon(Icons.mic, color: Colors.green), onPressed: (){}),
          IconButton(icon: Icon(Icons.card_giftcard, color: Colors.yellow), onPressed: (){}),
          Expanded(child: Text("Hold Mic for Voice")),
        ])
      ]),
    );
  }
}
class GamesPageFull extends StatelessWidget { final int coins; GamesPageFull({required this.coins}); final games=["PK Battle","Ludo","Teen Patti","Carrom","8 Ball Pool","Football","Cricket","Bubble Shooter","Snake","Chess","Poker","Rummy","Domino","Solitaire","Tambola","Quiz","Puzzle","Racing","Fighter","Knife Hit","Color Switch","Stack Jump","Archery","Bowling","Basketball","Hockey","Volleyball","Tennis","Boxing","Wrestling"]; @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: Text("Games 30 - Coins ${coins} - Commission 10%"), backgroundColor: Colors.black), body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemCount: games.length, itemBuilder: (c,i)=> Container(margin: EdgeInsets.all(6), decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.videogame_asset, color: Colors.pinkAccent), Text(games[i], textAlign: TextAlign.center, style: TextStyle(fontSize: 11)), Text("Entry 50", style: TextStyle(fontSize: 9, color: Colors.yellow)), Text("Win 90", style: TextStyle(fontSize: 9, color: Colors.green))])))); } }
class WalletPage extends StatelessWidget { final int coins; WalletPage({required this.coins}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: Text("RASS WORLD WALLET - 195 Mulk"), backgroundColor: Colors.black), body: ListView(padding: EdgeInsets.all(12), children: [Container(padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.amber.shade800, borderRadius: BorderRadius.circular(12)), child: Column(children: [Text("$coins", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)), Text("Coins - \$${(coins*0.00792).toStringAsFixed(2)} - 195 Countries Cards Accepted")])), ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), child: Text("Recharge via Stripe - All Cards"))])); } }
class ProfilePage extends StatelessWidget { final int diamonds; ProfilePage({required this.diamonds}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: Text("Profile - @rass_jigar - Best"), backgroundColor: Colors.black), body: ListView(padding: EdgeInsets.all(12), children: [CircleAvatar(radius: 40, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 40)), Center(child: Text("Rass Jigar - Host Mode ON - Level 18.5K", style: TextStyle(fontWeight: FontWeight.bold))), Center(child: Text("LEVEL 8 🔥 1250/2000 XP", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))), SizedBox(height: 12), SwitchListTile(title: Text("Host Mode"), subtitle: Text("Live jaane ke liye ON karo"), value: true, onChanged: (v){}), ListTile(leading: Icon(Icons.diamond, color: Colors.pink), title: Text("My Diamonds"), trailing: Text("$diamonds 💎")), ListTile(leading: Icon(Icons.video_library), title: Text("My Videos - 12 Shared - Likes 287 - Comments 1.2K - Views 38K")), ListTile(leading: Icon(Icons.leaderboard), title: Text("Level - 1 List TOP - XP 1000 Needed"))])); } }