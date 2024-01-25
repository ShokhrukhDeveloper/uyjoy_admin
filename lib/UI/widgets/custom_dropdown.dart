import 'package:flutter/material.dart';

import 'package:uy_admin/UI/widgets/sized_config.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown(
      {super.key, this.controller, required this.hint, required this.options, });
  final TextEditingController? controller;
  final String hint;
  final List<String> options;
  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

String?  selectedOption;
  @override  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 20),
      // height: 60,//SizeConfig().heightSize(context, 10),
      width: SizeConfig().widthSize(context, 40.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.hint),
          const SizedBox(height: 5,),
          DropdownButton<String>(
            isDense: true,
            isExpanded: true,
            value:selectedOption?? widget.options.first,
            items: widget.options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedOption = newValue!;
              });
            },
          ),
          SizedBox(height: 20),
          // Text('Selected Option: $selectedOption'),

        ],
      ),
    );
  }
}
