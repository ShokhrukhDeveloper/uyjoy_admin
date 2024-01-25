
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uy_admin/UI/widgets/custom_text_field.dart';
import 'package:uy_admin/models/announce_details.dart';

import '../../../urls/Urls.dart';
import '../../widgets/checkbox_grid.dart';
import '../../widgets/custom_addtional_button.dart';
import '../../widgets/custom_description.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_price_field.dart';
import '../../widgets/sized_config.dart';


class AnnouncementAdd extends StatefulWidget {
  const AnnouncementAdd({super.key, required this.onTapBack});
  final VoidCallback onTapBack;

  @override
  State<AnnouncementAdd> createState() => _AnnouncementAddState();
}

class _AnnouncementAddState extends State<AnnouncementAdd> {
  List<String> names=[];
  List<AnnounceDetail> apartementHas=[];
  List<AnnounceDetail> layout=[];
  List<AnnounceDetail> nearby=[];
  List<AnnounceDetail> repair=[];
  List<AnnounceDetail> typeOfBuilding=[];
 Future<void>_send()async{
    setState(() {
      loading=true;
    });
    try{
      var request = http.MultipartRequest('POST', Uri.parse(AppUrls.announce));
      request.fields.addAll({
        'Price': '${priceController?.text}',
        'Title': '${titleController?.text}',
        'Description': '${descriptionController?.text}',
        'RoomQuantity': '${roomQuantityController?.text}',
        'Square': '${totalSquareController?.text}',
        'MaxFloor': '${maxFloorController?.text}',
        'Floor': '${floorController?.text}',
        'KitchenSquare': '${kitchenSquareController?.text}',
        'BuilderType': '${builderTypeController?.text}',
        'Year': '${yearController?.text}',
        'Repair': '${repairController?.text}',
        'Height': '56m',
        'FlatHasThings': '${flatHasThingsController?.text}',
        'MaklerPrice': 'true'
      });
      var i=0;
      // for(var img in images){
      //   final multipartFile = http.MultipartFile.fromBytes('Images', img,filename: names[i]);
      //   request.files.add(multipartFile);
      //   i++;
      // }
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        successMsg("Muvofaqqiyatli qo'shildi : ${titleController?.text}");
        widget.onTapBack.call();
      }
      else {
        loading=false;
        setState(() {

        });
        errorMsg("So'rovda  xatolik code: ${response.statusCode} reason:${response.statusCode}");
      }
    }catch(e){
      errorMsg("Xatolik yuz berdi: $e");
    }
   

 }

