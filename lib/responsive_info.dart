import 'package:flutter/material.dart';

class ResponsiveInfoRepo {
  //This class would be in charge of the responsive status of the app

  final Size _size;

  ResponsiveInfoRepo(BuildContext context)
      : _size = MediaQuery.of(context).size;

  DeviceScreenType get deviceType {
    //Return the device info
    //Tablet is not supported yet

    if (_size.width > 950) return DeviceScreenType.desktop;
    return DeviceScreenType.mobile;
  }

  bool get isMobile => deviceType == DeviceScreenType.mobile;
}

enum DeviceScreenType { mobile, desktop }
