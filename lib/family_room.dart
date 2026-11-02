import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';


class FamilyRoomScreen extends StatefulWidget {
  final String roomID; final String userID; final String userName; final bool isHost;
  const FamilyRoomScreen({super.key, required this.roomID, required this.userID, required this.userName, this.isHost = true});
  @override
  State<FamilyRoomScreen> createState() => _FamilyRoomScreenState();
}


class _FamilyRoomScreenState extends State<FamilyRoomScreen> {
  final TextEditingController commentController = TextEditingController();
  List<String> comments = []; int likeCount = 0; int walletBalance = 0;
  List<Map<String, dynamic>> seats = List.generate(6, (i) => {"id": i+1, "user": null, "request": false});
  bool micOn = true; bool beauty = true; bool isFront = true;
  @override void dispose(){ commentController.dispose(); super.dispose(); }
  void sendComment(){ if(commentController.text.trim().isNotEmpty){ setState((){ comments.insert(0, "${widget.userName}: ${commentController.text.trim()}"); commentController.clear(); }); } }
  void addLike()=> setState(()=> likeCount++);
  void sendGift(int coins){ setState(()=> walletBalance += coins); }
  void requestSeat(int i)=> setState(()=> seats[i]["request"] = true);
  void confirmRequest(int i)=> setState(()=> { seats[i]["user"] = "User${i+1}", seats[i]["request"] = false });
  @override Widget build(BuildContext context){
    return Scaffold(backgroundColor: const Color(0xFF000000),
      body: Stack(children: [
        ZegoUIKitPrebuiltLiveStreaming(appID: 123456789, appSign: "YOUR_APP_SIGN_HERE", userID: widget.userID, userName: widget.userName, liveID: widget.roomID,
          config: (widget.isHost ? ZegoUIKitPrebuiltLiveStreamingConfig.host() : ZegoUIKitPrebuiltLiveStreamingConfig.audience())
            ..turnOnCameraWhenJoining = true ..turnOnMicrophoneWhenJoining = micOn ..useFrontFacingCamera = isFront),
        Positioned(top: 45, left: 0, right: 0, child: Center(child: Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)), child: const Text("RASS LIVE - Family", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold))))),
        Positioned(top: 80, left: 10, right: 10, bottom: 170, child: Column(children: [
          GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.85, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: 6,
            itemBuilder: (ctx,i){ var seat=seats[i]; return Container(decoration: BoxDecoration(color: Colors.grey[900]!.withOpacity(0.9), borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFE91E63).withOpacity(0.5))),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Stack(children: [CircleAvatar(radius: 28, backgroundColor: const Color(0xFFE91E63), child: Text("${seat['id']}", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                  if(seat['user']==null) const Positioned(right: 0, top: 0, child: Icon(Icons.lock, color: Colors.white, size: 14)),
                  if(seat['user']!=null) Positioned(bottom: 0, right: 0, child: Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)), child: const Text("LIVE", style: TextStyle(fontSize: 7, color: Colors.white))))]),
                const SizedBox(height: 5), Text(seat['user'] ?? "Empty", style: const TextStyle(color: Colors.white, fontSize: 11)),
                if(seat['user']==null && !widget.isHost) InkWell(onTap: ()=> requestSeat(i), child: const Text("Request", style: TextStyle(color: Color(0xFFE91E63), fontSize: 10))),
                if(seat['request']==true && widget.isHost) ElevatedButton(onPressed: ()=> confirmRequest(i), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(60,22)), child: const Text("Confirm", style: TextStyle(fontSize: 10))),
              ]));}),
          const SizedBox(height: 10),
          Expanded(child: ListView.builder(reverse: true, itemCount: comments.length, itemBuilder: (ctx,idx)=> Container(margin: const EdgeInsets.only(bottom: 4), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(12)), child: Text(comments[idx], style: const TextStyle(color: Colors.white, fontSize: 12))))),
        ])),
        Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black87, padding: const EdgeInsets.fromLTRB(10,8,10,15),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(height: 55, child: ListView(scrollDirection: Axis.horizontal, children: [10,50,100,500,1000].map((coin)=> GestureDetector(onTap: ()=> sendGift(coin),
              child: Container(margin: const EdgeInsets.symmetric(horizontal: 6), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: const Color(0xFF4A0F2A), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.pink)),
                child: Column(children: [const Icon(Icons.card_giftcard, color: Colors.pink, size: 18), Text("$coin", style: const TextStyle(color: Colors.white, fontSize: 11))])))).toList())),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: TextField(controller: commentController, style: const TextStyle(color: Colors.white, fontSize: 14), decoration: InputDecoration(hintText: "Comment...", hintStyle: const TextStyle(color: Colors.white54, fontSize: 13), filled: true, fillColor: Color(0xFF212121), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10)), onSubmitted: (_)=> sendComment())),
              IconButton(icon: const Icon(Icons.send, color: Color(0xFFE91E63)), onPressed: sendComment),
              Column(children: [IconButton(icon: const Icon(Icons.favorite, color: Colors.red, size: 22), onPressed: addLike, padding: EdgeInsets.zero, constraints: const BoxConstraints()), Text("$likeCount", style: const TextStyle(color: Colors.white, fontSize: 10))]),
              IconButton(icon: Icon(micOn ? Icons.mic : Icons.mic_off, color: Colors.white, size: 20), onPressed: ()=> setState(()=> micOn = !micOn)),
              IconButton(icon: const Icon(Icons.cameraswitch, color: Colors.white, size: 20), onPressed: ()=> setState(()=> isFront = !isFront)),
              IconButton(icon: Icon(Icons.face_retouching_natural, color: beauty ? Colors.pink : Colors.white, size: 20), onPressed: ()=> setState(()=> beauty = !beauty)),
            ]),
            const SizedBox(height: 2), Text("Wallet: $walletBalance coins", style: const TextStyle(color: Colors.white54, fontSize: 10)),
          ]))),
      ]),
    );
  }
}