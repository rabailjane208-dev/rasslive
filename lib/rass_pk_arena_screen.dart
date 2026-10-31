import 'package:flutter/material.dart';

class RassPkArenaScreen extends StatelessWidget {
  const RassPkArenaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8), child: Text("PK Battle", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 18))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(child: Column(children: const [
                  Text("Olivia", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("62%", style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold)),
                ])),
                const Text("vs", style: TextStyle(color: Colors.white54)),
                Expanded(child: Column(children: const [
                  Text("Ethan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("38%", style: TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold)),
                ])),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: 0.62,
                minHeight: 16,
                backgroundColor: Colors.blue,
                valueColor: const AlwaysStoppedAnimation(Colors.red),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("101050", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Text("vs", style: TextStyle(color: Colors.white54)),
                SizedBox(width: 8),
                Text("99990", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(8)),
            child: const Text("WIN x6  ⚡ Timer 03:06  x3 Gifting Points 29s", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("🦁 Lion roaring full screen", style: TextStyle(color: Colors.white54)),
                  SizedBox(height: 8),
                  Text("🌹 Rose x9 stacking", style: TextStyle(color: Colors.white54)),
                  SizedBox(height: 8),
                  Text("👑 Crown on winner", style: TextStyle(color: Colors.amber)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}