//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  List<Datum>? data;

  Profile({
    this.data,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data ?? [].map((x) => x.toJson())),
      };
}

class Datum {
  String name;
  String geo;
  Settings settings;

  Datum({
    required this.name,
    required this.geo,
    required this.settings,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        geo: json["geo"],
        settings: Settings.fromJson(json["settings"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "geo": geo,
        "settings": settings.toJson(),
      };
}

class Settings {
  double fontsize;
  String themecolor;
  String fontColor;

  Settings({
    required this.fontsize,
    required this.themecolor,
    required this.fontColor
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        fontsize: json["fontsize"],
        themecolor: json["themecolor"],
        fontColor: json["fontColor"]
      );

  Map<String, dynamic> toJson() => {
        "fontsize": fontsize,
        "themecolor": themecolor,
        "fontColor":fontColor
      };
}
