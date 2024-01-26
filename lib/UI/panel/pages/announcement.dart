import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uy_admin/UI/panel/pages/product_item.dart';
import  'package:http/http.dart' as http;
import 'package:uy_admin/urls/Urls.dart';


import '../../../models/announces.dart';

class AnnouncementWidget extends StatefulWidget {
  const AnnouncementWidget({super.key});

  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {

  List<AnnouncementItem> announement=[];
  Future<void> getData()async{
    var result =  await http.get(Uri.parse(AppUrls.announce));

      if(result.statusCode==200)
        {
          var data = jsonDecode(result.body);
          announement= data["data"].map<AnnouncementItem>((e) => AnnouncementItem.fromJson(e)).toList();
          successMsg("Ma'lumotlar muvofaqqiyatli yuklandi");
          setState(() {
          });
        }
      else{
        errorMsg("Xatol yuz berdi ");
      }
  }
  void  errorMsg(String errMsg)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errMsg,style: const TextStyle(color: Colors.white),),backgroundColor: Colors.red,));
  void successMsg(String successMsg)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(successMsg,style: const TextStyle(color: Colors.white),),backgroundColor: Colors.green,));
  @override
  void initState() {
   getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: GridView.builder(
        itemCount: announement.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio:156/300,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10
      ),
          itemBuilder: (context,index)=> ProductItemWidget(announcement: announement[index],)),
    );
  }
}
