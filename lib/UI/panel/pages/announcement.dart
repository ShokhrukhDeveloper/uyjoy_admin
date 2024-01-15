import 'package:flutter/material.dart';
import 'package:uy_admin/UI/panel/pages/product_item.dart';
class AnnouncementWidget extends StatefulWidget {
  const AnnouncementWidget({super.key});

  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: GridView.builder(
        itemCount: 19,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio:156/300,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10

          ),
          itemBuilder: (context,index)=>const ProductItemWidget()),
    );
  }
}
