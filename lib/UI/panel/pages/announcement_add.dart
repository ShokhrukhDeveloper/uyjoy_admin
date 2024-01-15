
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

   var request = http.MultipartRequest('POST', Uri.parse('http://localhost:5214/Announcement'));
   request.fields.addAll({
     'Price': '5454',
     'Title': 'sADFASDLKFJHASLDJKFFJHLK',
     'Description': 'ASDFASDFASDF',
     'RoomQuantity': '3',
     'Square': '56',
     'MaxFloor': '5',
     'Floor': '45',
     'KitchenSquare': '45',
     'BuilderType': 'ASWDRFawer awer',
     'Year': '1989',
     'Repair': 'awsdfasdrfa',
     'Height': 'asdfasdf',
     'FlatHasThings': 'asdfasdf',
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
     print(await response.stream.bytesToString());
   }
   else {
     print("----------------------------");
     print(response.statusCode);
     print(response.reasonPhrase);
     print("----------------------------");
   }

 }
 
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
  TextEditingController priceController=TextEditingController();
  TextEditingController titleController=TextEditingController();
  TextEditingController maklerPriceController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController roomQuantityController=TextEditingController();
  TextEditingController squareController=TextEditingController();
  TextEditingController maxFloorController=TextEditingController();
  TextEditingController floorController=TextEditingController();
  TextEditingController kitchenSquareController=TextEditingController();
  TextEditingController builderTypeController=TextEditingController();
  TextEditingController yearController=TextEditingController();
  TextEditingController repairController=TextEditingController();
  TextEditingController flatHasThingsController=TextEditingController();
  TextEditingController contactController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: widget.onTapBack,
        ),
      ),
      body:  SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFiled(label: "Nomini yozing", hint: "nomi"),
              CustomTextFiled(label: "Narxini yozing", hint: "narxi"),
              CustomTextFiled(label: "Qo'shimcha ma'lumotlar", hint: "ma'lumot yozing"),
              CustomTextFiled(label: "Xonalar soni", hint: "soni"),
              CustomTextFiled(label: "Umumiy maydoni", hint: "maydon"),
              CustomTextFiled(label: "Qavatlar soni", hint: "qavatliligi"),
              CustomTextFiled(label: "Joylashgan qavati", hint: "qavati"),
              CustomTextFiled(label: "Oshxona maydoni", hint: "oshona maydoni"),
              CustomTextFiled(label: "Qurilish turi", hint: "qurilish turi"),
              CustomTextFiled(label: "Qurilish turi", hint: "qurilish turi"),
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
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/ShokhrukhDeveloper/uyjoy_admin.git
git push -u origin main