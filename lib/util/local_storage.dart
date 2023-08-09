import 'dart:convert';

import 'package:geoprofiler/const/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile_data_model.dart';

class Storage {
  Future<bool> addToProfile(Datum data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? json = await getProfiles();
    
    Profile? profile;
    if (json != null) {
      profile = profileFromJson(json);
    } else {
      profile = profileFromJson(jsonEncode(Profile()));
    }
    profile.data?.add(data);
 
    await pref.setString(PROFILES, jsonEncode(profile));
    return true;
  }

  Future<String?> getProfiles() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? data = pref.getString(PROFILES);
    return data;
  }

  Future<Datum?> lookUpProfiles(String latlang) async {
    String? json = await getProfiles();
    if (json == null) {
      return null;
    }
    final profile = profileFromJson(json);
    List<Datum> data = profile.data ?? [];
    for (Datum e in data) {
      if (e.geo == latlang) {
        return e;
      }
    }

    return null;
  }

  void setSelectedProfile(String json) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(SELECTEDPROFILES, json);
  }

  Future<String?> getSelectedProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(SELECTEDPROFILES);
  }
}
