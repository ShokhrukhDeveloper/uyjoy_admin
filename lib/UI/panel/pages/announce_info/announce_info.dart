import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uy_admin/UI/panel/pages/announce_info/announce_details_add.dart';
import 'package:uy_admin/storage/LocalStoage.dart';

import '../../../../models/announce_details.dart';
import '../../../../urls/Urls.dart';
class AnnounceInfo extends StatefulWidget {
  const AnnounceInfo({super.key});

  @override
  State<AnnounceInfo> createState() => _AnnounceDetailsState();
}

class _AnnounceDetailsState extends State<AnnounceInfo> {
  List<AnnounceDetail> apartementHas=[];
  List<AnnounceDetail> layout=[];
  List<AnnounceDetail> nearby=[];
  List<AnnounceDetail> repair=[];
  List<AnnounceDetail> typeOfBuilding=[];
  List<AnnounceDetail> current=[];
  List<AnnounceDetail> a=[AnnounceDetail(id: 0,uz: "",ru: "")];

  Future<void> getDetail()async{
    var result = await http.get(Uri.parse(AppUrls.announceDetail),
        headers: {
      "Authorization":"Bearer ${LocalStorage.accessToken}"}
    );
    if (kDebugMode) {
      print(result.statusCode);
      print(result.headers["WWW-Authenticate"]);
    }
    if(result.statusCode==200){
      var res = jsonDecode(result.body);
      apartementHas=res["data"]["apartementHas"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
      layout=res["data"]["layout"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
      nearby=res["data"]["nearby"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
      typeOfBuilding=res["data"]["typeOfBuilding"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
      repair=res["data"]["repair"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
      current=repair;
      loading=false;
      setState(() {});
    }
  }

  @override
  void initState() {
    getDetail();
    super.initState();
  }
  var loading=true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          SizedBox(
          height: 30,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(padding:EdgeInsets.zero,
                  onPressed: ()async{
                   await showDialog(context: context, builder: (c)=>const AnnounceAddDetails());
                   getDetail();
                  }, icon: const Icon(Icons.add)),
              TextButton(onPressed: (){
                current=repair;
                setState(() {
                });
              },
                  child: const Text("Ta'mir")),
              TextButton(onPressed: (){
                current=nearby;
                setState(() {
                });
              }, child: const Text("Yaqinida joylashgan")),
              TextButton(onPressed: (){
                current=layout;
                setState(() {

                });
              }, child: const Text("Rejasi")),
              TextButton(onPressed: (){
                current=apartementHas;
                setState(() {

                });
              }, child: const Text("Kvartirada bor")),
              TextButton(onPressed: (){
                current=typeOfBuilding;
                setState(() {
                });
              }, child: const Text("Qurilish turi")),

            ],
          ),
         ),
          Expanded(
            child: ListView.builder(
                itemCount:current.length ,
                itemBuilder: (context,index)=>Card(
                  child: ListTile(
                    title: Text(current[index].uz),
                    subtitle: Text(current[index].ru),
                    trailing: IconButton(onPressed: (){},icon: const Icon(Icons.edit,color: Colors.deepOrangeAccent,),),
                  ),

                )),
          )
        ],
      ),
    );
  }
}
