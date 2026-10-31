import 'package:flutter/material.dart';

class NineStarsMultiScreen extends StatelessWidget {
  const NineStarsMultiScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8), child: Text("9 Stars Multi LIVE", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 18))),
          const Padding(padding: EdgeInsets.all(4), child: Text("2400 watching  Rank #12", style: TextStyle(color: Colors.amber))),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(8),
              children: List.generate(9, (i) => Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: const Color(0xFF1a1a1a), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (i == 0) const Icon(Icons.emoji_events, color: Colors.amber, size: 24),
                    Text("User ${i + 1}", style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    Text("Score ${100 - i * 10}", style: const TextStyle(color: Colors.white54, fontSize: 9)),
                    Text("Viewers ${300 - i * 20}", style: const TextStyle(color: Colors.white54, fontSize: 9)),
                  ],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}