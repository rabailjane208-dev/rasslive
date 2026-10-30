import 'package:flutter/material.dart';

class RassGift {
  final String id;
  final String name;
  final int price;
  final String emoji;
  final Color color;
  final bool isBest;
  const RassGift({required this.id, required this.name, required this.price, required this.emoji, required this.color, this.isBest = false});
}

final List<RassGift> rassGifts = [
  RassGift(id: "1", name: "Kiss", price: 10, emoji: "💋", color: Colors.pink),
  RassGift(id: "2", name: "Rose", price: 10, emoji: "🌹", color: Colors.red),
  RassGift(id: "3", name: "Applause", price: 30, emoji: "👏", color: Colors.amber),
  RassGift(id: "4", name: "Lollipop", price: 50, emoji: "🍭", color: Colors.purple),
  RassGift(id: "5", name: "Party Popper", price: 30, emoji: "🎉", color: Colors.orange),
  RassGift(id: "6", name: "New Star", price: 100, emoji: "🌟", color: Colors.yellow),
  RassGift(id: "7", name: "Solo", price: 150, emoji: "🎤", color: Colors.cyan),
  RassGift(id: "8", name: "Broom", price: 180, emoji: "🧹", color: Colors.brown),
  RassGift(id: "9", name: "Candy", price: 200, emoji: "🍬", color: Colors.pinkAccent),
  RassGift(id: "10", name: "Skull", price: 500, emoji: "💀", color: Colors.white),
  RassGift(id: "11", name: "Lucky Box", price: 800, emoji: "🎁", color: Colors.green),
  RassGift(id: "12", name: "Fan Light Board", price: 100, emoji: "💡", color: Colors.yellow),
  RassGift(id: "13", name: "Cellphone", price: 200, emoji: "📱", color: Colors.blue),
  RassGift(id: "14", name: "Hand Mirror", price: 300, emoji: "🪞", color: Colors.pink),
  RassGift(id: "15", name: "Candy Star", price: 400, emoji: "⭐", color: Colors.purple),
  RassGift(id: "16", name: "Sparks", price: 500, emoji: "✨", color: Colors.amber),
  RassGift(id: "17", name: "Wishing Bottle", price: 600, emoji: "🍶", color: Colors.cyan),
  RassGift(id: "18", name: "Gem Handbag", price: 800, emoji: "👜", color: Colors.pink),
  RassGift(id: "19", name: "Medusa", price: 1000, emoji: "🐍", color: Colors.green),
  RassGift(id: "20", name: "Rose Route", price: 1200, emoji: "🌹🛣️", color: Colors.red),
  RassGift(id: "21", name: "Hot Balloon", price: 1500, emoji: "🎈", color: Colors.orange),
  RassGift(id: "22", name: "Wind Chime", price: 2000, emoji: "🎐", color: Colors.blue),
  RassGift(id: "23", name: "Rocking Horse", price: 2500, emoji: "🐴", color: Colors.brown),
  RassGift(id: "24", name: "Lily Valley", price: 3000, emoji: "🌸", color: Colors.pink, isBest: true),
  RassGift(id: "25", name: "Qatar Jet", price: 5000, emoji: "✈️", color: Colors.white, isBest: true),
  RassGift(id: "26", name: "Bumper Car", price: 8000, emoji: "🚗", color: Colors.red),
  RassGift(id: "27", name: "Cloudy Wings", price: 10000, emoji: "🦋", color: Colors.white, isBest: true),
  RassGift(id: "28", name: "Wind Girl", price: 12000, emoji: "👧💨", color: Colors.cyan, isBest: true),
  RassGift(id: "29", name: "Sleeping Beauty", price: 18000, emoji: "👸", color: Colors.pink, isBest: true),
  RassGift(id: "30", name: "Star Prince", price: 18000, emoji: "🤴", color: Colors.amber, isBest: true),
  RassGift(id: "31", name: "Rainbow", price: 25000, emoji: "🌈", color: Colors.purple, isBest: true),
  RassGift(id: "32", name: "Back Massage", price: 20000, emoji: "💆", color: Colors.orange, isBest: true),
  RassGift(id: "33", name: "Donkey", price: 36000, emoji: "🫏", color: Colors.brown, isBest: true),
  RassGift(id: "34", name: "Rose Afternoon", price: 38000, emoji: "🌹☕", color: Colors.redAccent, isBest: true),
  RassGift(id: "35", name: "Cloud Pavilion", price: 40000, emoji: "🏯", color: Colors.blueGrey, isBest: true),
  RassGift(id: "36", name: "Pirate Booty", price: 45000, emoji: "💰", color: Colors.brown, isBest: true),
  RassGift(id: "37", name: "Coaster", price: 48000, emoji: "🎢", color: Colors.blue, isBest: true),
  RassGift(id: "38", name: "Wishing Well", price: 50000, emoji: "⛲", color: Colors.cyan, isBest: true),
  RassGift(id: "39", name: "Past Fountain", price: 52000, emoji: "⛲", color: Colors.blueAccent, isBest: true),
  RassGift(id: "40", name: "Camel King", price: 60000, emoji: "🐪👑", color: Colors.amber, isBest: true),
  RassGift(id: "41", name: "Pirate Ship", price: 80000, emoji: "🚢", color: Colors.black, isBest: true),
  RassGift(id: "42", name: "Magic Castle", price: 100000, emoji: "🏰", color: Colors.purple, isBest: true),
  RassGift(id: "43", name: "Shark Sub", price: 100000, emoji: "🦈", color: Colors.blue, isBest: true),
  RassGift(id: "44", name: "Motor Gear", price: 100000, emoji: "🏍️", color: Colors.black, isBest: true),
  RassGift(id: "45", name: "Diamond Rainbow", price: 120000, emoji: "💎🌈", color: Colors.cyan, isBest: true),
  RassGift(id: "46", name: "Phoenix", price: 150000, emoji: "🦅", color: Colors.orange, isBest: true),
  RassGift(id: "47", name: "Dragon King", price: 200000, emoji: "🐉👑", color: Colors.red, isBest: true),
  RassGift(id: "48", name: "RASS Universe", price: 300000, emoji: "🌌👑", color: Colors.deepPurple, isBest: true),
  RassGift(id: "49", name: "RASS Legendary", price: 500000, emoji: "🐉🌌💎", color: Colors.amberAccent, isBest: true),
  RassGift(id: "50", name: "RASS GOD", price: 1000000, emoji: "👑🔥🌌", color: Colors.amber, isBest: true),
];

