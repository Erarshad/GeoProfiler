import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:geoprofiler/style/fontstyle.dart';
import 'package:random_avatar/random_avatar.dart';
import '../const/const.dart';
import '../style/theme.dart';
import '../views/profiles.dart';

showProfilePopUp(BuildContext context,
    Function(String?, String, String, double) onApply, String name) {
  // set up the button

  Color thColor = themeColor;
  Color fontColor = Colors.white;
  double fontSize = 19.0;
  Widget okButton = ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        onApply(name, "${thColor.red},${thColor.green},${thColor.blue}",
            "${fontColor.red},${fontColor.green},${fontColor.blue}", fontSize);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RandomAvatar(name, height: 50, width: 50),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              name,
              style: writingFontStyle(19.0, Colors.white),
            ),
            ListTile(
              leading: const Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
              ),
              title: Text(
                "All Profiles",
                style: writingFontStyle(19.0, Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Profiles(),
                ));
              },
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              "Update Theme Color:",
              style: captionWhite,
            ),
            const SizedBox(
              height: 5.0,
            ),
            BlockPicker(
              pickerColor: themeColor,
              onColorChanged: (Color color) {
                thColor = color;
              },
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              "Update Font Color:",
              style: captionWhite,
            ),
            const SizedBox(
              height: 5.0,
            ),
            BlockPicker(
              pickerColor: themeColor,
              onColorChanged: (Color color) {
                fontColor = color;
              },
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              "Update Font size:",
              style: captionWhite,
            ),
            const SizedBox(
              height: 5.0,
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
            ),
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
