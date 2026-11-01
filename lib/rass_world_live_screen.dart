import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class RassWorldLiveScreen extends StatelessWidget {
  final String roomID;
  final String userID;
  final String userName;

  const RassWorldLiveScreen({super.key, this.roomID = "rassworld", this.userID = "user1", this.userName = "Rass Jigar"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ZegoUIKitPrebuiltLiveStreaming(
            appID: 1238213223,
            appSign: "3cfba1ba4c90747bdd4e393935381fa216178c528dc70e558fa70fafde0fce9f",
            userID: userID,
            userName: userName,
            liveID: roomID,
            config: ZegoUIKitPrebuiltLiveStreamingConfig.host()
              ..turnOnCameraWhenJoining = true
              ..turnOnMicrophoneWhenJoining = true
              ..useSpeakerWhenJoining = true
              ..cameraFacingFront = true,
          ),
          // Top bar
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Rass World LIVE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("Score: 752718 vs 338881", style: TextStyle(color: Colors.red, fontSize: 16)),
                  Text("WIN x3 | 1:40", style: TextStyle(color: Colors.yellow)),
                ],
              ),
            ),
          ),
          // Center x3 gifting points bar
          Positioned(
            top: 100,
            left: 80,
            right: 80,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
              child: const Center(child: Text("x3 gifting points 29s", style: TextStyle(color: Colors.white))),
            ),
          ),
          // Right side buttons
          Positioned(
            right: 10,
            bottom: 120,
            child: Column(
              children: [
                _iconBtn(Icons.favorite, "32K"),
                _iconBtn(Icons.comment, "341"),
                _iconBtn(Icons.bookmark, "Save"),
                _iconBtn(Icons.share, "Share"),
                _iconBtn(Icons.card_giftcard, "Gift", onTap: () => _showGiftPanel),
              ],
            ),
          ),
          // Bottom bar
          Positioned(
            left: 10,
            right: 10,
            bottom: 20,
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Add comment...",
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.black45,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide.none),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.pink,
                  child: IconButton(icon: const Icon(Icons.card_giftcard, color: Colors.white), onPressed: _showGiftPanel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, String label, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          IconButton(icon: Icon(icon, color: Colors.white, size: 28), onPressed: onTap),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  void _showGiftPanel() {
    // Gift panel - placeholder
  }
}