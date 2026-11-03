import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

const A = 1238213223;
List<CameraDescription> allCameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await [Permission.camera, Permission.microphone].request();
  try { allCameras = await availableCameras(); } catch (_) {}
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
  int i = 0; int coins = 5000; int diamonds = 1250;
  @override Widget build(BuildContext context) {
    final pages = [
      RassLivePage(onGift: (c){ setState(()=> coins-=c); }, coins: coins),
      PrivateRoomPage(coins: coins, onUse: (c){ setState(()=> coins-=c); }),
      FamilyFullPage(),
      VideoFullPage(onFollow: (){ setState(()=> diamonds+=10); }),
      MessengerFullPage(coins: coins),
      GamesFullPage(coins: coins),
      WalletFullPage(coins: coins),
      ProfileFullPage(diamonds: diamonds),
    ];
    return Scaffold(
      body: pages[i],
      bottomNavigationBar: Container(color: Colors.black, height: 70, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
        nav(0, Icons.live_tv, "RassLive"), nav(1, Icons.lock, "Private"), nav(2, Icons.family_restroom, "Family"), nav(3, Icons.video_library, "Video"),
        nav(4, Icons.mic, "Messen."), nav(5, Icons.videogame_asset, "Games"), nav(6, Icons.wallet, "Wallet"), nav(7, Icons.person, "Profile"),
      ]))),
    );
  }
  Widget nav(int idx, IconData ic, String l){ bool s=i==idx; return InkWell(onTap: ()=> setState(()=> i=idx), child: Container(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6), child: Column(children: [Icon(ic, color: s? Colors.pinkAccent: Colors.white54), Text(l, style: TextStyle(fontSize: 10, color: s? Colors.pinkAccent: Colors.white54))]))) ; }
}

class RassLivePage extends StatelessWidget {
  final Function(int) onGift; final int coins; RassLivePage({required this.onGift, required this.coins});
  final rooms = [{"name": "Rass World", "viewers": "1257", "score": "100"}, {"name": "Rass PK Arena", "viewers": "543", "score": "70", "type": "pk"}, {"name": "9 Stars Multi", "viewers": "321", "score": "60", "type": "multi"}, {"name": "Voice Live", "viewers": "210", "score": "50"}, {"name": "Rass Queen", "viewers": "892", "score": "85"}];
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("RASS LIVE - Score", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)), backgroundColor: Colors.black),
      body: ListView.builder(itemCount: rooms.length, itemBuilder: (c,i){ var r=rooms[i]; return InkWell(onTap: (){ if(r["type"]=="pk") Navigator.push(c, MaterialPageRoute(builder: (_)=> PKArenaFullPage(onGift: onGift))); else Navigator.push(c, MaterialPageRoute(builder: (_)=> LiveFullDetail(name: r["name"]!, viewers: r["viewers"]!, onGift: onGift, coins: coins))); },
        child: Container(margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Row(children: [CircleAvatar(backgroundColor: Colors.pink, child: Text("${i+1}")), SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(r["name"]!, style: TextStyle(fontWeight: FontWeight.bold)), Text("Viewers: ${r["viewers"]} | Score: ${r["score"]} | TAP TO LIVE", style: TextStyle(fontSize: 11, color: Colors.green))])), Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade900, borderRadius: BorderRadius.circular(6)), child: Text("🏆 ${r["score"]}"))]))); }));
  }
}

