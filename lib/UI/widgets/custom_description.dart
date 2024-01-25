import 'package:flutter/material.dart';
import 'package:uy_admin/UI/widgets/sized_config.dart';

class CustomDescriptionFiled extends StatelessWidget {
  const CustomDescriptionFiled({super.key, this.controller,required this.hint,required this.label, this.maxLength});
  final TextEditingController? controller ;
  final String hint;
  final String label;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      // height: 60,//SizeConfig().heightSize(context, 10),
      width: SizeConfig().widthSize(context, 40.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hint),
          const SizedBox(height: 5,),
          TextField(
            maxLength: maxLength,
            maxLines: 5,
            cursorColor: Colors.black,
            // style: TextStyle(color: Colors.),
            controller: controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: label,
              isDense: true,
              contentPadding: const EdgeInsets.only(
                  left: 5, bottom: 11, top: 11, right: 5),
            ),
          ),
        ],
      ),
    );

  }
}
