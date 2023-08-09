import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geoprofiler/util/profile_pop_up.dart';
import 'package:geoprofiler/views/dashboard_view_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';
import '../const/const.dart';
import '../style/fontstyle.dart';
import '../style/theme.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    
    DashboardViewModel viewModel =
        Provider.of<DashboardViewModel>(context, listen: false);
    viewModel.onPageLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DashboardViewModel viewModel = Provider.of<DashboardViewModel>(context);
    return Scaffold(
        backgroundColor: viewModel.screenColor,
        body: SafeArea(
            child: Padding(
                padding: leftRightPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: TextFormField(
                                controller: viewModel.latLongFieldController,
                                style: writingFontStyle(
                                    viewModel.fontSize, viewModel.fontColor),
                                decoration: InputDecoration(
                                    hintText: "Latitude, Longtitude",
                                    hintStyle: hintFontStyle,
                                    filled: true,
                                    fillColor: appColor, //
                                    enabledBorder: border,
                                    focusedBorder: border,
                                    disabledBorder: border,
                                    border: border))),
                        if ((viewModel.currentUserName ?? "").isNotEmpty) ...{
                          Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: InkWell(
                                  onTap: () {
                                    showProfilePopUp(context, (name, themecolor,
                                        fontcolor, fontSize) {
                                      viewModel.upateSettings(name ?? "",
                                          themecolor, fontcolor, fontSize);
                                    }, viewModel.currentUserName ?? "");
                                   
                                  },
                                  child: RandomAvatar(
                                      viewModel.currentUserName ?? "",
                                      height: 50,
                                      width: 50)))
                        }
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                viewModel.lookup(context);
                              },
                              style: btnStyle,
                              child: Text(
                                "Lookup",
                                style: writingFontStyle(
                                    viewModel.fontSize, viewModel.fontColor),
                              )),
                        ]),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Flexible(
                      child: FlutterMap(
                        mapController: viewModel.mapController,
                        options: MapOptions(
                          onMapEvent: (event) {
                            viewModel.updatePoint(null, context);
                          },
                          onTap: (tapposition, latlang) {
                            viewModel.pinLocation(tapposition, latlang);
                          },
                          initialCenter: const LatLng(28.7041, 77.1025),
                          initialZoom: 10,
                          cameraConstraint: CameraConstraint.contain(
                            bounds: LatLngBounds(
                              const LatLng(-90, -180),
                              const LatLng(90, 180),
                            ),
                          ),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                          MarkerLayer(
                            markers: [viewModel.current],
                          ),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