class LiveFullDetail extends StatefulWidget { final String name, viewers; final Function(int) onGift; final int coins; LiveFullDetail({required this.name, required this.viewers, required this.onGift, required this.coins}); @override _LiveFullDetailState createState()=> _LiveFullDetailState(); }
class _LiveFullDetailState extends State<LiveFullDetail> {
  CameraController? ctrl; bool camInit=false; List<String> comments=["Ali: Kya baat hai!", "Sara: Rass best hai"]; TextEditingController cmt=TextEditingController();
  @override void initState(){ super.initState(); initCam(); }
  initCam() async {
    await [Permission.camera, Permission.microphone].request();
    var front = allCameras.where((c)=> c.lensDirection==CameraLensDirection.front).toList();
    var cam = front.isNotEmpty? front.first: allCameras.first;
    ctrl = CameraController(cam, ResolutionPreset.high, enableAudio: true); await ctrl!.initialize(); setState(()=> camInit=true);
  }
  switchCam() async {
    var isFront = ctrl!.description.lensDirection==CameraLensDirection.front;
    var newList = allCameras.where((c)=> c.lensDirection== (isFront? CameraLensDirection.back: CameraLensDirection.front)).toList();
    if(newList.isEmpty) return;
    ctrl = CameraController(newList.first, ResolutionPreset.high, enableAudio: true); await ctrl!.initialize(); setState((){});
  }
  @override void dispose(){ ctrl?.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) {
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
  void showGiftShop(BuildContext ctx){ showModalBottomSheet(context: ctx, backgroundColor: Color(0xFF121212), builder: (_)=> Container(height: 200, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [giftI("❤️",10), giftI("🌹",50), giftI("👑",100), giftI("🦁",500)]))); }
  Widget giftI(String e, int c)=> InkWell(onTap: (){ widget.onGift(c); Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e Gift Sent - Full Screen Animation!"))); }, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(e, style: TextStyle(fontSize: 30)), Text("$c", style: TextStyle(fontSize: 10, color: Colors.yellow)), Container(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(4)), child: Text("Send", style: TextStyle(fontSize: 8)))]));
}

class PKArenaFullPage extends StatefulWidget { final Function(int) onGift; PKArenaFullPage({required this.onGift}); @override _PKArenaFullPageState createState()=> _PKArenaFullPageState(); }
class _PKArenaFullPageState extends State<PKArenaFullPage> {
  CameraController? ctrl; bool init=false; int timer=66; bool searching=true;
  @override void initState(){ super.initState(); initCam(); Future.delayed(Duration(seconds: 3), ()=> setState(()=> searching=false)); }
  initCam() async { var front=allCameras.where((c)=> c.lensDirection==CameraLensDirection.front).toList(); var cam=front.isNotEmpty? front.first: allCameras.first; ctrl=CameraController(cam, ResolutionPreset.high); await ctrl!.initialize(); setState(()=> init=true); }
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Rass PK Arena — Betting + Inviting"), backgroundColor: Colors.black),
      body: Column(children: [
        Container(color: Colors.pink.shade900, padding: EdgeInsets.all(6), child: Row(children: [Text("WIN x16", style: TextStyle(fontWeight: FontWeight.bold)), Spacer(), Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)), child: Text("VS 01:${timer.toString().padLeft(2,'0')}", style: TextStyle(color: Colors.white))), Spacer(), Text("WIN x11", style: TextStyle(fontWeight: FontWeight.bold))])),
        Expanded(child: Row(children: [
          Expanded(child: Container(color: Colors.black, child: init? FittedBox(fit: BoxFit.cover, child: SizedBox(width: ctrl!.value.previewSize!.height, height: ctrl!.value.previewSize!.width, child: CameraPreview(ctrl!))): Center(child: Text("You — Full Cam")))),
          Container(width: 2, color: Colors.pink),
          Expanded(child: Container(color: Colors.black87, child: Center(child: searching? Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(), SizedBox(height: 8), Text("Searching... Inviting..."), ElevatedButton(onPressed: (){}, child: Text("Invite"))]): Text("Guest — IMPATHAN sent Falcon x2 🦅"))))
        ])),
        Container(padding: EdgeInsets.all(8), color: Color(0xFF1E1E1E), child: Column(children: [Row(children: [Text("Betting:"), SizedBox(width: 8), ElevatedButton(onPressed: (){}, child: Text("50 Coins")), ElevatedButton(onPressed: (){}, child: Text("10 Diamonds")), ElevatedButton(onPressed: (){}, child: Text("Gift 🎁"))]), Text("Entry 50 — Winner 90 — Commission 10% — Marzi se lagao", style: TextStyle(fontSize: 10, color: Colors.yellow))])),
        Container(padding: EdgeInsets.all(8), child: Row(children: [Expanded(child: TextField(decoration: InputDecoration(hintText: "Say Hi..."))), IconButton(icon: Icon(Icons.card_giftcard, color: Colors.yellow), onPressed: ()=> ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Falcon 🦅 Full Screen!"))))]))
      ]),
    );
  }
}

