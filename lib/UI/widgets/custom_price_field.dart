import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uy_admin/UI/widgets/sized_config.dart';

class CustomPriceFiled extends StatefulWidget {
  CustomPriceFiled(
      {super.key,
      required this.onChangedType,
      this.controller,
      required this.hint,
      required this.label,
      this.maxLength,
      required this.priceType,
      required this.onChangedNegotiable,
      required this.negotiable,
      required this.negotiableText,
      this.formatter});
  final TextEditingController? controller;
  final String hint;
  final String label;
  final int? maxLength;
  bool priceType;
  final String negotiableText;
  final List<TextInputFormatter>? formatter;
  bool negotiable;
  final Function(bool? type) onChangedType;
  final Function(bool? type) onChangedNegotiable;

  @override
  State<CustomPriceFiled> createState() => _CustomPriceFiledState();
}

class _CustomPriceFiledState extends State<CustomPriceFiled> {
  List<String> options = ["so'm", "y.e"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      // height: 60,//SizeConfig().heightSize(context, 10),
      width: SizeConfig().widthSize(context, 40.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.hint),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: TextField(
                  inputFormatters: widget.formatter,
                  cursorColor: Colors.black,
                  maxLength: widget.maxLength,
                  controller: widget.controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: widget.label,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(
                        left: 5, bottom: 11, top: 11, right: 5),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 1,
                child: DropdownButton<bool>(
                  value: widget.priceType,
                  items: const [
                    DropdownMenuItem<bool>(
                      value: true,
                      child: Text("so'm"),
                    ),
                    DropdownMenuItem<bool>(
                      value: false,
                      child: Text("y. e."),
                    ),
                  ],
                  onChanged: (bool? newValue) {
                    setState(() {
                      widget.priceType = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.negotiableText),
              CupertinoSwitch(
                  value: widget.negotiable,
                  onChanged: (t) {
                    widget.onChangedNegotiable(t);
                    setState(() {
                      widget.negotiable = t;
                    });
                  })
            ],
          )
        ],
      ),
    );
  }
}