Future<void> getDetail()async{
   var result = await http.get(Uri.parse(AppUrls.announceDetail));
   print(result.body);
   if(result.statusCode==200){

     var res=jsonDecode(result.body);
    apartementHas=res["data"]["apartementHas"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
    layout=res["data"]["layout"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
    nearby=res["data"]["nearby"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
    typeOfBuilding=res["data"]["typeOfBuilding"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
    repair=res["data"]["repair"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();

   }

}
 void  errorMsg(String errMsg)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errMsg,style: const TextStyle(color: Colors.white),),backgroundColor: Colors.red,));
 void successMsg(String successMsg)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(successMsg,style: const TextStyle(color: Colors.white),),backgroundColor: Colors.green,));
  List<Uint8List?> images= List.filled(10, null);
  Future<void> _pickFile(int index) async {
    var result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      names.add(result.name);
     var img = await result.readAsBytes();
     images[index]=img;
      setState(()  {
      });
    }
  }
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? roomQuantityController;
  TextEditingController? descriptionController;
  TextEditingController? totalSquareController;
  TextEditingController? liveSquareController;
  TextEditingController? kitchenSquareController;
  TextEditingController? floorController;
  TextEditingController? maxFloorController;
  TextEditingController? builderTypeController;
  TextEditingController? yearController;
  TextEditingController? repairController;
  TextEditingController? flatHasThingsController;
  TextEditingController? contactController;
  @override
  void initState() {
    getDetail();
    priceController=TextEditingController();
    titleController=TextEditingController();
    descriptionController=TextEditingController();
    roomQuantityController=TextEditingController();
    totalSquareController=TextEditingController();
    maxFloorController=TextEditingController();
    floorController=TextEditingController();
    kitchenSquareController=TextEditingController();
    builderTypeController=TextEditingController();
    yearController=TextEditingController();
    repairController=TextEditingController();
    flatHasThingsController=TextEditingController();
    contactController=TextEditingController();
    super.initState();
  }
 var negotiable=true;
  @override
  void dispose() {
    priceController?.dispose();
    titleController?.dispose();
    descriptionController?.dispose();
    roomQuantityController?.dispose();
    totalSquareController?.dispose();
    maxFloorController?.dispose();
    floorController?.dispose();
    kitchenSquareController?.dispose();
    builderTypeController?.dispose();
    yearController?.dispose();
    repairController?.dispose();
    flatHasThingsController?.dispose();
    contactController?.dispose();
    super.dispose();
  }

  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: widget.onTapBack,
        ),
      ),
      body: loading?
      const Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        child: Center(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //title
              CustomTextFiled(controller: titleController,label: "Sarlavhani Masalan, 2 xonali uy sotiladi", hint: "Sarlavhani kiriting*",maxLength: 50,),
             //images
              SizedBox(
                width: SizeConfig().widthSize(context, 40.5),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1
                    ),
                    itemBuilder: (c,i)=>InkWell(
                      onTap: ()=>_pickFile(i),
                        child:images[i]!=null? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(images[i]!,width: 150,height: 150,fit: BoxFit.cover,))
                    :Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.camera_enhance_sharp),),
                    ))),
              ),
              //description
              CustomDescriptionFiled(controller:descriptionController, hint:  "Tavsif", label: "Ushbu elon haqida odamlar blishi uchun ko'proq tavsilotlarni yozing",maxLength: 5000,),
              //Price
              CustomPriceFiled(
                controller: priceController,
                label: "",
                hint: "Narx*",
                priceType: true,
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                onChangedType: (bool? type) {  },
                onChangedNegotiable: (bool? type) { negotiable=type!; },
                negotiable: negotiable, negotiableText: "Kelishuv asosida",),
              //Addintinal info
              CustomAdditonalButton(
                textValue1: 'Yangi',
                textValue2: 'Eski',
                value: true,
                onChanged: (bool value) {  },
                text: 'Turarjoy turi*',),
              // Total rooms
              CustomTextFiled(
                  controller: roomQuantityController,
                  label: "",
                  hint: "Xonalar soni*",
                  maxLength: 2,
                  formatter: [FilteringTextInputFormatter.digitsOnly],
              ),
              // Total square
              CustomTextFiled(
                  controller: totalSquareController,
                  label: "",
                  suffixText:  "m\u00b2",
                  hint: "Umumiy maydon*",
                  maxLength: 3,
                  formatter: [FilteringTextInputFormatter.digitsOnly],
              ),
              //live square
              CustomTextFiled(
                  controller: liveSquareController,
                  label: "m\u00b2",
                  maxLength: 3,
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  hint: "Yashash maydoni"),
              //kitchen square
              CustomTextFiled(
                  controller: kitchenSquareController,
                  label: "m\u00b2",
                  hint: "Oshxona maydoni",maxLength: 3,),
              //FLOOR
              CustomTextFiled(
                  controller: floorController,
                  label: "", hint: "Qavati*",
                  maxLength: 3,
              ),
              // etajnost
              CustomTextFiled(
                  controller: maxFloorController,
                  label: "",
                  hint: "Uy qavatliligi*",

              ),
              //type of building
              CustomDropDown(
              hint: "Qurilish turi",
                options: typeOfBuilding,),
              //PLANE
              CustomDropDown(
                hint: 'Rejasi',
                options: layout,),
              //year
              // CustomDropDown(
              //   hint: "Uy qurilgan/topshiriladigan yil",
              //   options: const ["1997", "1397", "1998"],),
              //furnished
              CustomAdditonalButton(
                textValue1: 'Ha',
                textValue2: "Yo'q",
                value: true,
                onChanged: (bool value) {  },
                text: 'Mebelli*',),
              //apartmerent has
              CheckboxGrid(hint: 'Kvartirada bor', items: apartementHas,),
              // nearby
              CheckboxGrid(hint: 'Yaqinida joylashgan', items: nearby,),
              // is makler price has
              CustomAdditonalButton(
                textValue1: 'Bor',
                textValue2: "Yo'q",
                value: true,
                onChanged: (bool value) {  },
                text: 'Vositachilik haqqi*',),
              CustomTextFiled(
                controller: kitchenSquareController,
                label: "",
                hint: "Telefon raqami",
                maxLength: 13,
              ),
              InkWell(
                onTap: _send,
                child: Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 10),
                  height: 40,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:Colors.green
                  ),
                  child: const Center(child: Text("E`lonni joylashtirish",style:  TextStyle(color: Colors.white),)),
                ),
              ),
              const SizedBox(height: 200,)

            ],
          ),
        ),
      ),
    );
  }
}
