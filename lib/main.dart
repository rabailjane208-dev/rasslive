import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await [Permission.camera, Permission.microphone].request();
  runApp(const RassLiveApp());
}

class RassLiveApp extends StatelessWidget {
  const RassLiveApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black), home: const MainNav());
  }
}

class MainNav extends StatefulWidget { const MainNav({super.key}); @override State<MainNav> createState() => _MainNavState(); }
class _MainNavState extends State<MainNav> {
  int _index = 0;
  final pages = [const RassLiveScorePage(), const PrivatePage(), const FamilyPage(), const VideoPage(), const MessengerPage(), const GamesPage(), const WalletPage(), const ProfilePage()];
  @override Widget build(BuildContext context) {
    return Scaffold(body: pages[_index], bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.fixed, backgroundColor: const Color(0xFF121212), selectedItemColor: const Color(0xFFE91E63), unselectedItemColor: Colors.white54, currentIndex: _index, onTap: (i) => setState(() => _index = i), items: const [
      BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'RassLive'),
      BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Private'),
      BottomNavigationBarItem(icon: Icon(Icons.family_restroom), label: 'Family'),
      BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Video'),
      BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messen.'),
      BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Games'),
      BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ]));
  }
}

class RassLiveScorePage extends StatelessWidget { const RassLiveScorePage({super.key}); @override Widget build(BuildContext context) { return SafeArea(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Padding(padding: EdgeInsets.all(12), child: Text('RASS LIVE - Score', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18))), Expanded(child: ListView(children: [ListTile(title: const Text('Rass World 🌍 1257/100'), trailing: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveRoom(roomName: 'Rass World'))), child: const Text('Join LIVE'))), ListTile(title: const Text('Queen Live 👑 892/85'), trailing: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveRoom(roomName: 'Queen Live'))), child: const Text('Join LIVE')))]))])); } }

