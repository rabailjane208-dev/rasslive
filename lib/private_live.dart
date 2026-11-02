import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class PrivateLiveScreen extends StatefulWidget {
  final String roomID;
  final bool isHost;
  const PrivateLiveScreen({Key? key, required this.roomID, this.isHost = true}) : super(key: key);
  
  @override _PrivateLiveScreenState createState() => _PrivateLiveScreenState();
}

class _PrivateLiveScreenState extends State<PrivateLiveScreen> {
  FaceDetector? _faceDetector;
  List<Face> _faces = [];
  bool isFront = true;
  int selectedFilter = 0;

  List<Map<String, dynamic>> filters = [
    {"name": "None", "icon": "🚫", "emoji": ""},
    {"name": "Dog", "icon": "🐶", "emoji": "🐶"},
    {"name": "Glasses", "icon": "😎", "emoji": "😎"},
    {"name": "Crown", "icon": "👑", "emoji": "👑"},
    {"name": "Heart", "icon": "❤️", "emoji": "❤️"},
    {"name": "Devil", "icon": "😈", "emoji": "😈"},
    {"name": "Clown", "icon": "🤡", "emoji": "🤡"},
  ];

  @override
  void initState() {
    super.initState();
    _faceDetector = FaceDetector(options: FaceDetectorOptions(enableLandmarks: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. ZEGO LIVE CAMERA HD
          ZegoUIKitPrebuiltLiveStreaming(
            appID: 1238213223, // apna appID dalo
            appSign: "3cfba1ba4c90747bdd4e393935381fa216178c528dc70e558fa70fafde0fce9f", // apna appSign dalo
            userID: "user_${DateTime.now().millisecondsSinceEpoch}",
            userName: "Jigar",
            liveID: widget.roomID,
            config: widget.isHost
              ? (ZegoUIKitPrebuiltLiveStreamingConfig.host()
                ..turnOnCameraWhenJoining = true
                ..turnOnMicrophoneWhenJoining = true
                ..useSpeakerWhenJoining = true
                ..cameraFacingFront = isFront
                ..beauty = true)
              : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
          ),

          // 2. SNAPCHAT FILTER OVERLAY
          // Note: Zego ke upar overlay ke liye alag texture chahiye. Filhal emoji se kaam chalao
          ..._faces.map((face) {
            final rect = face.boundingBox;
            return Positioned(
              left: rect.center.dx - 40,
              top: rect.center.dy - 60,
              child: Text(filters[selectedFilter]["emoji"], style: TextStyle(fontSize: 80)),
            );
          }).toList(),

          // 3. TOP BAR
          Positioned(
            top: 40, left: 10, right: 10,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(icon: Icon(Icons.close, color: Colors.white), onPressed: ()=> Navigator.pop(context)),
              Text("Private 1v1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              IconButton(icon: Icon(Icons.cameraswitch, color: Colors.white), onPressed: ()=> setState(()=> isFront = !isFront)),
            ]),
          ),

          // 4. BOTTOM FILTER + CHAT + GIFT
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(color: Colors.black54, padding: EdgeInsets.symmetric(vertical: 15),
              child: Column(children: [
                Container(height: 80, child: ListView.builder(
                  scrollDirection: Axis.horizontal, itemCount: filters.length,
                  itemBuilder: (ctx, i) {
                    bool isSelected = i == selectedFilter;
                    return GestureDetector(onTap: ()=> setState(()=> selectedFilter = i),
                      child: Container(margin: EdgeInsets.symmetric(horizontal: 8), width: 60,
                        decoration: BoxDecoration(color: isSelected ? Colors.pink : Colors.white24, shape: BoxShape.circle,
                        border: Border.all(color: isSelected ? Colors.white : Colors.transparent, width: 2)),
                        child: Center(child: Text(filters[i]["icon"], style: TextStyle(fontSize: 30))),
                      ),
                    );
                  },
                )),
                SizedBox(height: 10),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    Expanded(child: TextField(style: TextStyle(color: Colors.white), 
                      decoration: InputDecoration(hintText: "Comment...", hintStyle: TextStyle(color: Colors.white54), border: OutlineInputBorder()))),
                    SizedBox(width: 10),
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), onPressed: (){}, child: Text("gift")),
                    SizedBox(width: 10),
                    IconButton(icon: Icon(Icons.call_end, color: Colors.red, size: 35), onPressed: ()=> Navigator.pop(context)),
                  ]),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}