class PrivateRoomPage extends StatefulWidget { final int coins; final Function(int) onUse; PrivateRoomPage({required this.coins, required this.onUse}); @override _PrivateRoomPageState createState()=> _PrivateRoomPageState(); }
class _PrivateRoomPageState extends State<PrivateRoomPage> {
  CameraController? ctrl; bool init=false; List<String> wait=["Ali Khan","Sara"]; String seat2="Empty"; bool camOn=true; bool micOn=true; bool live=false;
  initCam() async { var front=allCameras.where((c)=> c.lensDirection==CameraLensDirection.front).toList(); ctrl=CameraController(front.isNotEmpty? front.first: allCameras.first, ResolutionPreset.high); await ctrl!.initialize(); setState(()=> init=true); }
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Private 1v1 — Request + Camera ON"), backgroundColor: Colors.black),
      body: Column(children: [
        Row(children: [Expanded(child: Container(margin: EdgeInsets.all(8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.pink)), child: Column(children: [CircleAvatar(backgroundColor: Colors.pink, child: Icon(Icons.person)), Text("Host — Full Cam")]))), Expanded(child: Container(margin: EdgeInsets.all(8), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Column(children: [Icon(Icons.person_add), Text(wait.isNotEmpty? "Request: ${wait[0]}": "No Request"), if(wait.isNotEmpty) Row(mainAxisAlignment: MainAxisAlignment.center, children: [TextButton(onPressed: () async { setState(()=> seat2=wait[0]); wait.removeAt(0); await initCam(); setState(()=> live=true); }, child: Text("Approve ✅", style: TextStyle(color: Colors.green))), TextButton(onPressed: (){ setState(()=> wait.removeAt(0)); }, child: Text("Reject ❌", style: TextStyle(color: Colors.red)))])])))]),
        Text("${widget.coins} Coins — Gift Shop + All Buttons Working", style: TextStyle(color: Colors.yellow)),
        Expanded(child: Container(color: Colors.black, child: live&&init? FittedBox(fit: BoxFit.cover, child: SizedBox(width: ctrl!.value.previewSize!.height, height: ctrl!.value.previewSize!.width, child: CameraPreview(ctrl!))): Center(child: Text(live? "Go LIVE — Cam Permission OK": "Approve dabao — Camera ON hoga")))),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [IconButton(icon: Icon(camOn? Icons.videocam: Icons.videocam_off), onPressed: ()=> setState(()=> camOn=!camOn)), IconButton(icon: Icon(micOn? Icons.mic: Icons.mic_off), onPressed: ()=> setState(()=> micOn=!micOn)), IconButton(icon: Icon(Icons.palette), onPressed: (){}), IconButton(icon: Icon(Icons.auto_awesome), onPressed: (){}), IconButton(icon: Icon(Icons.card_giftcard, color: Colors.yellow), onPressed: (){ showModalBottomSheet(context: context, builder: (_)=> Container(height: 200, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [InkWell(onTap: (){ widget.onUse(10); Navigator.pop(context); }, child: Text("❤️ 10")), InkWell(onTap: (){ widget.onUse(5000); Navigator.pop(context); }, child: Text("🐉 5000"))]))); }), ElevatedButton(onPressed: ()=> setState(()=> live=!live), style: ElevatedButton.styleFrom(backgroundColor: live? Colors.grey: Colors.pink), child: Text(live? "END": "Go LIVE"))])
      ]),
    );
  }
}

