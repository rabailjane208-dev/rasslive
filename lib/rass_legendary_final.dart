import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class RassGiftPanel extends StatefulWidget {
  final String currentUsername;
  const RassGiftPanel({required this.currentUsername});

  @override
  State<RassGiftPanel> createState() => _RassGiftPanelState();
}

class _RassGiftPanelState extends State<RassGiftPanel> with TickerProviderStateMixin {
  int level = 1;
  int coins = 1000;
  String lastGift = "Koi gift nahi bheja";
  late AnimationController _controller;

  final List<Map<String, dynamic>> gifts = [
    {"name": "Rose 🌹", "price": 10, "color": Colors.red},
    {"name": "Heart 💖", "price": 50, "color": Colors.pink},
    {"name": "Diamond 💎", "price": 100, "color": Colors.cyan},
    {"name": "Crown 👑", "price": 500, "color": Colors.amber},
    {"name": "Lion 🦁 LEGENDARY", "price": 1000, "color": Colors.deepPurple},
    {"name": "Universe 🌌 GOD", "price": 5000, "color": Colors.black},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  }

  void sendGift(Map<String, dynamic> gift) {
    if (coins >= gift["price"]) {
      setState(() {
        coins -= gift["price"] as int;
        level++;
        lastGift = "${gift["name"]} bheja! 🔥";
      });
      _controller.forward(from: 0);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${gift["name"]} Sent! Mashallah Jigar!"), backgroundColor: gift["color"])
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Coins khatam! Recharge karo jigar!"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.purple.shade900, Colors.black], begin: Alignment.topCenter, end: Alignment.bottomCenter)
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("JIGAR: ${widget.currentUsername}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Row(children: [
                  Icon(Icons.monetization_on, color: Colors.amber),
                  SizedBox(width: 4),
                  Text("$coins", style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(width: 16),
                  Text("LVL $level 🔥", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                ])
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(lastGift, style: TextStyle(color: Colors.white70, fontSize: 14)),
          ),
          ScaleTransition(
            scale: Tween(begin: 0.8, end: 1.2).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut)),
            child: Icon(Icons.star, size: 60, color: Colors.amber),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemCount: gifts.length,
              itemBuilder: (context, i) {
                final g = gifts[i];
                return InkWell(
                  onTap: () => sendGift(g),
                  child: Container(
                    decoration: BoxDecoration(color: g["color"], borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(g["name"], textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 8),
                        Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(20)), child: Text("${g["price"]} coins", style: TextStyle(color: Colors.amber, fontSize: 12)))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(padding: EdgeInsets.all(12), child: Text("RASS LIVE LEGENDARY SYSTEM ACTIVATED 🚀", style: TextStyle(color: Colors.white24, fontSize: 10)))
        ],
      ),
    );
  }
}