void main() { WidgetsFlutterBinding.ensureInitialized(); runApp(const RassLiveApp()); }

class RassLiveApp extends StatelessWidget {
  const RassLiveApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'RASS LIVE', theme: ThemeData.dark(), home: const RassHome());
  }
}

class RassHome extends StatefulWidget { const RassHome({super.key}); @override State<RassHome> createState() => _RassHomeState(); }

class _RassHomeState extends State<RassHome> {
  RassGift? selected;
  int count = 1;
  int score = 0;
  int tabIndex = 1; // Gift tab selected like video
  List<RassGift> get filtered => tabIndex==0 ? rassGifts.take(12).toList() : rassGifts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // TOP LIVE AREA - like video
          Container(
            width: double.infinity, height: double.infinity,
            decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF2a1a4a), Color(0xFF1a1a2e), Colors.black])),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(children: [
                      const CircleAvatar(radius: 18, backgroundColor: Colors.pink, child: Text("R", style: TextStyle(color: Colors.white))),
                      const SizedBox(width: 8),
                      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("RASS LIVE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text("ID: 123456 • 5.2K", style: TextStyle(fontSize: 10, color: Colors.white70))]),
                      const Spacer(),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)), child: const Row(children: [Icon(Icons.live_tv, size: 12, color: Colors.white), SizedBox(width:4), Text("LIVE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))])),
                      const SizedBox(width: 6),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)), child: Text("💎 $score", style: const TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold))),
                    ]),
                  ),
                  const Spacer(),
                  const Text("🎥 Camera ON • 2 Seat Live", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 280),
                ],
              ),
            ),
          ),
          // BOTTOM GIFT SHEET - Draggable like video
          DraggableScrollableSheet(initialChildSize: 0.55, minChildSize: 0.4, maxChildSize: 0.85, builder: (context, scrollController){
            return Container(
              decoration: const BoxDecoration(color: Color(0xFF1c1c1e), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Container(width: 36, height: 4, decoration: BoxDecoration(color: Colors.grey[600], borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 8),
                  // GIFT PACK HEADER like video
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(children: [
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)), child: const Text("Gift Pack", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white))),
                      const SizedBox(width: 8),
                      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("XP Needed: 3000", style: TextStyle(fontSize: 9, color: Colors.white70)), SizedBox(height:2), LinearProgressIndicator(value: 0.72, backgroundColor: Colors.white12, color: Colors.orange, minHeight: 3)])),
                      const SizedBox(width: 8),
                      const Text("72%", style: TextStyle(fontSize: 10, color: Colors.orange)),
                      const SizedBox(width: 8),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(6)), child: const Text("Surprise Shop", style: TextStyle(fontSize: 9))),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  // TABS like video - Halloween, New, Gift, Lucky, Fan Club
                  SizedBox(height: 28, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 8), children: [
                    _tab("Halloween", 0), _tab("New", 1), _tab("Gift", 1, isSelected: true), _tab("Lucky", 2), _tab("Fan Club", 3),
                  ])),
                  const Divider(color: Colors.white12, height: 1),
                  // GIFT GRID
                  Expanded(
                    child: GridView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 0.82),
                      itemCount: filtered.length,
                      itemBuilder: (c,i){
                        final g = filtered[i];
                        final isSel = selected?.id == g.id;
                        return GestureDetector(
                          onTap: ()=> setState(()=> selected = g),
                          child: Container(
                            decoration: BoxDecoration(color: isSel? Colors.amber.withOpacity(0.25): const Color(0xFF2c2c2e), borderRadius: BorderRadius.circular(10), border: isSel? Border.all(color: Colors.amber, width: 1.5): g.isBest? Border.all(color: Colors.amber.withOpacity(0.6)): null),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(g.emoji, style: TextStyle(fontSize: g.isBest? 28: 24)),
                              const SizedBox(height: 2),
                              Text(g.name, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 2),
                              const SizedBox(height: 2),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)), child: Row(mainAxisSize: MainAxisSize.min, children: [const Text("🪙", style: TextStyle(fontSize: 7)), Text(" ${g.price}", style: TextStyle(fontSize: 8, color: Colors.amber[200], fontWeight: FontWeight.bold))])),
                              if(g.isBest) Container(margin: const EdgeInsets.only(top:2), padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)), child: const Text("BEST", style: TextStyle(fontSize: 5, fontWeight: FontWeight.bold, color: Colors.black))),
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
                  // BOTTOM BAR - First Recharge + 1 10 50 + Send like video
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: const BoxDecoration(color: Color(0xFF121212), border: Border(top: BorderSide(color: Colors.white12))),
                    child: Row(
                      children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(16)), child: const Row(children: [Icon(Icons.account_balance_wallet, size: 12, color: Colors.white), SizedBox(width:4), Text("First Recharge", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white))])),
                        const SizedBox(width: 8),
                        Expanded(child: Row(children: [1,10,50].map((n)=> GestureDetector(onTap: ()=> setState(()=> count=n), child: Container(margin: const EdgeInsets.only(right: 6), width: 30, height: 28, decoration: BoxDecoration(color: count==n? Colors.white: Colors.white12, borderRadius: BorderRadius.circular(8), border: count==n? Border.all(color: Colors.amber): null), child: Center(child: Text("$n", style: TextStyle(fontSize: 11, color: count==n? Colors.black: Colors.white, fontWeight: FontWeight.bold)))))).toList())),
                        GestureDetector(
                          onTap: (){ if(selected!=null){ setState(()=> score+= selected!.price * count); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${selected!.emoji} ${selected!.name} x$count Sent! +${selected!.price*count}", style: const TextStyle(fontWeight: FontWeight.bold)), backgroundColor: selected!.color, duration: const Duration(milliseconds: 800))); }},
                          child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF00c6ff), Color(0xFF0072ff)]), borderRadius: BorderRadius.circular(20)), child: const Text("Send", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _tab(String name, int idx, {bool isSelected=false}){
    return Container(margin: const EdgeInsets.only(right: 12), child: Column(children: [Text(name, style: TextStyle(fontSize: 13, fontWeight: isSelected? FontWeight.bold: FontWeight.normal, color: isSelected? Colors.white: Colors.white60)), if(isSelected) Container(margin: const EdgeInsets.only(top:3), width: 20, height: 2, color: Colors.orange)]));
  }
}