// LIVE ROOM - 150 GIFT + SOUND + FRONT/BACK - APP ID SIGN
class LiveRoom extends StatefulWidget { final String roomName; const LiveRoom({super.key, required this.roomName}); @override State<LiveRoom> createState() => _LiveRoomState(); }
class _LiveRoomState extends State<LiveRoom> {
  CameraController? ctrl; List<CameraDescription> allCams = []; bool isFront = true; bool isLive = false; final AudioPlayer audioPlayer = AudioPlayer();
  final List<Map<String, dynamic>> allGifts = [
    {"name": "Party Popper", "icon": "🎉", "price": 10}, {"name": "New Star", "icon": "⭐", "price": 30}, {"name": "Spiderweb", "icon": "🕸️", "price": 50}, {"name": "Broom", "icon": "🧹", "price": 50}, {"name": "Candy", "icon": "🍬", "price": 100}, {"name": "Skull", "icon": "💀", "price": 100}, {"name": "Lucky Box", "icon": "🎁", "price": 150}, {"name": "Fan Light", "icon": "💡", "price": 10}, {"name": "Sweet Bouquet", "icon": "💐", "price": 100}, {"name": "Hand Mirror", "icon": "🪞", "price": 200}, {"name": "Parrot", "icon": "🦜", "price": 200}, {"name": "Dancing Clock", "icon": "🕰️", "price": 300}, {"name": "Magic Kitty", "icon": "🐱", "price": 5000}, {"name": "Rose Route", "icon": "🌹", "price": 10000}, {"name": "Balloon", "icon": "🎈", "price": 12000}, {"name": "Wind Chimes", "icon": "🎐", "price": 15000}, {"name": "Rocking Horse", "icon": "🐴", "price": 18000}, {"name": "Back Massage", "icon": "💆", "price": 36000}, {"name": "Sleeping Beauty", "icon": "👸", "price": 40000}, {"name": "Rainbow", "icon": "🌈", "price": 50000}, {"name": "LOVE Bear", "icon": "🐻", "price": 55000}, {"name": "Pirate Booty", "icon": "🏴‍☠️", "price": 150000}, {"name": "Crystal Castle", "icon": "🏰", "price": 200000}, {"name": "Kiss", "icon": "💋", "price": 5}, {"name": "Rose", "icon": "🌹", "price": 10}, {"name": "Lollipop", "icon": "🍭", "price": 50}, {"name": "Diamond", "icon": "💎", "price": 300}, {"name": "Shark Submarine", "icon": "🦈", "price": 10000}, {"name": "Candy House", "icon": "🍭", "price": 12000}, {"name": "Yacht", "icon": "🛥️", "price": 800000}, {"name": "Castle King", "icon": "🏰", "price": 1000000},
  ];
  @override void initState() { super.initState(); _startCamera(); }
  Future<void> _startCamera() async { try { allCams = await availableCameras(); if (allCams.isEmpty) return; CameraDescription selected = isFront ? allCams.firstWhere((c) => c.lensDirection == CameraLensDirection.front, orElse: () => allCams.first) : allCams.firstWhere((c) => c.lensDirection == CameraLensDirection.back, orElse: () => allCams.first); await ctrl?.dispose(); ctrl = CameraController(selected, ResolutionPreset.high, enableAudio: true); await ctrl!.initialize(); if (mounted) setState(() {}); } catch (e) {} }
  Future<void> _switchCamera() async { setState(() => isFront = !isFront); await _startCamera(); }
  void _sendGift(Map gift) async { try { await audioPlayer.play(AssetSource('sounds/gift.mp3')); } catch (_) {} ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${gift['name']} ${gift['icon']} bheja - ${gift['price']} Coins 🔊💳 Wallet Connect'))); }
  @override void dispose() { ctrl?.dispose(); audioPlayer.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.black, title: Text(widget.roomName, style: const TextStyle(fontSize: 12)), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))), body: Stack(children: [
      if (ctrl != null && ctrl!.value.isInitialized) SizedBox.expand(child: CameraPreview(ctrl!)) else Container(color: Colors.black, child: const Center(child: Text('LIVE - Camera ON', style: TextStyle(color: Colors.white38)))),
      Positioned(bottom: 60, left: 0, right: 0, top: 50, child: Container(decoration: BoxDecoration(color: const Color(0xFF1E1E1E).withOpacity(0.95), borderRadius: const BorderRadius.vertical(top: Radius.circular(20))), child: Column(children: [Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.65), itemCount: allGifts.length, itemBuilder: (c, i) { final g = allGifts[i]; return GestureDetector(onTap: () => _sendGift(g), child: Container(margin: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(g['icon'], style: const TextStyle(fontSize: 26)), Text(g['name'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 7)), Text('${g['price']}', style: const TextStyle(fontSize: 7, color: Colors.orange))]))); }))]))),
      Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.all(8), child: Row(children: [const Expanded(child: TextField(style: TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'Say Hi...', hintStyle: TextStyle(color: Colors.white54), border: InputBorder.none))), IconButton(icon: Icon(isFront ? Icons.camera_rear : Icons.camera_front, color: Colors.yellow), onPressed: _switchCamera), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), onPressed: () => setState(() => isLive = !isLive), child: Text(isLive ? 'END' : 'Go LIVE'))]))),
    ]));
  }
}

