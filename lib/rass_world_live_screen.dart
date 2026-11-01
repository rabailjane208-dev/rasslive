import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';


class RassWorldLiveScreen extends StatefulWidget {
  const RassWorldLiveScreen({super.key});
  @override
  State<RassWorldLiveScreen> createState()=>_RassWorldLiveScreenState();
}
class _RassWorldLiveScreenState extends State<RassWorldLiveScreen> {
  CameraController? ctrl; bool ready=false; String tab="New"; int qty=1; int coins=0;
  
  List<Map> newGifts=[{"n":"Kiss","p":15,"i":"💋"},{"n":"Rose","p":15,"i":"🌹"},{"n":"Applause","p":30,"i":"👏"},{"n":"Lollipop","p":60,"i":"🍭"},{"n":"Party Popper","p":90,"i":"🎉"},{"n":"New Star","p":100,"i":"⭐"},{"n":"Solo","p":100,"i":"🎤"},{"n":"Broom","p":100,"i":"🧹"},{"n":"Candy","p":200,"i":"🍬"},{"n":"Skull","p":300,"i":"💀"},{"n":"Lucky Box","p":200,"i":"🎁"},{"n":"Fan Light","p":150,"i":"💡"}];
  List<Map> giftGifts=[{"n":"Pop Pass","p":1000,"i":"🎟️"},{"n":"Fan Light Board","p":1000,"i":"🎆"},{"n":"Heart Charger","p":1500,"i":"💖"},{"n":"Blue Rose","p":1500,"i":"🌹"},{"n":"Ha Ha Ha","p":1500,"i":"😂"},{"n":"Frosty","p":1500,"i":"☃️"},{"n":"I'm Here","p":1500,"i":"👋"},{"n":"Face Palm","p":1500,"i":"🤦"},{"n":"Back Massage","p":25000,"i":"💆"},{"n":"Donkey","p":30000,"i":"🐴"},{"n":"Rose Afternoon","p":40000,"i":"🌹"},{"n":"Cloud Pavilion","p":80000,"i":"☁️"},{"n":"Camel Knight","p":90000,"i":"🐪"},{"n":"Romantic Ride","p":90000,"i":"🎠"},{"n":"Marry Me","p":100000,"i":"💍"},{"n":"Pirate Booty","p":100000,"i":"🏴‍☠️"},{"n":"Cottage Coffee","p":150000,"i":"☕"},{"n":"Castle","p":200000,"i":"🏰"},{"n":"Sports Car","p":500000,"i":"🏎️"}];
  List<Map> luckyGifts=[{"n":"Swan","p":1000,"i":"🦢"},{"n":"Grace","p":2000,"i":"👑"},{"n":"Cherry","p":250,"i":"🍒"},{"n":"Lucky Star","p":500,"i":"🌟"},{"n":"Bubble Gun","p":800,"i":"🔫"},{"n":"Crystal Shoes","p":1200,"i":"👠"}];
  List<Map> fanGifts=[{"n":"Sleeping Beauty","p":36000,"i":"👸"},{"n":"Starving Prince","p":38000,"i":"🤴"},{"n":"Rainbow","p":28000,"i":"🌈"}];
  List<Map> surpriseGifts=[{"n":"Magic Book","p":150000,"i":"📖"},{"n":"Wind Chime","p":120000,"i":"🎐"},{"n":"Rocking Horse","p":120000,"i":"🐴"},{"n":"Lily Of Jackson","p":80000,"i":"🌸"},{"n":"Bumper Car","p":100000,"i":"🚗"}];


  @override
  void initState(){ super.initState(); _initCam(); }
  Future<void> _initCam() async {
    try{
      await Permission.camera.request(); await Permission.microphone.request();
      var cams=await availableCameras();
      ctrl=CameraController(cams[cams.length>1?1:0], ResolutionPreset.medium, enableAudio:true);
      await ctrl!.initialize();
      if(mounted) setState(()=>ready=true);
    }catch(e){}
  }


