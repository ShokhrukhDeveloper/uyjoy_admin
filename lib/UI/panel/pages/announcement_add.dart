
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:uy_admin/UI/widgets/custom_text_field.dart';


class AnnouncementAdd extends StatefulWidget {
  const AnnouncementAdd({super.key, required this.onTapBack});
  final VoidCallback onTapBack;

  @override
  State<AnnouncementAdd> createState() => _AnnouncementAddState();
}

class _AnnouncementAddState extends State<AnnouncementAdd> {
  List<String> names=[];
 Future<void>_send()async{
    setState(() {
      loading=true;
    });
    try{
      var request = http.MultipartRequest('POST', Uri.parse('http://localhost:5214/Announcement'));
      request.fields.addAll({
        'Price': '${priceController?.text}',
        'Title': '${titleController?.text}',
        'Description': '${descriptionController?.text}',
        'RoomQuantity': '${roomQuantityController?.text}',
        'Square': '${squareController?.text}',
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
      for(var img in images){
        final multipartFile = http.MultipartFile.fromBytes('Images', img,filename: names[i]);
        request.files.add(multipartFile);
        i++;
      }
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        successMsg("Muvofaqqiyatli qo'shildi : ${titleController?.text}");

      }
      else {
        errorMsg("So'rovda  xatolik code: ${response.statusCode} reason:${response.statusCode}");
      }
    }catch(e){
      errorMsg("Xatolik yuz berdi: $e");
    }
   

 }
 void errorMsg(String errMsg)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errMsg,style: const TextStyle(color: Colors.white),),backgroundColor: Colors.red,));
 void successMsg(String successMsg)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(successMsg,style: const TextStyle(color: Colors.white),),backgroundColor: Colors.green,));
  List<Uint8List> images=[];
  Future<void> _pickFile() async {
    var result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      names.add(result.name);
     var img = await result.readAsBytes();
     images.add(img);
      setState(()  {
      });
    }
  }
  TextEditingController? priceController;
  TextEditingController? titleController;
  TextEditingController? maklerPriceController;
  TextEditingController? descriptionController;
  TextEditingController? roomQuantityController;
  TextEditingController? squareController;
  TextEditingController? maxFloorController;
  TextEditingController? floorController;
  TextEditingController? kitchenSquareController;
  TextEditingController? builderTypeController;
  TextEditingController? yearController;
  TextEditingController? repairController;
  TextEditingController? flatHasThingsController;
  TextEditingController? contactController;
  @override
  void initState() {
    priceController=TextEditingController();
    titleController=TextEditingController();
    maklerPriceController=TextEditingController();
    descriptionController=TextEditingController();
    roomQuantityController=TextEditingController();
    squareController=TextEditingController();
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
  @override
  void dispose() {
    priceController?.dispose();
    titleController?.dispose();
    maklerPriceController?.dispose();
    descriptionController?.dispose();
    roomQuantityController?.dispose();
    squareController?.dispose();
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
      body: loading?const Center(child: CircularProgressIndicator()):  SingleChildScrollView(
        child: Center(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFiled(controller: titleController,label: "Nomini yozing", hint: "nomi"),
              CustomTextFiled(controller: priceController,label: "Narxini yozing", hint: "narxi"),
              CustomTextFiled(controller: descriptionController,label: "Qo'shimcha ma'lumotlar", hint: "ma'lumot yozing"),
              CustomTextFiled(controller: roomQuantityController,label: "Xonalar soni", hint: "soni"),
              CustomTextFiled(controller: squareController,label: "Umumiy maydoni", hint: "maydon"),
              CustomTextFiled(controller: maxFloorController,label: "Qavatlar soni", hint: "qavatliligi"),
              CustomTextFiled(controller: floorController,label: "Joylashgan qavati", hint: "qavati"),
              CustomTextFiled(controller: kitchenSquareController,label: "Oshxona maydoni", hint: "oshona maydoni"),
              CustomTextFiled(controller: builderTypeController,label: "Qurilish turi", hint: "qurilish turi"),
              CustomTextFiled(controller: yearController,label: "Qurilgan yili", hint: "yili"),
              CustomTextFiled(controller: repairController,label: "Ta'mirlangangligi ", hint: "ta'mirlanganligi"),
              CustomTextFiled(controller: flatHasThingsController,label: "Kvartirada bor narsalar", hint: "narsalari"),
              Wrap(
                  children: images.map((e) =>Container(
                    width:150,height: 150,
                   margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                      border: Border.all(color: Colors.green,width: 2)
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(e,width: 150,height: 150,fit: BoxFit.cover,)),
                  ) ).toList(),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: _pickFile,
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.deepPurple)
                  ),
                  child: const Icon(Icons.add_photo_alternate_outlined,color:Colors.white,size: 56,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: _send,
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.deepPurple)
                  ),
                  child: const Icon(Icons.send,color:Colors.white,size: 30,),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