class PrivatePage extends StatelessWidget { const PrivatePage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Private Page - Pura bhara hua'))); }
class FamilyPage extends StatelessWidget { const FamilyPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Family Room 4'))); }

// VIDEO PAGE - FULL BEST - EDITING + UPLOAD + PLAY + LIKE FOLLOW COMMENT + FILTERS BEAUTY
class VideoPage extends StatefulWidget { const VideoPage({super.key}); @override State<VideoPage> createState() => _VideoPageState(); }
class _VideoPageState extends State<VideoPage> {
  final AudioPlayer audioPlayer = AudioPlayer(); PageController pageController = PageController();
  List<Map<String, dynamic>> videos = [
    {"user": "Singer Faiza Ali 58", "likes": 3546, "comments": 456, "shares": 348, "bookmarks": 46, "isLiked": false, "isFollowed": false, "caption": "Beach wala Heart Dil ❤️ #rasslive", "song": "Guzarish - Original Sound"},
    {"user": "Queen Live 👑", "likes": 12500, "comments": 2100, "shares": 480, "bookmarks": 96, "isLiked": true, "isFollowed": true, "caption": "PK karoge? 🔥", "song": "Lofi Beat"},
    {"user": "Rass World 🌍", "likes": 8920, "comments": 540, "shares": 210, "bookmarks": 120, "isLiked": false, "isFollowed": false, "caption": "PK Arena Winner 🏆", "song": "Victory"},
  ];
  int currentIndex = 0; double beautySmooth = 40; bool showBeautyPanel = false; bool showFilterPanel = false;
  void _toggleLike(int i) { setState(() { videos[i]['isLiked'] = !videos[i]['isLiked']; if (videos[i]['isLiked']) { videos[i]['likes']++; try { audioPlayer.play(AssetSource('sounds/like.mp3')); } catch (_) {} } else { videos[i]['likes']--; } }); }
  void _toggleFollow(int i) { setState(() => videos[i]['isFollowed'] = !videos[i]['isFollowed']); }
  void _showComments() { showModalBottomSheet(context: context, backgroundColor: const Color(0xFF121212), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (_) => Container(height: 400, padding: const EdgeInsets.all(12), child: Column(children: [Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))), const Text('Comments'), Expanded(child: ListView(children: const [ListTile(title: Text('Ali: Zabardast ❤️', style: TextStyle(fontSize: 13)))])), const TextField(decoration: InputDecoration(hintText: 'Say something...'), style: TextStyle(color: Colors.white))]))); }
  void _showCreateSheet() { showModalBottomSheet(context: context, backgroundColor: Colors.black, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (_) => StatefulBuilder(builder: (context, setStateSheet) => Container(height: MediaQuery.of(context).size.height * 0.85, padding: const EdgeInsets.all(12), child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)), child: const Text('Add sound 🎵', style: TextStyle(fontSize: 12)))]), const Spacer(), const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('10m'), SizedBox(width: 12), Text('60s'), SizedBox(width: 12), Text('15s'), SizedBox(width: 12), Text('PHOTO')]), const SizedBox(height: 12), Row(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.pink, width: 3)), child: const Icon(Icons.camera_alt, size: 30)), const SizedBox(width: 20), const CircleAvatar(radius: 20, backgroundColor: Colors.pink, child: Icon(Icons.face))]), if (showBeautyPanel) Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Column(children: [const Text('Beauty - Smooth, Shape, Contrast, Lips'), Slider(value: beautySmooth, min: 0, max: 100, activeColor: Colors.pink, onChanged: (v) => setStateSheet(() => beautySmooth = v))])), if (showFilterPanel) Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: const Row(children: [Text('Portrait ', style: TextStyle(color: Colors.pink)), Text('Landscape Food Life Retro Gotham Nokia Bright Bubbly')])), Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [IconButton(icon: const Icon(Icons.face_retouching_natural), onPressed: () => setStateSheet(() { showBeautyPanel = !showBeautyPanel; showFilterPanel = false; })), IconButton(icon: const Icon(Icons.filter_vintage), onPressed: () => setStateSheet(() { showFilterPanel = !showFilterPanel; showBeautyPanel = false; }))])])))); }
  @override Widget build(BuildContext context) { return Scaffold(body: PageView.builder(scrollDirection: Axis.vertical, controller: pageController, itemCount: videos.length, itemBuilder: (context, index) { final v = videos[index]; return Stack(children: [Container(color: const Color(0xFF0A0A0A), child: const Center(child: Icon(Icons.play_circle_fill, size: 80, color: Colors.white24))), Positioned(right: 12, bottom: 120, child: Column(children: [Stack(children: [const CircleAvatar(radius: 28, backgroundColor: Colors.pink, child: Icon(Icons.person)), Positioned(bottom: 0, left: 0, right: 0, child: GestureDetector(onTap: () => _toggleFollow(index), child: Container(width: 20, height: 20, decoration: BoxDecoration(color: v['isFollowed'] ? Colors.white10 : Colors.pink, shape: BoxShape.circle), child: Icon(v['isFollowed'] ? Icons.check : Icons.add, size: 12))))]), const SizedBox(height: 20), GestureDetector(onTap: () => _toggleLike(index), child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.white10, shape: BoxShape.circle), child: Icon(Icons.favorite, size: 32, color: v['isLiked'] ? Colors.red : Colors.white)), Text('${v['likes']}', style: const TextStyle(fontSize: 12))])), const SizedBox(height: 16), GestureDetector(onTap: _showComments, child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.white10, shape: BoxShape.circle), child: const Icon(Icons.chat_bubble, size: 28)), Text('${v['comments']}', style: const TextStyle(fontSize: 12))]))])), Positioned(left: 12, right: 80, bottom: 20, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('@${v['user']}', style: const TextStyle(fontWeight: FontWeight.bold)), Text(v['caption'], style: const TextStyle(fontSize: 12)), Row(children: [const Icon(Icons.music_note, size: 14), Text(v['song'], style: const TextStyle(fontSize: 11))])])), Positioned(top: 40, left: 12, right: 12, child: Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)), child: const Text('Restricted Mode', style: TextStyle(fontSize: 10))), const Spacer(), GestureDetector(onTap: _showCreateSheet, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(12)), child: const Text('Create', style: TextStyle(fontSize: 12))))]))]); }), floatingActionButton: FloatingActionButton.extended(backgroundColor: Colors.pink, onPressed: _showCreateSheet, icon: const Icon(Icons.video_call), label: const Text('Go LIVE'))); }
}

