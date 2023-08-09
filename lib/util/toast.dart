import 'package:flutter/material.dart';
import 'package:geoprofiler/style/fontstyle.dart';
import 'package:motion_toast/motion_toast.dart';


showToast(String msg,BuildContext context){
  
    MotionToast.warning(
      title: Text("Alert",style: alert,),
      description:  Text(msg,style: alertText,)
    ).show(context);

}