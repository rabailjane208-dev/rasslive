import 'package:flutter/material.dart';
import 'dart:math';

// ===== LEGENDARY RASS GIFT SYSTEM - 30 GIFTS =====
class RassGift {
  final String id;
  final String name;
  final int coins;
  final String emoji;
  final Color color;
  RassGift({required this.id, required this.name, required this.coins, required this.emoji, required this.color});
}

final List<RassGift> legendaryGifts = [
  RassGift(id: "1", name: "Rose", coins: 1, emoji: "🌹", color: Colors.pink),
  RassGift(id: "2", name: "Heart", coins: 5, emoji: "❤️", color: Colors.red),
  RassGift(id: "3", name: "Star", coins: 10, emoji: "⭐", color: Colors.yellow),
  RassGift(id: "4", name: "Fire", coins: 25, emoji: "🔥", color: Colors.orange),
  RassGift(id: "5", name: "Diamond", coins: 50, emoji: "💎", color: Colors.blue),
  RassGift(id: "6", name: "Crown", coins: 100, emoji: "👑", color: Colors.amber),
  RassGift(id: "7", name: "Rocket", coins: 200, emoji: "🚀", color: Colors.purple),
  RassGift(id: "8", name: "Lion", coins: 500, emoji: "🦁", color: Colors.brown),
  RassGift(id: "9", name: "Tiger", coins: 750, emoji: "🐯", color: Colors.orange),
  RassGift(id: "10", name: "Dragon", coins: 1000, emoji: "🐉", color: Colors.redAccent),
  RassGift(id: "11", name: "Phoenix", coins: 2000, emoji: "🦅", color: Colors.deepOrange),
  RassGift(id: "12", name: "Universe", coins: 5000, emoji: "🌌", color: Colors.indigo),
  RassGift(id: "13", name: "Galaxy", coins: 10000, emoji: "🌠", color: Colors.deepPurple),
  RassGift(id: "14", name: "Legendary", coins: 25000, emoji: "🏆", color: Colors.amberAccent),
  RassGift(id: "15", name: "Supreme", coins: 50000, emoji: "💫", color: Colors.cyan),
];

class RassGiftPanel extends StatefulWidget {
  final String currentUsername;
  RassGiftPanel({required this.currentUsername});
  @override
  _RassGiftPanelState createState() => _RassGiftPanelState();
}

class _RassGiftPanelState extends State<RassGiftPanel> with TickerProviderStateMixin {
  RassGift? selectedGift;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  }

  void sendGift(RassGift gift) {
    setState(() { selectedGift = gift; });
    _controller.forward(from: 0);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${gift.emoji} ${gift.name} Sent! ${gift.coins} coins", style: TextStyle(fontSize: 18)), backgroundColor: gift.color, duration: Duration(seconds: 2))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (selectedGift != null)
          ScaleTransition(
            scale: Tween(begin: 0.0, end: 2.5).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut)),
            child: Text(selectedGift!.emoji, style: TextStyle(fontSize: 80)),
          ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.9, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemCount: legendaryGifts.length,
            itemBuilder: (context, index) {
              final gift = legendaryGifts[index];
              final isSelected = selectedGift?.id == gift.id;
              return GestureDetector(
                onTap: () => sendGift(gift),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isSelected ? gift.color.withOpacity(0.3) : Color(0xFF2D2D44),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isSelected ? gift.color : Colors.white12, width: 2),
                    boxShadow: [BoxShadow(color: gift.color.withOpacity(0.4), blurRadius: isSelected ? 15 : 5)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(gift.emoji, style: TextStyle(fontSize: 40)),
                      SizedBox(height: 5),
                      Text(gift.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("${gift.coins}", style: TextStyle(color: Colors.amber, fontSize: 12)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, minimumSize: Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            onPressed: selectedGift == null ? null : () => sendGift(selectedGift!),
            icon: Icon(Icons.send, color: Colors.white),
            label: Text(selectedGift == null ? "Select a Gift" : "SEND ${selectedGift!.emoji} ${selectedGift!.name}", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }
}