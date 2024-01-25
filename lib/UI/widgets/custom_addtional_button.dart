import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uy_admin/UI/widgets/sized_config.dart';

class CustomAdditonalButton extends StatefulWidget {
  CustomAdditonalButton({super.key, required this.textValue1, required this.textValue2, required this.value, required this.onChanged, required this.text});
  final String textValue1;
  final String textValue2;
  final String text;
  bool value;
  final Function(bool value) onChanged;
  @override
  State<CustomAdditonalButton> createState() => _CustomAdditonalButtonState();
}

class _CustomAdditonalButtonState extends State<CustomAdditonalButton> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig().widthSize(context, 40.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.text),
          const SizedBox(height: 5,),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: InkWell(
                  onTap:()=>
                      setState(() {
                        widget.value=true;
                        widget.onChanged(true);
                      }),
                  child: Container(
                      margin: const EdgeInsets.only(right: 10),
                    height: 40,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: widget.value? Colors.green:Colors.grey[200]
                    ),
                  child: Center(child: Text(widget.textValue1,style:  TextStyle(color: widget.value?Colors.white:Colors.black),)),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: InkWell(
                  onTap:()=>
                      setState(() {
                        widget.value=false;
                   widget.onChanged(false);
                  }),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: widget.value?Colors.grey[200]:Colors.green
                    ),
                    child: Center(child: Text(widget.textValue2,style: TextStyle(color: widget.value?Colors.black:Colors.white),)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
