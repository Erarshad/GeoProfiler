import 'package:flutter/material.dart';
import 'package:geoprofiler/style/theme.dart';

const appName = "geoprofiler";
const fontFamily = "Roboto";
const PROFILES = "profiles";
const SELECTEDPROFILES = "selectedprofiles";
EdgeInsets leftRightPadding =
    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0);
InputBorder border = const OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(0.0),
  ),
  borderSide: BorderSide(
    color: Colors.white,
    width: 1.0,
  ),
);

ButtonStyle btnStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(appColor),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: Colors.white))));
