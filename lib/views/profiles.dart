import 'package:flutter/material.dart';
import 'package:geoprofiler/const/const.dart';
import 'package:geoprofiler/style/fontstyle.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

import 'dashboard_view_model.dart';

class Profiles extends StatefulWidget {
  const Profiles({super.key});

  @override
  State<Profiles> createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  @override
  void initState() {
    DashboardViewModel viewModel =
        Provider.of<DashboardViewModel>(context, listen: false);
    viewModel.onProfileLoad();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      DashboardViewModel viewModel = Provider.of<DashboardViewModel>(context);
    return Scaffold(
      backgroundColor: viewModel.screenColor,
      body: SafeArea(child: 
      Padding(
        padding: leftRightPadding,
        
        child: 
      
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        
        children: [

           Text("All Profiles",style:writingFontStyle(19.0, Colors.white)),

           const SizedBox(height: 10.0,),     

      Expanded(child: 
      ListView.builder(
        itemCount: viewModel.profileData.length,
        itemBuilder:(context, index) {
          return ListTile(
            trailing: RandomAvatar(
                                      viewModel.profileData[index].name,
                                      height: 50,
                                      width: 50),

            title: Text(viewModel.profileData[index].name,style: writingFontStyle(19.0, Colors.white),),
            subtitle: Text(viewModel.profileData[index].geo,style:captionWhite ,),
          );
        
      },)

      
      
      
      
      )

      ],))
      
      
      
      )

    );

  }
}