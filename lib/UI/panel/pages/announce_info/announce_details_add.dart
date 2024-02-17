import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../storage/LocalStoage.dart';
import '../../../../urls/Urls.dart';
import '../../../widgets/custom_text_field.dart';
class AnnounceAddDetails extends StatefulWidget {
  const AnnounceAddDetails({super.key});

  @override
  State<AnnounceAddDetails> createState() => _AnnounceAddDetailsState();
}

class _AnnounceAddDetailsState extends State<AnnounceAddDetails> {
  var pickItem={
    "Ta'mir":AppUrls.announceDetailRepair,
    "Yaqinida joylashgan":AppUrls.announceDetailNearby,
    "Rejasi":AppUrls.announceDetailLayout,
    "Kvartirada bor":AppUrls.announceDetailApartementHas,
    "Qurilish turi":AppUrls.announceDetailTypeOfBuilding,
  };
  var loading=false;
  MapEntry<String,String>? value=const MapEntry<String,String>("Ta'mir",AppUrls.announceDetailRepair);
  String? url=AppUrls.announceDetailRepair;
 TextEditingController uzController=TextEditingController();
 TextEditingController ruController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child:loading?const CircularProgressIndicator():  AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<MapEntry<String,String>>(
                isDense: true,
                isExpanded: true,
                hint: Text(value?.key??""),
                items: pickItem.entries.map<DropdownMenuItem<MapEntry<String,String>>>((e) =>
                    DropdownMenuItem<MapEntry<String,String>>(
                      value: e,
                      child: Text(e.key),
                    )).toList(),
                onChanged: (newValue) {
                  setState(() {
                    if(newValue!=null){
                      value=newValue;
                      url=value?.value;
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomTextFiled(hint: "Uzbekchasi",controller: uzController,),
              CustomTextFiled(hint: "Ruschasi",controller: ruController,),
              const SizedBox(height: 20),
              InkWell(
                onTap: (){
                  if(uzController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("O'zbekcha nomini kiriting",style:TextStyle(color: Colors.white),),backgroundColor: Colors.red,));
                    return;
                  }
                  if(ruController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Ruscha nomini kiriting",style:TextStyle(color: Colors.white),),backgroundColor: Colors.red,));
                    return;
                  }
                  if(url!=null)_addItem(url!, uz: uzController.text, ru: ruController.text);
                },
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:Colors.green
                  ),
                  child: const Center(child: Text("Qo'shish",style:  TextStyle(color: Colors.white),)),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  Future<void> _addItem(String url, {required String uz, required String ru})async {
    loading=true;
    setState(() {

    });
    try{
      var response = await http.post(Uri.parse(url), headers: {
        "Authorization":"Bearer ${LocalStorage.accessToken}",
        "Accept": "application/json",
        "content-type": "application/json"
      },body: jsonEncode({
        "uz": uz,
        "ru": ru
      }));
      print(response.statusCode);
      print(response.body);
      if(response.statusCode==200)
      {
        loading=false;
        setState(() {
        Navigator.pop(context);
        });
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Muvoffaqiyatli qo'shildi",style:TextStyle(color: Colors.white),),backgroundColor: Colors.green,));

      }
    }catch(e)
    {loading=false;
      setState(() {

      });
    }

  }
}