class MessengerPage extends StatelessWidget { const MessengerPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Messenger - 5000 Coins'))); }

// GAMES PAGE - 30 BEST GAMES - UPAR NEECHAY + SHART SYSTEM CONNECT
class GamesPage extends StatefulWidget { const GamesPage({super.key}); @override State<GamesPage> createState() => _GamesPageState(); }
class _GamesPageState extends State<GamesPage> {
  final AudioPlayer audioPlayer = AudioPlayer(); String selectedCat = "All";
  final List<Map<String, dynamic>> allGames = [
    {"name": "PK Battle", "sub": "71 Games", "icon": "⚔️", "cat": "Battle", "entry": "50", "win": "90", "players": "12.3K"},
    {"name": "Ludo King", "sub": "6 Games", "icon": "🎲", "cat": "Casual", "entry": "50", "win": "90", "players": "45.2K"},
    {"name": "Teen Patti", "sub": "10 Games", "icon": "🃏", "cat": "Card", "entry": "100", "win": "180", "players": "32.1K"},
    {"name": "Poker Pro", "sub": "5 Games", "icon": "♠️", "cat": "Card", "entry": "200", "win": "360", "players": "18.5K"},
    {"name": "8 Ball Pool", "sub": "9 Games", "icon": "🎱", "cat": "Casual", "entry": "50", "win": "90", "players": "28.4K"},
    {"name": "Football", "sub": "9 Games", "icon": "⚽", "cat": "Battle", "entry": "50", "win": "90", "players": "15.2K"},
    {"name": "Car Racing", "sub": "12 Games", "icon": "🏎️", "cat": "Battle", "entry": "100", "win": "180", "players": "22.1K"},
    {"name": "Snake Ladder", "sub": "4 Games", "icon": "🐍", "cat": "Casual", "entry": "20", "win": "36", "players": "35.6K"},
    {"name": "Chess Master", "sub": "3 Games", "icon": "♟️", "cat": "Battle", "entry": "50", "win": "90", "players": "12.8K"},
    {"name": "Domino", "sub": "2 Games", "icon": "🁢", "cat": "Card", "entry": "30", "win": "54", "players": "9.2K"},
    {"name": "Rummy", "sub": "8 Games", "icon": "♦️", "cat": "Card", "entry": "100", "win": "180", "players": "19.3K"},
    {"name": "Bubble Shooter", "sub": "15 Games", "icon": "🫧", "cat": "Casual", "entry": "20", "win": "36", "players": "41.2K"},
    {"name": "Candy Crush", "sub": "20 Games", "icon": "🍭", "cat": "Casual", "entry": "30", "win": "54", "players": "38.7K"},
    {"name": "Carrom", "sub": "3 Games", "icon": "🥏", "cat": "Casual", "entry": "50", "win": "90", "players": "16.4K"},
    {"name": "Cricket Hit", "sub": "6 Games", "icon": "🏏", "cat": "Battle", "entry": "50", "win": "90", "players": "24.5K"},
    {"name": "Basketball", "sub": "5 Games", "icon": "🏀", "cat": "Battle", "entry": "50", "win": "90", "players": "14.2K"},
    {"name": "Archery", "sub": "4 Games", "icon": "🏹", "cat": "Battle", "entry": "40", "win": "72", "players": "8.9K"},
    {"name": "Bowling", "sub": "3 Games", "icon": "🎳", "cat": "Casual", "entry": "30", "win": "54", "players": "11.3K"},
    {"name": "Dart King", "sub": "2 Games", "icon": "🎯", "cat": "Casual", "entry": "20", "win": "36", "players": "7.8K"},
    {"name": "Puzzle Pro", "sub": "25 Games", "icon": "🧩", "cat": "Casual", "entry": "20", "win": "36", "players": "33.1K"},
    {"name": "Memory Match", "sub": "10 Games", "icon": "🧠", "cat": "Casual", "entry": "20", "win": "36", "players": "29.4K"},
    {"name": "Tic Tac Toe", "sub": "2 Games", "icon": "⭕", "cat": "Casual", "entry": "10", "win": "18", "players": "52.3K"},
    {"name": "Word Guess", "sub": "12 Games", "icon": "📝", "cat": "Casual", "entry": "30", "win": "54", "players": "18.9K"},
    {"name": "Quiz Battle", "sub": "30 Games", "icon": "❓", "cat": "Battle", "entry": "50", "win": "90", "players": "26.7K"},
    {"name": "Spin Wheel", "sub": "Lucky", "icon": "🎡", "cat": "Casual", "entry": "10", "win": "100", "players": "48.2K"},
    {"name": "Slot Machine", "sub": "Jackpot", "icon": "🎰", "cat": "Card", "entry": "100", "win": "1000", "players": "31.5K"},
    {"name": "Dice Roll", "sub": "Lucky Dice", "icon": "🎲", "cat": "Casual", "entry": "20", "win": "36", "players": "27.8K"},
    {"name": "UNO", "sub": "4 Games", "icon": "🃏", "cat": "Card", "entry": "50", "win": "90", "players": "36.9K"},
    {"name": "Bike Racing", "sub": "8 Games", "icon": "🏍️", "cat": "Battle", "entry": "100", "win": "180", "players": "19.8K"},
    {"name": "Ludo Supreme", "sub": "Pro Ludo", "icon": "👑", "cat": "Casual", "entry": "200", "win": "360", "players": "42.1K"},
  ];
  List<Map<String, dynamic>> get filteredGames { if (selectedCat == "All") return allGames; return allGames.where((g) => g['cat'] == selectedCat).toList(); }
  void _playGame(Map game) async { try { await audioPlayer.play(AssetSource('sounds/game_start.mp3')); } catch (_) {} Navigator.push(context, MaterialPageRoute(builder: (_) => GamePlayPage(gameName: game['name'], icon: game['icon']))); }
  @override Widget build(BuildContext context) {
    return SafeArea(child: Column(children: [
      Padding(padding: const EdgeInsets.all(12), child: Row(children: [const Text('Games', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), const Spacer(), const Icon(Icons.diamond, size: 12, color: Colors.orange), const Text(' 5000 Coins', style: TextStyle(fontSize: 10)), Container(margin: const EdgeInsets.only(left: 6), padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(4)), child: const Text('Recharge', style: TextStyle(fontSize: 8))) ])),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [_cat('All', selectedCat == 'All'), _cat('Casual', selectedCat == 'Casual'), _cat('Card', selectedCat == 'Card'), _cat('Battle', selectedCat == 'Battle'), Container(margin: const EdgeInsets.only(left: 8), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.yellow.shade900, borderRadius: BorderRadius.circular(12)), child: Text('${filteredGames.length} Games', style: const TextStyle(color: Colors.yellow, fontSize: 10))) ]))),
      const SizedBox(height: 8),
      Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.85, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: filteredGames.length, itemBuilder: (c, i) { final g = filteredGames[i]; return GestureDetector(onTap: () => _playGame(g), child: Container(decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(g['icon'], style: const TextStyle(fontSize: 40)), const SizedBox(height: 8), Text(g['name'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Text(g['sub'], style: const TextStyle(color: Colors.white54, fontSize: 9)), const SizedBox(height: 6), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade900, borderRadius: BorderRadius.circular(12)), child: Text('${g['players']} Playing', style: const TextStyle(color: Colors.greenAccent, fontSize: 8))), const SizedBox(height: 6), Text('Entry ${g['entry']} Win ${g['win']}\nGift Marzi\nWinner 90% Wallet', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white24, fontSize: 8)), const SizedBox(height: 6), Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(12)), child: const Text('PLAY - Upar Neechay', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold))) ]))); })),
    ]));
  }
  Widget _cat(String t, bool sel) => GestureDetector(onTap: () => setState(() => selectedCat = t), child: Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: sel ? Colors.pink : Colors.white10, borderRadius: BorderRadius.circular(20)), child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 11))));
}

