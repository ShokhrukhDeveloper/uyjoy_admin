import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uy_admin/UI/widgets/sized_config.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled(
      {super.key, this.controller, required this.hint, required this.label, this.maxLength, this.formatter, this.suffixText});
  final TextEditingController? controller;
  final String hint;
  final String? suffixText;
  final String label;
  final int? maxLength;
  final List<TextInputFormatter>? formatter;


  @override  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 20),
      // height: 60,//SizeConfig().heightSize(context, 10),
      width: SizeConfig().widthSize(context, 40.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hint),
          const SizedBox(height: 5,),
          TextField(
            cursorColor: Colors.black,
            maxLength: maxLength,
            inputFormatters: formatter,
            controller: controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              suffixText:suffixText,
              border: const OutlineInputBorder(),
              hintText: label,
              isDense: true,
              contentPadding:
                  const EdgeInsets.only(left: 5, bottom: 11, top: 11, right: 5),
            ),
          ),
        ],
      ),
    );
  }
}
