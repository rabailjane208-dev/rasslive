import 'package:flutter/material.dart';
import 'rass_legendary_final.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RassLiveLegendaryApp());
}

class RassLiveLegendaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RASS LIVE LEGENDARY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Color(0xFF1A1A2E)),
      home: LegendaryHomePage(),
    );
  }
}

class LegendaryHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RASS LIVE LEGENDARY 🔥"), backgroundColor: Colors.purple),
      body: RassGiftPanel(currentUsername: "Jigar"),
    );
  }
}