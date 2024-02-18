import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uy_admin/models/announces.dart';
import 'package:uy_admin/urls/Urls.dart';

import '../product/product_page.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.announcement});
  final AnnouncementItem announcement;
  static final numberFormat =
      NumberFormat.compactSimpleCurrency(locale: 'uz_UZB');
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ProductPage(
                      id: announcement.id,
                    )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: NetworkImage(
                      "${AppUrls.baseImageUrl}/${announcement.photo}"),
                  fit: BoxFit.cover,
                )),
          ),
          Text(
            announcement.title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Text(
            numberFormat.format(announcement.price),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 4),
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
                decoration: BoxDecoration(
                    color: const Color(0xffEFEFEF),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(announcement.repair ?? ""),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
              //   decoration: BoxDecoration(
              //       color: const Color(0xffEFEFEF),
              //       borderRadius: BorderRadius.circular(8)),
              //   child: Text("${announcement} m\u00b2"),
              // ),
            ],
          ),
          Text(announcement.flatHasThings ?? ""),
        ],
      ),
    );
  }
}