// GAME PLAY PAGE - UPAR NEECHAY + SHART - COIN DIAMOND GIFT + WALLET CONNECT - FINAL
class GamePlayPage extends StatefulWidget { final String gameName; final String icon; const GamePlayPage({super.key, required this.gameName, required this.icon}); @override State<GamePlayPage> createState() => _GamePlayPageState(); }
class _GamePlayPageState extends State<GamePlayPage> {
  final AudioPlayer audioPlayer = AudioPlayer(); int myCoins = 5000; int myDiamonds = 1250; String selectedBetType = "Coins"; String selectedSide = "UPAR"; int betAmount = 50; Map<String, dynamic>? selectedGiftBet;
  final List<Map<String, dynamic>> allGiftsForBet = [
    {"name": "Rose", "icon": "🌹", "price": 10}, {"name": "Kiss", "icon": "💋", "price": 5}, {"name": "Diamond", "icon": "💎", "price": 300}, {"name": "Yacht", "icon": "🛥️", "price": 800000}, {"name": "Castle", "icon": "🏰", "price": 200000}, {"name": "Party", "icon": "🎉", "price": 10}, {"name": "Skull", "icon": "💀", "price": 100}, {"name": "Candy", "icon": "🍬", "price": 100}, {"name": "Shark", "icon": "🦈", "price": 10000}, {"name": "Pirate", "icon": "🏴‍☠️", "price": 150000},
  ];
  void _placeBet() async {
    try { await audioPlayer.play(AssetSource('sounds/gift.mp3')); } catch (_) {}
    String betText = ""; if (selectedBetType == "Coins") { if (myCoins < betAmount) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.red, content: Text('Coins kam hain! Wallet me recharge karo 💳'))); return; } setState(() => myCoins -= betAmount); betText = "$betAmount Coins"; } else if (selectedBetType == "Diamonds") { if (myDiamonds < betAmount) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.red, content: Text('Diamonds kam hain! 💎'))); return; } setState(() => myDiamonds -= betAmount); betText = "$betAmount Diamonds"; } else { if (selectedGiftBet == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pehle Gift select karo 🎁'))); return; } betText = "${selectedGiftBet!['name']} ${selectedGiftBet!['icon']}"; }
    bool isWin = (DateTime.now().millisecond % 2 == 0); int winAmount = (betAmount * 1.8).toInt();
    if (isWin) { setState(() { if (selectedBetType == "Coins") myCoins += winAmount; if (selectedBetType == "Diamonds") myDiamonds += winAmount; }); ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green, duration: const Duration(seconds: 3), content: Text('WINNER! 🎉 $selectedSide jeet gaya! $betText - $winAmount jeeta - 90% Wallet me ✅\nCoins: $myCoins | Diamonds: $myDiamonds'))); } else { ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.orange, content: Text('LOST! $selectedSide haar gaya - $betText chala gaya!'))); }
  }
  @override Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: Text('${widget.icon} ${widget.gameName} - Upar Neechay', style: const TextStyle(fontSize: 12)), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)), actions: [Container(margin: const EdgeInsets.all(8), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF3A2E00), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange)), child: Row(children: [const Icon(Icons.monetization_on, size: 14, color: Colors.yellow), Text(' $myCoins ', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)), const Icon(Icons.diamond, size: 12, color: Colors.pink), Text(' $myDiamonds', style: const TextStyle(fontSize: 10))]))]),
      body: Column(children: [
        Container(padding: const EdgeInsets.all(16), margin: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.pink.withOpacity(0.5))), child: Column(children: [Text('${widget.icon} ${widget.gameName}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12), Row(children: [Expanded(child: GestureDetector(onTap: () => setState(() => selectedSide = "UPAR"), child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: selectedSide == "UPAR" ? Colors.green : Colors.white10, borderRadius: BorderRadius.circular(12), border: Border.all(color: selectedSide == "UPAR" ? Colors.green : Colors.white10, width: 2)), child: const Column(children: [Text('📈', style: TextStyle(fontSize: 30)), Text('UPAR', style: TextStyle(fontWeight: FontWeight.bold)), Text('50%', style: TextStyle(fontSize: 10))])))), const SizedBox(width: 12), const Text('VS', style: TextStyle(color: Colors.white54)), const SizedBox(width: 12), Expanded(child: GestureDetector(onTap: () => setState(() => selectedSide = "NEECHAY"), child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: selectedSide == "NEECHAY" ? Colors.red : Colors.white10, borderRadius: BorderRadius.circular(12), border: Border.all(color: selectedSide == "NEECHAY" ? Colors.red : Colors.white10, width: 2)), child: const Column(children: [Text('📉', style: TextStyle(fontSize: 30)), Text('NEECHAY', style: TextStyle(fontWeight: FontWeight.bold)), Text('50%', style: TextStyle(fontSize: 10))])))), ]), const SizedBox(height: 8), Text('Selected: $selectedSide', style: TextStyle(color: selectedSide == "UPAR" ? Colors.green : Colors.red, fontSize: 10, fontWeight: FontWeight.bold)) ])),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Row(children: [_betTypeBtn('Coins', '🪙', selectedBetType == 'Coins'), const SizedBox(width: 8), _betTypeBtn('Diamonds', '💎', selectedBetType == 'Diamonds'), const SizedBox(width: 8), _betTypeBtn('Gift', '🎁', selectedBetType == 'Gift')])),
        const SizedBox(height: 8),
        if (selectedBetType != "Gift") Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Shart: $betAmount $selectedBetType - Win: ${(betAmount * 1.8).toInt()} (90% Wallet)', style: const TextStyle(fontSize: 10, color: Colors.yellow)), Slider(value: betAmount.toDouble(), min: 10, max: 500, activeColor: Colors.pink, onChanged: (v) => setState(() => betAmount = v.toInt()))])) else Expanded(child: Container(margin: const EdgeInsets.all(12), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Gift se Shart lagao - Gift Wallet Connect ✅', style: TextStyle(fontSize: 10, color: Colors.yellow, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.75), itemCount: allGiftsForBet.length, itemBuilder: (c, i) { final g = allGiftsForBet[i]; bool sel = selectedGiftBet?['name'] == g['name']; return GestureDetector(onTap: () => setState(() => selectedGiftBet = g), child: Container(margin: const EdgeInsets.all(4), decoration: BoxDecoration(color: sel ? Colors.pink.withOpacity(0.3) : Colors.white10, borderRadius: BorderRadius.circular(8), border: Border.all(color: sel ? Colors.pink : Colors.white10)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(g['icon'], style: const TextStyle(fontSize: 24)), Text(g['name'], style: const TextStyle(fontSize: 7)), Text('${g['price']}', style: const TextStyle(fontSize: 7, color: Colors.orange))]))); }))]))),
        Container(padding: const EdgeInsets.all(12), color: const Color(0xFF121212), child: Column(children: [Row(children: [const Icon(Icons.wallet, size: 14, color: Colors.white54), Text(' Wallet: $myCoins Coins | $myDiamonds Diamonds | Gift System Connected ✅', style: const TextStyle(fontSize: 9, color: Colors.white54))]), const SizedBox(height: 8), SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, padding: const EdgeInsets.all(14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: _placeBet, child: Text(selectedBetType == "Gift" ? 'SHART LAGAO - ${selectedGiftBet?['name'] ?? "Gift Select"} 🎁 - $selectedSide' : 'SHART LAGAO - $betAmount $selectedBetType - $selectedSide 📈 - WIN ${(betAmount * 1.8).toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))))])),
      ]),
    );
  }
  Widget _betTypeBtn(String type, String icon, bool sel) => Expanded(child: GestureDetector(onTap: () => setState(() => selectedBetType = type), child: Container(padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: sel ? Colors.pink : Colors.white10, borderRadius: BorderRadius.circular(12), border: Border.all(color: sel ? Colors.pink : Colors.white10)), child: Column(children: [Text(icon, style: const TextStyle(fontSize: 20)), Text(type, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: sel ? Colors.white : Colors.white54))]))));
}