class FamilyFullPage extends StatefulWidget { @override _FamilyFullPageState createState()=> _FamilyFullPageState(); }
class _FamilyFullPageState extends State<FamilyFullPage> {
  CameraController? ctrl; bool init=false; List<String> seats=["You (Host)","Empty","Empty","Empty","Empty","Empty"]; List<String> req=["Guest_32","Ali Khan"];
  @override void initState(){ super.initState(); initCam(); }
  initCam() async { var front=allCameras.where((c)=> c.lensDirection==CameraLensDirection.front).toList(); ctrl=CameraController(front.isNotEmpty? front.first: allCameras.first, ResolutionPreset.high); await ctrl!.initialize(); setState(()=> init=true); }
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Family Room — 6 Log — Host Full Cam"), backgroundColor: Colors.black),
      body: Column(children: [
        Container(height: 350, child: Stack(children: [Positioned.fill(child: init? FittedBox(fit: BoxFit.cover, child: SizedBox(width: ctrl!.value.previewSize!.height, height: ctrl!.value.previewSize!.width, child: CameraPreview(ctrl!))): Center(child: Text("Host Full Camera"))), Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 90, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: 6, itemBuilder: (c,i)=> Container(width: 70, margin: EdgeInsets.all(4), decoration: BoxDecoration(color: seats[i]=="Empty"? Colors.grey.shade800: Colors.green.shade800, borderRadius: BorderRadius.circular(10)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircleAvatar(radius: 16, child: Icon(Icons.person, size: 16)), Text(seats[i], style: TextStyle(fontSize: 8)), Text(i<2? "Video": "Voice", style: TextStyle(fontSize: 7, color: Colors.green))])))))])),
        if(req.isNotEmpty) Container(color: Color(0xFF1E1E1E), padding: EdgeInsets.all(6), child: Column(children: List.from(req).map((r)=> Row(children: [Text("Join: $r"), Spacer(), TextButton(onPressed: (){ setState(()=> seats[seats.indexOf("Empty")]=r); req.remove(r); }, child: Text("Approve", style: TextStyle(color: Colors.green))), TextButton(onPressed: (){ setState(()=> req.remove(r)); }, child: Text("Reject", style: TextStyle(color: Colors.red))) ])).toList())),
        Row(children: [ElevatedButton(onPressed: (){ setState(()=> req.add("Guest_${req.length+33}")); }, child: Text("Request Bhejo Test")), Spacer(), ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), child: Text("Go LIVE")), IconButton(icon: Icon(Icons.card_giftcard, color: Colors.yellow), onPressed: (){})])
      ]),
    );
  }
}

class VideoFullPage extends StatefulWidget { final VoidCallback onFollow; VideoFullPage({required this.onFollow}); @override _VideoFullPageState createState()=> _VideoFullPageState(); }
class _VideoFullPageState extends State<VideoFullPage> {
  List<Map<String,dynamic>> vids=[{"user":"@RassWorld","desc":"My Rass Live Best — Edit?","likes":2458,"comments":168,"liked":false,"followed":false}];
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Video — Upload Edit Play Follow"), backgroundColor: Colors.black, actions: [IconButton(icon: Icon(Icons.upload), onPressed: (){ setState(()=> vids.insert(0,{"user":"@You","desc":"My video ${vids.length+1} — Edit me","likes":0,"comments":0,"liked":false,"followed":false})); })]),
      body: ListView.builder(itemCount: vids.length, itemBuilder: (c,i){ var v=vids[i]; return Container(margin: EdgeInsets.all(10), height: 450, decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Stack(children: [Center(child: Icon(Icons.play_circle_fill, size: 60, color: Colors.white24)), Positioned(top: 10, left: 10, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(v["user"], style: TextStyle(fontWeight: FontWeight.bold)), InkWell(onTap: (){ showDialog(context: context, builder: (_)=> AlertDialog(title: Text("Edit Caption"), content: TextField(onSubmitted: (txt){ setState(()=> v["desc"]=txt); Navigator.pop(context); })) ); }, child: Text(v["desc"], style: TextStyle(fontSize: 12, color: Colors.yellow)))])), Positioned(right: 10, bottom: 20, child: Column(children: [IconButton(icon: Icon(Icons.favorite, color: v["liked"]? Colors.red: Colors.white54), onPressed: (){ setState(()=> {v["liked"]=!v["liked"], v["likes"]+= v["liked"]?1:-1}); }), Text("${v["likes"]}"), IconButton(icon: Icon(Icons.chat_bubble), onPressed: (){}), Text("${v["comments"]}"), IconButton(icon: Icon(Icons.bookmark), onPressed: (){}), Text("104"), IconButton(icon: Icon(Icons.share), onPressed: (){}), Text("48"), SizedBox(height: 10), InkWell(onTap: (){ setState(()=> v["followed"]=!v["followed"]); if(v["followed"]) widget.onFollow(); }, child: Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: v["followed"]? Colors.grey: Colors.pink, borderRadius: BorderRadius.circular(20)), child: Text(v["followed"]? "Unfollow": "Follow", style: TextStyle(fontSize: 10))))]))])); }),
    );
  }
}

