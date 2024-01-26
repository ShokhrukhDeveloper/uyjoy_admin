import 'package:flutter/material.dart';

import 'package:uy_admin/UI/widgets/sized_config.dart';
import 'package:uy_admin/models/announce_details.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown(
      {super.key, this.controller, required this.hint, required this.options, required this.onChanged, });
  final TextEditingController? controller;
  final String hint;
  final List<AnnounceDetail> options;
  final Function(AnnounceDetail announceDetail) onChanged;
  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  AnnounceDetail?  selectedOption;
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
          DropdownButton<AnnounceDetail>(
            isDense: true,
            isExpanded: true,
            value:selectedOption?? widget.options.first,
            items: widget.options.map<DropdownMenuItem<AnnounceDetail>>((AnnounceDetail option) {
              return DropdownMenuItem<AnnounceDetail>(
                value: option,
                child: Text(option.uz),
              );
            }).toList(),
            onChanged: (AnnounceDetail? newValue) {
              setState(() {

                if(newValue!=null){
                  widget.onChanged(newValue);
                  selectedOption=newValue;
                }
              });
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
