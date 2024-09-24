import 'package:e_tmsc_app/shared/enums/role_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._();

  static final _instance = SharedPrefs._();

  factory SharedPrefs() => _instance;
  late final SharedPreferences _prefs;

  final codeKey = 'code';
  final accessTokenKey = 'access_token';
  final refreshTokenKey = 'refresh_token';
  final expiresInKey = 'expires_in';
  final idKey = 'id';
  final fcmKey = 'fcm';
  final fcmUpdateKey = 'fcm_update';
  final roleKey = 'role_id';

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //TOKEN
  //get token into local storage
  String? get accessToken => _prefs.getString(accessTokenKey);
  String? get refreshToken => _prefs.getString(refreshTokenKey);
  int? get timeExpired => _prefs.getInt(expiresInKey);
  String? get fcm => _prefs.getString(fcmKey);
  bool? get fcmStatus => _prefs.getBool(fcmUpdateKey);

  //insert token into local storage
  Future insertToken(String token) async {
    await _prefs.setString(accessTokenKey, token);
  }

  //delete token from local storage
  Future deleteToken() async {
    if (accessToken != null) {
      await _prefs.remove(accessTokenKey);
    }
  }

  //insert refresh token into local storage
  Future insertRefreshToken(String token) async {
    await _prefs.setString(refreshTokenKey, token);
  }

  //delete refresh token from local storage
  Future deleteRefreshToken() async {
    if (refreshToken != null) {
      await _prefs.remove(refreshTokenKey);
    }
  }

  //insert time expired into local storage
  Future insertExpired(int time) async {
    await _prefs.setInt(expiresInKey, time);
  }

  //delete time expired from local storage
  Future deleteExpired() async {
    if (timeExpired != null) {
      await _prefs.remove(expiresInKey);
    }
  }

  //ID
  //get id into local storage
  int? get id => _prefs.getInt(idKey);

  //insert id into local storage
  Future insertId(int id) async {
    await _prefs.setInt(idKey, id);
  }

  //delete id from local storage
  Future deleteId() async {
    if (id != null) {
      await _prefs.remove(idKey);
    }
  }

  //ROLE
  //get role into local storage
  RoleEnum get role => RoleEnum.parseEnum(_prefs.getInt(roleKey));

  //insert role into local storage
  Future insertRole(int role) async {
    await _prefs.setInt(roleKey, role);
  }

  //delete role from local storage
  Future deleteRole() async {
    if (id != null) {
      await _prefs.remove(roleKey);
    }
  }

  //FCM
  //insert fcm into local storage
  Future setFCM(String fcm) async {
    await _prefs.setString(fcmKey, fcm);
  }

  //delete fcm from local storage
  Future deleteFCM() async {
    if (id != null) {
      await _prefs.remove(fcmKey);
    }
  }

  //insert update fcm
  Future setUpdateFCM(bool update) async {
    await _prefs.setBool(fcmUpdateKey, update);
  }

  //delete update fcm from local storage
  Future deleteUpdateFCM() async {
    if (id != null) {
      await _prefs.remove(fcmUpdateKey);
    }
  }

  //delete all
  Future logout() async {
    await deleteToken();
    await deleteId();
    await deleteRefreshToken();
    await deleteExpired();
    await deleteFCM();
    await deleteUpdateFCM();
    await deleteRole();
  }
}
