import 'package:get_storage/get_storage.dart';
class LocalStorage{
  static final _box = GetStorage();
  static String? _accessToken;
  static  set  accessToken(String? token){
    _accessToken=token;
    _box.write("key",token);
  }
  static  String? get accessToken{
    if(_accessToken==null)
    {
     return  _accessToken=_box.read("key");
    }
    return _accessToken;
  }
}