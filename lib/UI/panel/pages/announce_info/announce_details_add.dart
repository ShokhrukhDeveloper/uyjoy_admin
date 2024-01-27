import 'package:flutter/material.dart';

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
  MapEntry<String,String>? value;
  String? url=AppUrls.announceDetailRepair;
  Future<void> addDetail()async{
    showDialog(context: context, builder: (x)=> AlertDialog(
      title: Text(""),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            isDense: true,
            isExpanded: true,
            value: AppUrls.announceDetailRepair,
            items: const [
              DropdownMenuItem(
                value: AppUrls.announceDetailRepair,
                child: Text("Ta'mirlash"),
              ),
              DropdownMenuItem(
                value: AppUrls.announceDetailNearby,
                child: Text("Yaqinida joylashgan"),
              ),
              DropdownMenuItem(
                value: AppUrls.announceDetailLayout,
                child: Text("Rejasi"),
              ),
              DropdownMenuItem(
                value: AppUrls.announceDetailApartementHas,
                child: Text("Kvartirada bor"),
              ),
              DropdownMenuItem(
                value: AppUrls.announceDetailTypeOfBuilding,
                child: Text("Qurilish turi"),
              ),
            ],
            onChanged: (newValue) {
              setState(() {

                if(newValue!=null){
                  url=newValue;
                }
              });
            },
          ),
          const SizedBox(height: 20),

          CustomTextFiled(hint: "Uz"),
          CustomTextFiled(hint: "Ru"),
        ],
      ),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(

        child: Center(
          child:  AlertDialog(
            title: Text(""),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<MapEntry<String,String>>(
                  isDense: true,
                  isExpanded: true,
                  value: value??pickItem.entries.first,
                  items: pickItem.entries.map((e) =>
                      DropdownMenuItem<MapEntry<String,String>>(
                        value: e,
                        child: Text(e.key),
                      )).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      if(newValue!=null){
                        value=newValue;
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),

                CustomTextFiled(hint: "Uz"),
                CustomTextFiled(hint: "Ru"),
              ],
            ),
          )
        ),
      ),
    );
  }
}

