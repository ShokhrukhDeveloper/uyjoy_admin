import 'package:flutter/material.dart';
import 'package:uy_admin/UI/widgets/sized_config.dart';

import '../../models/announce_details.dart';
class CheckboxGrid extends StatefulWidget {
  const CheckboxGrid({super.key, required this.hint, required this.items});
  final String hint;
  final List<AnnounceDetail> items;
  @override
  State<CheckboxGrid> createState() => _CheckboxGridState();
}

class _CheckboxGridState extends State<CheckboxGrid> {



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
                    value: widget.items[i].isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        widget.items[i].isSelected = value!;
                      });
                    },
                  ),
                  Text(
                    widget.items[i].uz,
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
