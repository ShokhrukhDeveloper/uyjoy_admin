
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uy_admin/UI/widgets/custom_text_field.dart';
import 'package:uy_admin/models/announce_details.dart';

import '../../../../urls/Urls.dart';
import '../../../widgets/checkbox_grid.dart';
import '../../../widgets/custom_addtional_button.dart';
import '../../../widgets/custom_description.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_price_field.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/sized_config.dart';


class AnnouncementAdd extends StatefulWidget {
  const AnnouncementAdd({super.key, required this.onTapBack});
  final VoidCallback onTapBack;

  @override
  State<AnnouncementAdd> createState() => _AnnouncementAddState();
}

class _AnnouncementAddState extends State<AnnouncementAdd> {
  List<String?> names=List.generate(10, (index) => null);
  List<AnnounceDetail> apartementHas=[];
  List<AnnounceDetail> layout=[];
  List<AnnounceDetail> nearby=[];
  List<AnnounceDetail> repair=[];
  List<AnnounceDetail> typeOfBuilding=[];

 Future<void>_send(int id)async {
   setState(() {
     loading=true;
   });
   try{
     var request = http.MultipartRequest('POST', Uri.parse("${AppUrls.announceUploadImage}/$id"));
     request.headers.addAll({'Content-Type': 'multipart/form-data','accept': '*/*'});
     for(int i=0; i<images.length;i++)
     {
       if(images[i]!=null)
       {
         request.files.add(http.MultipartFile.fromBytes("files", images[i]! ,filename: names[i]));
       }
     }

     var response = await request.send();
     if (kDebugMode) {
       print(response.statusCode);
       print(response.reasonPhrase);
     }

     if (response.statusCode == 200) {
       successMsg("Muvofaqqiyatli qo'shildi : ${titleController?.text}");
       // widget.onTapBack.call();
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
   if (kDebugMode) {
     print(result.body);
   }
   if(result.statusCode==200){
    var res=jsonDecode(result.body);
    apartementHas=res["data"]["apartementHas"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
    layout=res["data"]["layout"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
    nearby=res["data"]["nearby"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
    typeOfBuilding=res["data"]["typeOfBuilding"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
    repair=res["data"]["repair"].map<AnnounceDetail>((e) => AnnounceDetail.fromJson(e)).toList();
    loading=false;
    setState(() {

    });
   }

}

Future<void> createNew({
    required int price,
    required bool priceType,
    required String? title,
    required String? description,
    required int? typeOfBuildingId,
    required int? regionId,
    required int? repairId,
    required int? layoutId,
    required int? totalSpace,
    required int? numberOfStoreys,
    required int? numberOfRooms,
    required int? livingSpace,
    required int? kitchenSpace,
    required int? year,
    required int? ceilingHeight,
    required bool maklerPrice,
    required bool isFurnished,
    required bool isNegotiable,
    required bool isNewBuilding,
    required String? contactPhone,
    required List<AnnounceDetail> apartmentHas,
    required List<AnnounceDetail> nearby})async{
      List<AnnounceDetail> apartmentHases=[];
      List<AnnounceDetail> nearbies=[];
      for(var i in apartmentHas)
        {
          if(i.isSelected)apartmentHases.add(i);
        }
      for(var i in nearby)
      {
        if(i.isSelected)nearbies.add(i);
      }
    var response = await http.post(Uri.parse(AppUrls.announce),
    headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    },
    body: json.encode({
      "priceType": priceType,
      "price": price,
      "title": title,
      "description": description,
      "typeOfBuildingId": typeOfBuildingId,
      "regionId": regionId,
      "repairId": repairId,
      "layoutId": layoutId,
      "totalSpace": totalSpace,
      "numberOfStoreys": numberOfStoreys,
      "numberOfRooms": numberOfRooms,
      "livingSpace": livingSpace,
      "kitchenSpace": kitchenSpace,
      "year": year,
      "ceilingHeight": ceilingHeight,
      "maklerPrice": maklerPrice,
      "isFurnished": isFurnished,
      "isNegotiable": isNegotiable,
      "isNewBuilding": isNewBuilding,
      "contactPhone": contactPhone,
          "apartementHas": apartmentHases.map<Map>((e) =>
          {
            "id": e.id,
            "uz": "-",
            "ru": "-"
          }).toList(),
          "nearby":  nearbies.map<Map>((e) =>
          {
            "id": e.id,
            "uz": "-",
            "ru": "-"
          }).toList()
    }));
      if(response.statusCode==200)_send(14);

  }
 void  errorMsg(String errMsg)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errMsg,style: const TextStyle(color: Colors.white),),backgroundColor: Colors.red,));
 void successMsg(String successMsg)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(successMsg,style: const TextStyle(color: Colors.white),),backgroundColor: Colors.green,));
  List<Uint8List?> images= List.filled(10, null);
  Future<void> _pickFile(int index) async {
    var result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      names[index]=result.name;
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
  TextEditingController? numberOfStoreys;
  TextEditingController? builderTypeController;
  TextEditingController? yearController;
  TextEditingController? repairController;
  DateTime year=DateTime.now();
  bool priceType=true;
  bool isNewBuilding=true;
  bool isFurnished=false;
  bool negotiable=true;
  bool maklerPrice=true;
  AnnounceDetail? buildingType;
  AnnounceDetail? buildingLayout;
  AnnounceDetail? buildingRepair;

  TextEditingController? contactController;
  @override
  void initState() {
    getDetail();
    priceController=TextEditingController();
    titleController=TextEditingController();
    descriptionController=TextEditingController();
    roomQuantityController=TextEditingController();
    totalSquareController=TextEditingController();
    numberOfStoreys=TextEditingController();
    floorController=TextEditingController();
    kitchenSquareController=TextEditingController();
    builderTypeController=TextEditingController();
    yearController=TextEditingController();
    repairController=TextEditingController();
    contactController=TextEditingController();
    liveSquareController=TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    priceController?.dispose();
    titleController?.dispose();
    descriptionController?.dispose();
    roomQuantityController?.dispose();
    totalSquareController?.dispose();
    numberOfStoreys?.dispose();
    floorController?.dispose();
    kitchenSquareController?.dispose();
    builderTypeController?.dispose();
    yearController?.dispose();
    repairController?.dispose();
    contactController?.dispose();
    liveSquareController?.dispose();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  bool loading=true;
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
          child:Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //title
                CustomTextFiled(
                  validator: (s){
                    if(s==null){
                      return "To'ldirish majburiy";
                    }
                    if(s.length<2){
                      return "Kamida 2ta belgi";
                    }
                    return null;
                  },
                  controller: titleController,
                  label: "Sarlavhani Masalan, 2 xonali uy sotiladi",
                  hint: "Sarlavhani kiriting*",
                  maxLength: 50),
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
                CustomDescriptionFiled(
                  controller:descriptionController,
                  hint:  "Tavsif",
                  label: "Ushbu e`lon haqida odamlar bilishi uchun ko'proq tavsilotlarni yozing",
                  maxLength: 5000,),
                //Price
                CustomPriceFiled(
                  controller: priceController,
                  label: " ",
                  hint: "Narx*",
                  priceType: priceType,
                    formatter: [FilteringTextInputFormatter.digitsOnly],
                  onChangedType: (bool? type) {
                    if(type!=null)priceType=type;
                  },
                  onChangedNegotiable: (bool? type) {
                    if(type!=null)negotiable=type; },
                  negotiable: negotiable, negotiableText: "Kelishuv asosida",),
                //Addintinal info
                CustomAdditonalButton(
                  textValue1: 'Yangi',
                  textValue2: 'Eski',
                  value: isNewBuilding,
                  onChanged: (bool value) {
                    isNewBuilding=value;
                  },
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
                    label: "m\u00b2",
                    suffixText:  "m\u00b2",
                    hint: "Umumiy maydon*",
                    maxLength: 3,
                    formatter: [FilteringTextInputFormatter.digitsOnly],
                ),
                //live square
                CustomTextFiled(
                    controller: liveSquareController,
                    label: "m\u00b2",
                    suffixText:  "m\u00b2",
                    maxLength: 3,
                    formatter: [FilteringTextInputFormatter.digitsOnly],
                    hint: "Yashash maydoni"),
                //kitchen square
                CustomTextFiled(
                    controller: kitchenSquareController,
                    label: "m\u00b2",
                  suffixText:  "m\u00b2",
                    hint: "Oshxona maydoni",maxLength: 3,),
                //FLOOR
                CustomTextFiled(
                    controller: floorController,
                    label: "",
                    hint: "Qavati*",
                    maxLength: 3,
                ),
                // etajnost
                CustomTextFiled(
                    controller: numberOfStoreys,
                    label: "",
                    hint: "Uy qavatliligi*",

                ),
                //type of building
                CustomDropDown(
                hint: "Qurilish turi",
                  options: typeOfBuilding,
                  onChanged: (AnnounceDetail announceDetail) {
                    buildingType=announceDetail;
                  },),
                //PLANE
                CustomDropDown(
                  hint: 'Rejasi',
                  options: layout,
                  onChanged: (AnnounceDetail announceDetail) {
                    buildingLayout=announceDetail;
                  },),
                //repair
                CustomDropDown(
                  hint: 'Taʼmiri',
                  options: repair,
                  onChanged: (AnnounceDetail announceDetail) {
                    buildingRepair=announceDetail;
                  },),
                //year
                DatePickerWidget(onChanged: (DateTime dateTime) {
                year=dateTime;
                },),
                //furnished
                CustomAdditonalButton(
                  textValue1: 'Ha',
                  textValue2: "Yo'q",
                  value: isFurnished,
                  onChanged: (bool value) {
                    isFurnished=value;
                  },
                  text: 'Mebelli*',),
                //apartmerent has
                CheckboxGrid(hint: 'Kvartirada bor', items: apartementHas,),
                // nearby
                CheckboxGrid(hint: 'Yaqinida joylashgan', items: nearby,),
                // is makler price has
                CustomAdditonalButton(
                  textValue1: 'Bor',
                  textValue2: "Yo'q",
                  value: maklerPrice,
                  onChanged: (bool value) {
                    maklerPrice=value;
                  },
                  text: 'Vositachilik haqqi*',),
                // Contact
                CustomTextFiled(
                  controller: contactController,
                  label: "+998912345678",
                  hint: "Telefon raqami",
                  maxLength: 13,
                ),
                //upload button
                InkWell(
                  onTap: (){
                   var result = _formKey.currentState?.validate();
                   if (kDebugMode) {
                     print(result);
                   }
                   _send(11);
                    // createNew(
                    //     price: int.parse(priceController?.text??""),
                    //     priceType: priceType,
                    //     title: titleController?.text,
                    //     description: descriptionController?.text,
                    //     typeOfBuildingId: buildingType?.id,
                    //     regionId: 1,
                    //     repairId: buildingRepair?.id,
                    //     layoutId: buildingLayout?.id,
                    //     totalSpace: int.parse(totalSquareController?.text??"0"),
                    //     numberOfStoreys: int.parse(numberOfStoreys?.text??"0"),
                    //     numberOfRooms: int.parse(roomQuantityController?.text??"0"),
                    //     livingSpace: int.parse(liveSquareController?.text??"0"),
                    //     kitchenSpace: int.parse(kitchenSquareController?.text??"0"),
                    //     year: year.year,
                    //     ceilingHeight:270,
                    //     maklerPrice: maklerPrice,
                    //     isFurnished: isFurnished,
                    //     isNegotiable: negotiable,
                    //     isNewBuilding: isNewBuilding,
                    //     contactPhone: contactController?.text,
                    //     apartmentHas: apartementHas,
                    //     nearby: nearby);
                  },
                  child: Container(
                    width: 200,
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
      ),
    );
  }
}
