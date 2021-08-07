import 'package:equal_cash/models/api/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static final instance = Settings._privateConstructor();
  Future<SharedPreferences>? prefs;

  Settings._privateConstructor() {
    if (prefs == null) {
      prefs = SharedPreferences.getInstance();
    }
    // int counter = (prefs.getInt('counter') ?? 0) + 1;
    // print(saved ? 'id ${Settings.id} was saved' : "Id not saved");
  }

  saveSetting(String id, String data) =>
      prefs?.then((value) => value.setString(id, data));

  Future<String?>? getSetting(String id) =>
      prefs?.then((value) => value.getString(id));

  saveUser(LoginData loginData) async {
    saveSetting('user_id', loginData.uniqueId ?? await userId ?? "");
    saveSetting('fullName', loginData.fullName ?? await userFullName ?? "");
    saveSetting('user_name', loginData.username ?? await userName ?? "");
    saveSetting('id', loginData.id ?? await userId ?? "");
    saveSetting('email', loginData.email ?? await email ?? "");
    saveSetting('phone', loginData.phone ?? await phone ?? "");
    await saveDateCreated(loginData.dateCreated);
    await savePassword(loginData.password);
    await saveActiveStatus(loginData.activeStatus);
    await saveAddress(loginData.address);
    await saveCountry(loginData.country);
    await saveCurrency(loginData.currency);
    await saveGender(loginData.gender);
    await saveProfilePic(loginData.profilePic);
  }

  Future<dynamic> saveDateCreated(String? loginData) async {
    return saveSetting(
      'dateCreated', loginData ?? await dateCreated ?? "");
  }

  Future<bool>? savePassword(String? loginData) async =>
      await saveSetting('password', loginData ?? await password ?? "");

  Future<bool>? saveActiveStatus(String? loginData) async =>
      await saveSetting('activeStatus', loginData ?? await activeStatus ?? "");

  Future<bool>? saveProfilePic(String? loginData) async =>
      await saveSetting('profilePic', loginData ?? await profilePic ?? "");

  Future<bool> saveGender(String? loginData) async =>
      await saveSetting('gender', loginData ?? await gender ?? "");

  Future<bool>? saveCurrency(String? loginData) async =>
      await saveSetting('currency', loginData ?? await currency ?? "");

  Future<bool>? saveCountry(String? loginData) async =>
      await saveSetting('country', loginData ?? await country ?? "");

  Future<bool>? saveAddress(String? loginData) async =>
      await saveSetting('address', loginData ?? await address ?? "");

  Future<LoginData> get user async => LoginData(
        username: await userName,
        uniqueId: await userId,
        id: await userId,
        fullName: await userFullName,
        email: await email,
        country: await country,
        password: await password,
        phone: await phone,
        activeStatus: await activeStatus,
        address: await address,
        currency: await currency,
        dateCreated: await dateCreated,
        gender: await gender,
      );

  Future<String?>? get userId => getSetting("user_id");

  Future<String?>? get userFullName => getSetting("fullName");

  Future<String?>? get userName => getSetting("user_name");

  Future<String?>? get email => getSetting("email");

  Future<String?>? get country => getSetting("country");

  Future<String?>? get password => getSetting("password");

  Future<String?>? get phone => getSetting("phone");

  Future<String?>? get activeStatus => getSetting("activeStatus");

  Future<String?>? get address => getSetting("address");

  Future<String?>? get currency => getSetting("currency");

  Future<String?>? get dateCreated => getSetting("dateCreated");

  Future<String?>? get gender => getSetting("gender");

  Future<String?>? get profilePic => getSetting("profilePic");
}
