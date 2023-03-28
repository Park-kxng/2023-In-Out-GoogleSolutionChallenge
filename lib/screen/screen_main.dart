import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/screen/screen_mypage.dart';
import 'package:largo/widget/bottom_bar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../views/walkingSettingView.dart';


class ScreenMain extends StatefulWidget{
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<ScreenMain>{
  Future<void> requestLocationPermission() async {

    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted;

    //bool isLocation = serviceStatusLocation == ServiceStatus.enabled;

    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  Future<void> requestCameraPermission() async {

    final serviceStatusCamera = await Permission.camera.isGranted;


    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.group)),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings))
  ];
  late TabController controller;
  @override
  Widget build(BuildContext context){
    requestLocationPermission();
    requestCameraPermission();
    
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: items),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return ScreenHome();
            case 1:
              return WalkingSettingView();
            case 2:
              return ScreenMypage();
            default:
              return ScreenHome();
          }
        });
  }

}