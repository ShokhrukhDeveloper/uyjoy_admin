import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uy_admin/UI/widgets/sized_config.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key, required this.onChanged});
  final Function(DateTime dateTime) onChanged;
  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  var year=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig().widthSize(context, 40.5),
      child: Row(
        children: [
          const Text("Qurilgan yili: "),
          TextButton(
            onPressed: ()async{

             await showDialog(context: context, builder: (context)=>AlertDialog(
                title: const Text("Yilni tanlang"),
                content: SizedBox(
                  width: 300,
                  height: 500,
                  child: YearPicker(
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    selectedDate: year,
                    onChanged: (DateTime value) {
                      year=value;
                      Navigator.pop(context);
                    },

                  ),
                ),
              ));
           setState(() {

           });
           widget.onChanged(year);
              },
            child: Text("${year.year}-yil"),
          ),
        ],
      )
    );
  }
}