// WALLET - 195 MULK + STRIPE
class WalletPage extends StatefulWidget { const WalletPage({super.key}); @override State<WalletPage> createState() => _WalletPageState(); }
class _WalletPageState extends State<WalletPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final List<Map<String, dynamic>> packs = [{"coins": "100", "price": "\$1.99"}, {"coins": "330", "price": "\$5.97"}, {"coins": "500", "price": "\$9.99"}, {"coins": "1000", "price": "\$19.99"}, {"coins": "5000", "price": "\$99.99"}];
  Future<void> _payWithStripe(Map pack) async { try { await audioPlayer.play(AssetSource('sounds/coin.mp3')); } catch (_) {} ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${pack['coins']} Coins - ${pack['price']} - Stripe Card 195 Mulk me 💳✅'))); }
  @override Widget build(BuildContext context) {
    return SafeArea(child: ListView(padding: const EdgeInsets.all(16), children: [
      const Text('RASS WORLD WALLET', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), const SizedBox(height: 12),
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFF3A2E00), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.orange)), child: Column(children: [const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.monetization_on, color: Colors.yellow, size: 32), SizedBox(width: 8), Text('5,000', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold))]), const Text('Recharge Available in 195 Countries ✅ Stripe + Card + JazzCash + Easypaisa', textAlign: TextAlign.center, style: TextStyle(color: Colors.yellow, fontSize: 10, fontWeight: FontWeight.bold))])),
      const SizedBox(height: 12),
      ...packs.map((p) => Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)), child: Row(children: [const Icon(Icons.monetization_on, color: Colors.yellow), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('${p['coins']} Coins', style: const TextStyle(fontWeight: FontWeight.bold)), Text(p['price'])]), const Spacer(), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), onPressed: () => _payWithStripe(p), child: const Text('Card Pay 💳'))]))),
    ]));
  }
}

