import 'package:flutter/material.dart';
import 'package:uy_admin/UI/widgets/sized_config.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({super.key, this.controller,required this.hint,required this.label});
  final TextEditingController? controller ;
  final String hint;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
       // height: 60,//SizeConfig().heightSize(context, 10),
        width: SizeConfig().widthSize(context, 40.5),
    child: TextField(
    cursorColor: Colors.black,
    // style: TextStyle(color: Colors.),
    controller: controller,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
    border: const OutlineInputBorder(),
    labelText: label,
    hintText: hint,
    isDense: true,
    contentPadding: const EdgeInsets.only(
    left: 5, bottom: 11, top: 11, right: 5),
    ),
    ),
    );
    //   Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     LimitedBox(
    //
    //       child: TextField(
    //         controller: bookNameController,
    //         decoration: InputDecoration(
    //           labelText: label,
    //           hintText: hint,
    //         ),
    //       ),
    //     ),
    //     const SizedBox(height: 20),
    //
    //   ],
    // );
  }
}
