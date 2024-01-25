import 'package:flutter/material.dart';
import 'package:uy_admin/UI/widgets/sized_config.dart';
class CheckboxGrid extends StatefulWidget {
  const CheckboxGrid({super.key, required this.hint, required this.items});
  final String hint;
  final List<String> items;
  @override
  State<CheckboxGrid> createState() => _CheckboxGridState();
}

class _CheckboxGridState extends State<CheckboxGrid> {


  List<bool> selectedItems = List.generate(10, (index) => false);
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: SizeConfig().widthSize(context, 40.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15,),
          Text(widget.hint),
          const SizedBox(height: 5,),
          ListView.builder(
            itemCount: widget.items.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c,i)=>InkWell(
              onTap: () {
                setState(() {

                });
              },
              child: Row(

                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: selectedItems[i],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedItems[i] = value!;
                      });
                    },
                  ),
                  Text(
                    widget.items[i],
                    style: TextStyle(fontSize: 16.0),
                  ),

                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
