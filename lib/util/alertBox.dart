import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:geoprofiler/const/const.dart';
import 'package:geoprofiler/style/theme.dart';
import 'package:geoprofiler/util/toast.dart';

import '../style/fontstyle.dart';

showAlertDialog(
    BuildContext context, Function(String?, String, String, double) onApply) {
  // set up the button
  String? name;
  Color thColor=themeColor;
  Color fontColor=Colors.white;
  double fontSize = 19.0;
  Widget okButton = ElevatedButton(
      onPressed: () {
        if ((name ?? "").isNotEmpty) {
          
          onApply(name, "${thColor.red},${thColor.green},${thColor.blue}", "${fontColor.red},${fontColor.green},${fontColor.blue}", fontSize);
          Navigator.of(context).pop();
        } else {
          showToast("Please enter name", context);
        }
      },
      style: btnStyle,
      child: Text(
        "Apply",
        style: writingFontStyle(19.0, Colors.white),
      ));

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    scrollable: true,
    backgroundColor: appColor,
    content: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                style: writingFontStyle(19.0, Colors.white),
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(
                    hintText: "Enter name",
                    hintStyle: hintFontStyle,
                    filled: true,
                    fillColor: appColor, //
                    enabledBorder: border,
                    focusedBorder: border,
                    disabledBorder: border,
                    border: border)),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "Select Theme Color:",
              style: captionWhite,
            ),
            const SizedBox(
              height: 10.0,
            ),
            BlockPicker(
              pickerColor: themeColor,
           
              onColorChanged: (Color color) {
                thColor = color;
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "Select Font Color:",
              style: captionWhite,
            ),
            const SizedBox(
              height: 10.0,
            ),
            BlockPicker(
              pickerColor: themeColor,
              onColorChanged: (Color color) {
                fontColor = color;
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "Select Font size:",
              style: captionWhite,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Slider(
              min: 0.0,
              max: 100.0,
              value: fontSize,
              thumbColor: Colors.black,
              activeColor: Colors.white,
              inactiveColor: Colors.white,
              onChanged: (value) {
                setState(
                  () {
                    fontSize = value;
                  },
                );
              },
            )
          ],
        );
      },
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
