import 'package:flutter/material.dart';
import 'dart:math';

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
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF1A1A2E)),
      home: LegendaryHomePage(),
    );
  }
}

class LegendaryHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RASS LIVE LEGENDARY 🔥"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Rass10Panel(currentUsername: "Jigar"),
    );
  }
}

class Rass10Panel extends StatefulWidget {
  final String currentUsername;
  Rass10Panel({required this.currentUsername});
  @override
  State<Rass10Panel> createState() => _Rass10PanelState();
}

class _Rass10PanelState extends State<Rass10Panel> with TickerProviderStateMixin {
  String text = "Koi gift nahi bheja";
  late AnimationController controller;

  final List<Map<String, dynamic>> gifts = [
    {"name": "Rose", "price": 10, "color": Colors.red},
    {"name": "Diamond", "price": 100, "color": Colors.cyan},
    {"name": "Crown", "price": 500, "color": Colors.amber},
    {"name": "Lion", "price": 1000, "color": Colors.deepPurple},
    {"name": "Universe", "price": 5000, "color": Colors.black},
  ];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void sendGift(Map<String, dynamic> gift) {
    int price = gift["price"] as int;
    setState(() {
      text = "${gift['name']} bheja 🔥";
    });
    controller.forward(from: 0);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${gift['name']} Sent! Mashallah Jigar!"),
        backgroundColor: gift["color"],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple.shade900, Colors.black]),
          ),
          child: Column(
            children: [
              Text("RASS LIVE LEGENDARY 🔥", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text("Welcome ${widget.currentUsername}", style: TextStyle(color: Colors.amber)),
              SizedBox(height: 8),
              Text(text, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        // Gifts Grid
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.2),
            itemCount: gifts.length,
            itemBuilder: (context, index) {
              final gift = gifts[index];
              return Card(
                color: gift["color"],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: InkWell(
                  onTap: () => sendGift(gift),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.card_giftcard, size: 40, color: Colors.white),
                      SizedBox(height: 8),
                      Text(gift["name"], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("${gift["price"]} coins", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
