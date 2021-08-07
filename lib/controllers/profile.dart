import 'dart:io';

import 'package:equal_cash/api/repository.dart';
import 'package:equal_cash/models/api/profile.dart';
import 'package:equal_cash/models/api/profile_pic.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var profilePic = ProfilePicResponse().obs;
  var uploadResponse = ProfileResponseBean().obs;

  ProfileController({String? userId}) {
    if (userId != null) {
      getProfilePic(userId);
    }
  }

  getProfilePic(String userId) async {
    var pic = await ApiRepository().getUserProfilePic(userId);
    if (pic != null) {
      profilePic.value = pic;
      update();
    } else {
      profilePic.value = ProfilePicResponse(
          response: ProfilePicResponseBean(
              status: 0,
              message: "",
              data: ProfilePicDataBean(profilePic: "")));
    }
    print(pic?.response?.data?.toJson() ?? "No DATA RESPONSE");
  }

  Future<ProfileResponseBean> updateProfile(gender, userId, address) async {
    var profile = await ApiRepository().updateProfile(gender, userId, address);
    // await ApiRepository().updateProfile(gender, userId, address, imagePath);
    if (profile != null) {
      var response = profile.response;
      if (response != null) {
        uploadResponse.value = response;
        getProfilePic(userId);
      } else {
        uploadResponse.value = ProfileResponseBean(status: 0, message: "");
      }
    } else {
      uploadResponse.value = ProfileResponseBean(status: 0, message: "");
    }
    return uploadResponse.value;
  }
}