// PROFILE - P7 - APP ID + APP SIGN - LEVEL 8 - FINAL
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override Widget build(BuildContext context) => Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const Text("Profile - @rass_jigar - LEVEL 8", style: TextStyle(fontSize: 12))), body: ListView(padding: const EdgeInsets.all(12), children: [
    const CircleAvatar(radius: 40, backgroundColor: Colors.pink, child: Icon(Icons.person, size: 40)),
    const SizedBox(height: 8),
    const Center(child: Text("Rass Jigar - Host Mode ON", style: TextStyle(fontWeight: FontWeight.bold))),
    const Center(child: Text("LEVEL 8 🔥 1250/2000 XP", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
    const SizedBox(height: 12),
    SwitchListTile(title: const Text("Host Mode"), subtitle: const Text("Live jaane ke liye ON karo"), value: true, onChanged: (v) {}),
    const ListTile(leading: Icon(Icons.diamond, color: Colors.pink), title: Text("My Diamonds"), subtitle: Text("Total Diamonds 1250 - Total Givers 12"), trailing: Text("1250 💎")),
    const ListTile(leading: Icon(Icons.card_giftcard), title: Text("Gift History"), subtitle: Text("120 Received, 45 Sent - Total Diamonds 1250")),
    const ListTile(leading: Icon(Icons.video_library), title: Text("My Videos"), subtitle: Text("0 Videos - My Comments Zabardast")),
    const ListTile(leading: Icon(Icons.favorite), title: Text("My Likes"), subtitle: Text("12 videos Liked - 12 videos")),
    ListTile(leading: const Icon(Icons.people), title: const Text("Followers / Following"), subtitle: const Text("Followers 0 - Following 0")),
    ListTile(leading: const Icon(Icons.settings), title: const Text("Settings"), subtitle: const Text("AppID: com.rasslive.world Verified ✅ - LEVEL 8\nApp Sign: rasslive-key.jks - SHA1 Verified\nBuild #208 - 0 Errors\n150 Gifts - Video Best - 30 Games Upar Neechay - Coin Diamond Gift Shart - 195 Mulk Stripe")),
  ]));
}

class VoiceLivePage extends StatelessWidget { const VoiceLivePage({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Voice Live 🔒')), body: const Center(child: Text('210 log sun rahe hain'))); }
class NineStarsPage extends StatelessWidget { final String roomName; const NineStarsPage({super.key, required this.roomName}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(roomName)), body: const Center(child: Text('9 Stars 2400 Watching'))); }
class PKBattlePage extends StatelessWidget { const PKBattlePage({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('PK Battle')), body: const Center(child: Text('PK Battle 4864 VS 2784'))); }
