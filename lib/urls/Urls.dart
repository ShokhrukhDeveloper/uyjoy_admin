class AppUrls{
  // static const baseUrl="http://liber.uz";
  static const baseUrl="https://localhost:7070";
  static const announce="$baseUrl/Announcement";
  static const announceUploadImage="$baseUrl/Announcement/UploadImage";
  static const announceDetail="$baseUrl/AnnounceDetail";
  static const announceDetailLayout="$announceDetail/Layout";
  static const announceDetailRepair="$announceDetail/Repair";
  static const announceDetailNearby="$announceDetail/Nearby";
  static const announceDetailApartementHas="$announceDetail/ApartementHas";
  static const announceDetailTypeOfBuilding="$announceDetail/TypeOfBuilding";
  static const _announceSearch="$announce/search?";
  static  String announceSearch(String text,[int limit=10,int page=1])=>
      "${_announceSearch}text=$text&Limit=$limit&Page=$page";
}
