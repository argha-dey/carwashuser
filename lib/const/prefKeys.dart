import 'package:hive/hive.dart';

class PrefKeys {
  static const String USERDATA = 'userdata';
  static const String TOKEN = 'token';
  static const String ADDID = 'AddId';
  static const String ADDRESS = 'Address';
  static const String CARTLIST = 'cartlist';
  static const String LANG = 'language';
  static const String USERID = 'userid_user';
  static const String USER_APP_DEVICE_TOKEN = 'user_app_device_token';
}

class PrefObj {
  static Box? preferences;
}