class MessengerFullPage extends StatefulWidget { final int coins; MessengerFullPage({required this.coins}); @override _MessengerFullPageState createState()=> _MessengerFullPageState(); }
class _MessengerFullPageState extends State<MessengerFullPage> {
  List<String> msgs=["Ali: Hi — Confirm me","Sara: Voice bhejo"]; List<String> reqs=["Ali Khan wants to join Private"];
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Messenger — Voice + Request + Gift — ${widget.coins}"), backgroundColor: Colors.black),
      body: Column(children: [
        if(reqs.isNotEmpty) Container(color: Color(0xFF1E1E1E), child: Column(children: reqs.map((r)=> ListTile(title: Text(r), trailing: Row(mainAxisSize: MainAxisSize.min, children: [ElevatedButton(onPressed: (){ setState(()=> reqs.remove(r)); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Confirmed!"))); }, child: Text("Confirm", style: TextStyle(color: Colors.green, fontSize: 10))), SizedBox(width: 4), ElevatedButton(onPressed: (){ setState(()=> reqs.remove(r)); }, child: Text("Reject", style: TextStyle(color: Colors.red, fontSize: 10)))]))).toList())),
        Expanded(child: ListView(children: msgs.map((m)=> Align(alignment: m.startsWith("You")? Alignment.centerRight: Alignment.centerLeft, child: Container(margin: EdgeInsets.all(6), padding: EdgeInsets.all(10), decoration: BoxDecoration(color: m.startsWith("You")? Colors.pink: Colors.white12, borderRadius: BorderRadius.circular(12)), child: Text(m.startsWith("VOICE")? "🎤 Voice Message — Play ▶️": m)))).toList())),
        Container(color: Colors.black, padding: EdgeInsets.all(6), child: Row(children: [IconButton(icon: Icon(Icons.mic, color: Colors.green), onPressed: (){}), IconButton(icon: Icon(Icons.card_giftcard, color: Colors.yellow), onPressed: (){}), Expanded(child: Text("Hold Mic for Voice — Gift bhejo 💝"))]))
      ]),
    );
  }
}

class GamesFullPage extends StatelessWidget { final int coins; GamesFullPage({required this.coins}); final games=["PK Battle","Ludo","Teen Patti","Carrom","8 Ball Pool","Football","Cricket","Bubble Shooter","Snake","Chess","Poker","Rummy","Domino","Solitaire","Tambola","Quiz","Puzzle","Racing","Fighter","Knife Hit","Color Switch","Stack Jump","Archery","Bowling","Basketball","Hockey","Volleyball","Tennis","Boxing","Wrestling"]; @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: Text("Games 30 — Coins ${coins} — Marzi Shart"), backgroundColor: Colors.black), body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.85), itemCount: games.length, itemBuilder: (c,i)=> InkWell(onTap: (){ showModalBottomSheet(context: c, builder: (_)=> Container(height: 250, padding: EdgeInsets.all(12), child: Column(children: [Text(games[i], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), SizedBox(height: 10), Text("Shart lagao — Marzi se — Coins / Diamonds / Gift"), Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [ElevatedButton(onPressed: (){ Navigator.pop(c); ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text("50 Coins Entry — Winner 90 — Wallet se cut"))); }, child: Text("50 Coins")), ElevatedButton(onPressed: (){ Navigator.pop(c); }, child: Text("10 Diamonds")), ElevatedButton(onPressed: (){ Navigator.pop(c); }, child: Text("Gift 🎁"))]), Text("Winner 90% — Hamara 10% commission", style: TextStyle(color: Colors.yellow, fontSize: 11)), ElevatedButton(onPressed: (){ Navigator.pop(c); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text("Play Now"))]))); }, child: Container(margin: EdgeInsets.all(6), decoration: BoxDecoration(color: Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.pink.shade900)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.videogame_asset, color: Colors.pinkAccent), Text(games[i], textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), SizedBox(height: 4), Text("Entry: Coins/Diamond/Gift", style: TextStyle(fontSize: 7, color: Colors.yellow)), Text("Win 90% + Wallet", style: TextStyle(fontSize: 7, color: Colors.green))]))))); } }