  @override
  Widget build(BuildContext context){
    List<Map> cur= tab=="New"?newGifts : tab=="Gift"?giftGifts : tab=="Lucky"?luckyGifts : tab=="Fan Club"?fanGifts : surpriseGifts;
    return Scaffold(backgroundColor:Colors.black, 
      appBar:AppBar(backgroundColor:Colors.black, leading:BackButton(color:Colors.white), title:Text("Rass World", style:TextStyle(color:Colors.white, fontSize:14)), actions:[Container(margin:EdgeInsets.all(8), padding:EdgeInsets.symmetric(horizontal:10, vertical:4), decoration:BoxDecoration(color:Colors.white12, borderRadius:BorderRadius.circular(20)), child:Text("💎 $coins", style:TextStyle(color:Colors.white)))]),
      body:Stack(children:[
        Positioned.fill(child: ready && ctrl!=null ? FittedBox(fit:BoxFit.cover, child:SizedBox(width:ctrl!.value.previewSize!.width, height:ctrl!.value.previewSize!.height, child:CameraPreview(ctrl!))) : Container(color:Colors.black, child:Center(child:CircularProgressIndicator(color:Colors.pink)))),
        Positioned(top:10, left:10, child:Container(padding:EdgeInsets.symmetric(horizontal:8, vertical:4), decoration:BoxDecoration(color:Colors.black54, borderRadius:BorderRadius.circular(10)), child:Text("Rass World LIVE 🔴 Viewers 1257 Score 100 ID 1257 Hour 14 Battery 44%", style:TextStyle(color:Colors.white, fontSize:9, fontWeight:FontWeight.bold)))),
        Positioned(bottom:0, left:0, right:0, child:Container(height:360, decoration:BoxDecoration(color:Color(0xFF121212), borderRadius:BorderRadius.vertical(top:Radius.circular(20))), child:Column(children:[
          Padding(padding:EdgeInsets.fromLTRB(10,10,10,6), child:SingleChildScrollView(scrollDirection:Axis.horizontal, child:Row(children:["New","Gift","Lucky","Fan Club","Surprise Shop"].map((t)=> GestureDetector(onTap:()=>setState(()=>tab=t), child:Container(margin:EdgeInsets.only(right:8), padding:EdgeInsets.symmetric(horizontal:14, vertical:7), decoration:BoxDecoration(color:tab==t?Colors.pink:Color(0xFF2A2A2A), borderRadius:BorderRadius.circular(20)), child:Text(t, style:TextStyle(color:Colors.white, fontSize:12, fontWeight:FontWeight.bold))))).toList()))),
          Expanded(child:GridView.builder(padding:EdgeInsets.symmetric(horizontal:10, vertical:6), gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4, childAspectRatio:0.92, crossAxisSpacing:8, mainAxisSpacing:8), itemCount:cur.length, itemBuilder:(_,i){
            var g=cur[i];
            return Container(decoration:BoxDecoration(color:Color(0xFF1E1E1E), borderRadius:BorderRadius.circular(14), border:Border.all(color:Colors.white12)), child:Column(mainAxisAlignment:MainAxisAlignment.center, children:[
              Text(g["i"], style:TextStyle(fontSize:26)), SizedBox(height:4),
              Text(g["n"], style:TextStyle(color:Colors.white, fontSize:8, fontWeight:FontWeight.w500), textAlign:TextAlign.center, maxLines:1, overflow: TextOverflow.ellipsis),
              SizedBox(height:2), Row(mainAxisAlignment:MainAxisAlignment.center, children:[Icon(Icons.monetization_on, color:Colors.yellow, size:10), SizedBox(width:2), Text("${g["p"]}", style:TextStyle(color:Colors.yellow, fontSize:9, fontWeight:FontWeight.bold))]),
            ]));
          })),
          Container(padding:EdgeInsets.fromLTRB(10,6,10,10), decoration:BoxDecoration(color:Color(0xFF1A1A1A)), child:Row(children:[
            Container(padding:EdgeInsets.symmetric(horizontal:8, vertical:4), decoration:BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(8)), child:Text("$qty", style:TextStyle(color:Colors.black, fontWeight:FontWeight.bold, fontSize:12))),
            SizedBox(width:6), ...[1,10,50].map((q)=> GestureDetector(onTap:()=>setState(()=>qty=q), child:Container(margin:EdgeInsets.only(right:4), padding:EdgeInsets.symmetric(horizontal:10, vertical:6), decoration:BoxDecoration(color:qty==q?Colors.white:Color(0xFF2A2A2A), borderRadius:BorderRadius.circular(8)), child:Text("$q", style:TextStyle(color:qty==q?Colors.black:Colors.white, fontSize:11))))).toList(),
            Spacer(), ElevatedButton(onPressed:(){}, style:ElevatedButton.styleFrom(backgroundColor:Color(0xFF1976D2), shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)), padding:EdgeInsets.symmetric(horizontal:24, vertical:10)), child:Text("Send", style:TextStyle(color:Colors.white, fontWeight:FontWeight.bold))),
          ])),
        ]))),
      ]));
  }
}