import 'package:permission_handler/permission_handler.dart';
class ZegoHelper {
  static const int appId = 1238213223;
  static const String appSign = "3cfba1ba4c90747bdd4e393935381fa216178c528dc70e558fa70fafde0fce9f";
  static Future<void> init() async {
    try {
      await [Permission.camera, Permission.microphone].request();
    } catch(e) {}
  }
}
