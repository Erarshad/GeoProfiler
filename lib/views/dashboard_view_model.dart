import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geoprofiler/model/profile_data_model.dart';
import 'package:geoprofiler/style/theme.dart';
import 'package:geoprofiler/util/alertBox.dart';
import 'package:geoprofiler/util/toast.dart';
import 'package:latlong2/latlong.dart';
import '../util/local_storage.dart';

class DashboardViewModel extends ChangeNotifier {
  TextEditingController latLongFieldController = TextEditingController();

  final pointY = 200.0;

  LatLng? latLng;
  double _getPointX(BuildContext context) {
    return MediaQuery.of(context).size.width / 2;
  }

  onPageLoad() async {
    Storage storage = Storage();
    String? json = await storage.getSelectedProfile() ?? "";
    if (json.isNotEmpty) {
      Datum data = Datum.fromJson(jsonDecode(json));

      upateSettings(data.name, data.settings.themecolor,
          data.settings.fontColor, data.settings.fontsize);
    }
  }

  onProfileLoad() {
    fetchAllProfiles();
  }

  double fontSize = 19.0;
  Color fontColor = Colors.white;
  Color screenColor = themeColor;
  String? currentUserName;

  MapController mapController = MapController();
  double? latitude;
  double? longtitude;
  bool isFirstTime = true;
  void updatePoint(MapEvent? event, BuildContext context) {
    final pointX = _getPointX(context);

    latLng = mapController.camera.pointToLatLng(Point(pointX, pointY));
    if (isFirstTime) {
      latLongFieldController.text =
          "${latLng?.latitude.toString()},${latLng?.longitude.toString()}";
      isFirstTime = false;
    }

    notifyListeners();
  }

  Marker current = Marker(
    point: const LatLng(28.7041, 77.1025),
    builder: (ctx) => const Icon(
      Icons.location_on,
      color: appColor,
      size: 35.0,
    ),
  );

  void pinLocation(TapPosition tapPosition, LatLng latLng) {
    latLongFieldController.text =
        "${latLng.latitude.toString()},${latLng.longitude.toString()}";
    current = Marker(
      width: 100.0,
      height: 100.0,
      point: latLng,
      builder: (ctx) => const Icon(
        Icons.location_on,
        color: appColor,
        size: 35.0,
      ),
    );

    notifyListeners();
  }

  void lookup(BuildContext context) async {
    if (latLongFieldController.text.isNotEmpty) {
      if (latLongFieldController.text.contains(",")) {
        List<String> geo = latLongFieldController.text.split(",");
        if (geo.length < 2) {
          showToast("Kindly enter both latitude,longtitude.", context);
        } else {
          double latitude = double.parse(geo[0].trim());
          double longtitude = double.parse(geo[1].trim());
          if (latitude <= -90.0 || latitude >= 90) {
            showToast("Please enter valid latitude", context);
          } else if (longtitude <= -180.0 || longtitude >= 180.0) {
            showToast("Please enter valid longtitude", context);
          } else {
            // here i will check
            /**
             * weither the profile exist or not 
             * if not then will prompt to take one 
             */
            //once this get happen then we have to handle if any profile does not exist then
            mapController.move(LatLng(latitude, longtitude), 10);
            Storage storage = Storage();
            Datum? data =
                await storage.lookUpProfiles(latLongFieldController.text);

            if (data == null) {
              // ignore: use_build_context_synchronously
              showAlertDialog(
                context,
                (name, themecolor, fontcolor, fontSize) async {
                  Datum data = Datum(
                      name: name ?? "",
                      geo: latLongFieldController.text,
                      settings: Settings(
                          fontsize: fontSize,
                          themecolor: themecolor,
                          fontColor: fontcolor));
                  bool res = await storage.addToProfile(data);
                  if (res) {
                    upateSettings(name ?? "", themecolor, fontcolor, fontSize);
                    storage.setSelectedProfile(jsonEncode(data));
                  }
                },
              );
            } else {
              upateSettings(data.name, data.settings.themecolor,
                  data.settings.fontColor, data.settings.fontsize);
              storage.setSelectedProfile(jsonEncode(data));
            }
          }
        }
      } else {
        showToast(
            "Kindly enter in proper format, i.e latitude,longtitude.", context);
      }
    } else {
      showToast("Kindly enter the latitude and longtitude.", context);
    }
  }

  void upateSettings(
      String name, String themeColor, String fontColor, double fontSize) {
    screenColor = stringToColor(themeColor);
    this.fontColor = stringToColor(fontColor);
    this.fontSize = fontSize;
    currentUserName = name;
    notifyListeners();
  }

  Color stringToColor(String value) {
    // Hash the input string to generate a unique color

    List data = value.split(",");
    return Color.fromARGB(
        255, int.parse(data[0]), int.parse(data[1]), int.parse(data[2]));
  }

  List<Datum> profileData = [];
  bool isBusy = false;
  setBusy(bool val) {
    isBusy = val;
    notifyListeners();
  }

  void fetchAllProfiles() async {
    Storage storage = Storage();
    String json = await storage.getProfiles() ?? "";
    Profile profile = profileFromJson(json);
    profileData = profile.data ?? [];
    print(jsonEncode(profileData));
    notifyListeners();
  }
}