class WalletFullPage extends StatefulWidget { final int coins; WalletFullPage({required this.coins}); @override _WalletFullPageState createState()=> _WalletFullPageState(); }
class _WalletFullPageState extends State<WalletFullPage> {
  String country="Pakistan"; Map<String, Map<String,String>> data={"Pakistan":{"curr":"PKR","sym":"Rs","rate":"280"},"USA":{"curr":"USD","sym":"\$","rate":"1"},"UAE":{"curr":"AED","sym":"AED","rate":"3.67"},"Saudi":{"curr":"SAR","sym":"SAR","rate":"3.75"},"UK":{"curr":"GBP","sym":"£","rate":"0.8"},"India":{"curr":"INR","sym":"₹","rate":"83"}};
  @override Widget build(BuildContext context) { var d=data[country]!; return Scaffold(appBar: AppBar(title: Text("Wallet 195 Mulk — ${widget.coins} Coins"), backgroundColor: Colors.black), body: ListView(padding: EdgeInsets.all(12), children: [Container(padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.amber.shade800, borderRadius: BorderRadius.circular(12)), child: Column(children: [Text("${widget.coins} Coins", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)), Text("${d["sym"]} ${(widget.coins*double.parse(d["rate"]!)*0.00792).toStringAsFixed(2)} ${d["curr"]} — $country", style: TextStyle(fontSize: 14)), Text("195 Countries — Alag Currency — Dollar/Dinar/Dirham/Riyal", style: TextStyle(fontSize: 10))])), SizedBox(height: 12), DropdownButton<String>(value: country, isExpanded: true, items: data.keys.map((k)=> DropdownMenuItem(value: k, child: Text("$k — ${data[k]!["curr"]}"))).toList(), onChanged: (v){ setState(()=> country=v!); }), SizedBox(height: 12), Row(children: [Expanded(child: ElevatedButton(onPressed: (){}, child: Text("Stripe 175"))), SizedBox(width: 6), Expanded(child: ElevatedButton(onPressed: (){}, child: Text("JazzCash"))), SizedBox(width: 6), Expanded(child: ElevatedButton(onPressed: (){}, child: Text("Easypaisa")))]), Row(children: [Expanded(child: ElevatedButton(onPressed: (){}, child: Text("PayPal"))), SizedBox(width: 6), Expanded(child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), child: Text("Recharge Now")))]), ListTile(title: Text("Gift History"), subtitle: Text("120 Received 45 Sent — Diamond to Coins Convert"))])); } }
}

class ProfileFullPage extends StatelessWidget { final int diamonds; ProfileFullPage({required this.diamonds}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: Text("Profile — @rass_jigar — Full Details"), backgroundColor: Colors.black), body: ListView(padding: EdgeInsets.all(12), children: [CircleAvatar(radius: 40, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 40)), Center(child: Column(children: [Text("Rass Jigar - Host Mode ON", style: TextStyle(fontWeight: FontWeight.bold)), Text("Level 8 (1250/2000 XP) — 1 List TOP St. 18.5K — 703.6K ❤️ — 3.4K Online", style: TextStyle(fontSize: 11, color: Colors.yellow))])), Divider(), ListTile(leading: Icon(Icons.diamond, color: Colors.pink), title: Text("My Diamonds"), trailing: Text("$diamonds 💎 — Convert to Coins")), ListTile(leading: Icon(Icons.video_library), title: Text("My Videos — 12 Shared"), subtitle: Text("287 Likes | 38K Views | 168 Comments | 6/5284 Level | 11 likes 1K views 3y ago — jaise Moon Awan photo")), ListTile(leading: Icon(Icons.favorite, color: Colors.red), title: Text("Likes — 2458"), subtitle: Text("Kis ne like kiya — list")), ListTile(leading: Icon(Icons.chat_bubble), title: Text("Comments — 168"), subtitle: Text("Comment box — kis ne kya likha — Sara: Rass best hai")), ListTile(leading: Icon(Icons.live_tv, color: Colors.red), title: Text("Live History — Pore jaan kari"), subtitle: Text("Kitni der LIVE — kitne viewers — kitne gifts — PK wins — 26/65 — 3h09m"))])); } }
