class AnnounceDetail{

  final int id;
  final String uz;
  final String ru;
  bool isSelected=false;

  AnnounceDetail(
  {required this.id,
  required this.uz,
  required this.ru,

  });
  factory AnnounceDetail.fromJson(dynamic json) {
  return AnnounceDetail(
  id: json["id"],
  uz: json["uz"],
  ru: json["ru"],
 );
  }

}