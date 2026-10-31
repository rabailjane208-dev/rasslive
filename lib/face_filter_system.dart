import 'package:flutter/material.dart';

class FaceFilterSystem extends StatefulWidget {
  const FaceFilterSystem({super.key});
  @override
  State<FaceFilterSystem> createState() => _FaceFilterSystemState();
}

class _FaceFilterSystemState extends State<FaceFilterSystem> {
  double smooth = 0.8;
  double whiten = 0.6;
  double slim = 0.5;
  double bigEyes = 0.7;
  double straight = 0.4;
  double clean = 0.6;
  int filterIndex = 0;
  int beardIndex = 0;

  final filters = const ["Beauty", "Beard", "Hair", "Cat", "Crown", "Cap", "Glasses", "Heart"];
  final filterEmojis = const ["💄", "🧔", "💇", "🐱", "👑", "🧢", "😎", "💖"];
  final beards = const ["Clean Shave", "Light Beard", "Full Beard", "Mustache", "Goatee", "Long Hair Wig"];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Beauty", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          _slider("Smooth", smooth, (v) => setState(() => smooth = v)),
          _slider("Whiten", whiten, (v) => setState(() => whiten = v)),
          _slider("Slim Face", slim, (v) => setState(() => slim = v)),
          _slider("Big Eyes", bigEyes, (v) => setState(() => bigEyes = v)),
          _slider("Straight Face", straight, (v) => setState(() => straight = v)),
          _slider("Face Clean", clean, (v) => setState(() => clean = v)),
          const SizedBox(height: 8),
          const Text("Filters", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 1,
            children: List.generate(filters.length, (i) => GestureDetector(
              onTap: () => setState(() => filterIndex = i),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.pink, Colors.purple]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(filterEmojis[i], style: const TextStyle(fontSize: 24)),
                    Text(filters[i], style: const TextStyle(color: Colors.white, fontSize: 9)),
                  ],
                ),
              ),
            )),
          ),
          const SizedBox(height: 8),
          const Text("Beard", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 6,
            children: List.generate(beards.length, (i) => ChoiceChip(
              label: Text(beards[i], style: const TextStyle(fontSize: 10)),
              selected: beardIndex == i,
              onSelected: (_) => setState(() => beardIndex = i),
            )),
          ),
          const SizedBox(height: 8),
          const Text("Overlay on camera:", style: TextStyle(color: Colors.white54, fontSize: 10)),
          Wrap(spacing: 6, children: const [
            Text("👑 Crown top-center size60", style: TextStyle(color: Colors.white54, fontSize: 9)),
            Text("🐱 Cat ears size50", style: TextStyle(color: Colors.white54, fontSize: 9)),
            Text("💖 Heart around face", style: TextStyle(color: Colors.white54, fontSize: 9)),
            Text("🧔 Beard bottom size80", style: TextStyle(color: Colors.white54, fontSize: 9)),
          ]),
        ],
      ),
    );
  }

  Widget _slider(String label, double val, ValueChanged<double> cb) {
    return Row(
      children: [
        SizedBox(width: 90, child: Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11))),
        Expanded(child: Slider(value: val, onChanged: cb, activeColor: Colors.pink, inactiveColor: Colors.white24)),
        SizedBox(width: 36, child: Text("${(val * 100).toInt()}%", style: const TextStyle(color: Colors.white54, fontSize: 10))),
      ],
    );
  }
}