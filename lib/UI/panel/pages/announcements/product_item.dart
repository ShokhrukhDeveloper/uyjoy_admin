import 'package:flutter/material.dart';
import 'package:uy_admin/models/announces.dart';
import 'package:uy_admin/urls/Urls.dart';
class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.announcement});
  final AnnouncementItem announcement;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child:  Image(
                image: NetworkImage("${AppUrls.baseUrl}/files/${announcement.photo}"),
                fit: BoxFit.cover,
              )),
        ),
         Text(announcement.title,
          style: const TextStyle(fontWeight:FontWeight.w500,
              fontSize: 18
          ),
        ),
         Text(announcement.price.toStringAsFixed(2),
          style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 2),
              decoration: BoxDecoration(
                  color: const Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(8)
              ),
              child:  Text(announcement.repair??""),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 2),
              decoration: BoxDecoration(
                  color: const Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(8)

              ),
              child: Text("10/10"),
            ),
          ],
        ),
        Text(announcement.flatHasThings??""),

      ],
    );
  }
}