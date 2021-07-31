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

  saveUser(LoginData loginData) {
    saveSetting('user_id', loginData.uniqueId!);
    saveSetting('fullName', loginData.fullName!);
    saveSetting('user_name', loginData.username!);
    saveSetting('id', loginData.id!);
    saveSetting('dateCreated', loginData.dateCreated!);
    saveSetting('email', loginData.email!);
    saveSetting('phone', loginData.phone!);
    savePassword(loginData);
    saveActiveStatus(loginData);
    setAddress(loginData);
    saveCountry(loginData);
    saveCurrency(loginData);
    saveGender(loginData);
    saveProfilePic(loginData);
  }

  Future<bool>? savePassword(LoginData loginData) =>
      saveSetting('password', loginData.password!);

  Future<bool>? saveActiveStatus(LoginData loginData) =>
      saveSetting('activeStatus', loginData.activeStatus!);

   Future<bool>? saveProfilePic(LoginData loginData) =>
      saveSetting('profilePic', loginData.profilePic!);

  Future<bool>? saveGender(LoginData loginData) =>
      saveSetting('gender', loginData.gender!);

  Future<bool>? saveCurrency(LoginData loginData) =>
      saveSetting('currency', loginData.currency!);

  Future<bool>? saveCountry(LoginData loginData) =>
      saveSetting('country', loginData.country!);

  Future<bool>? setAddress(LoginData loginData) =>
      saveSetting('address', loginData.address!);

  // static Future<LoginData> get user async => LoginData(
  //       username: userName,
  //       uniqueId: userId,
  //       fullName: userFullName,
  //       email: email,
  //       country: country,
  //       password: password,
  //       phone: phone,
  //       activeStatus: activeStatus,
  //       address: address,
  //       currency: currency,
  //       dateCreated: dateCreated,
  //       gender: gender,
  //     );

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

// static String? id;
}
