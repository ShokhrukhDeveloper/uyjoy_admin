class AppUrls{
  static const baseUrl="http://liber.uz";
  static const announce="$baseUrl/Announcement";
  static const _announceSearch="$announce/search?";
  static  String announceSearch(String text,[int limit=10,int page=1])=>
      "${_announceSearch}text=$text&Limit=$limit&Page=$page";
}
