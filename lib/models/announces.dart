class AnnouncementItem {
  final int id;
  final int price;
  final String? photo;
  final String title;
  final int roomQuantity;
  final String? flatHasThings;
  final bool maklerPrice;
  final String? repair;
  AnnouncementItem(
      {required this.id,
      required this.price,
      required this.photo,
      required this.title,
      required this.roomQuantity,
      required this.flatHasThings,
      required this.maklerPrice,
      required this.repair});
  factory AnnouncementItem.fromJson(dynamic json) {
    return AnnouncementItem(
        id: json["id"],
        price: json["price"],
        photo: json["photo"],
        title: json["title"],
        roomQuantity: json["roomQuantity"],
        flatHasThings: json["flatHasThings"],
        maklerPrice: json["maklerPrice"],
        repair: json["repair"]);
  }
}
