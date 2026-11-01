import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class QueenLiveScreen extends StatefulWidget {
  const QueenLiveScreen({super.key});
  @override
  State<QueenLiveScreen> createState() => _QueenLiveScreenState();
}

class _QueenLiveScreenState extends State<QueenLiveScreen> {
  CameraController? ctrl;
  bool ready = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      await Permission.camera.request();
      await Permission.microphone.request();
      final cams = await availableCameras();
      ctrl = CameraController(cams.isNotEmpty ? cams[0] : cams[0], ResolutionPreset.medium, enableAudio: true);
      await ctrl!.initialize();
      if (mounted) setState(() => ready = true);
    } catch (e) {}
  }

  @override
  void dispose() {
    ctrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, title: const Text("Queen Live 👑", style: TextStyle(color: Colors.white))),
      body: Stack(children: [
        Positioned.fill(child: ready && ctrl != null && ctrl!.value.isInitialized ? FittedBox(fit: BoxFit.cover, child: SizedBox(width: ctrl!.value.previewSize!.width, height: ctrl!.value.previewSize!.height, child: CameraPreview(ctrl!))) : const Center(child: CircularProgressIndicator(color: Colors.pink))),
        Positioned(top: 10, left: 10, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)), child: const Text("Queen Live 👑  LIVE  Viewers 892", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
      ]),
    );
  }
}