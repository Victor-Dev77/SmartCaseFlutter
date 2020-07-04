import 'package:smartcaseflutter/models/user.dart';
import 'package:smartcaseflutter/utils/constant_color.dart';
import 'package:flutter/material.dart';

class Constant {
  // VARIABLE
  static User currentUser;

  // IMAGE
  static final String pathLogoImage = "assets/smartcase.png";

  // ICONS
  static final Icon homeIcon = Icon(
    Icons.home,
    size: 30,
    color: ConstantColor.white,
  );

  static final Icon mapIcon = Icon(
    Icons.map,
    size: 30,
    color: ConstantColor.white,
  );

  static final Icon addEventIcon = Icon(
    Icons.add,
    size: 30,
    color: ConstantColor.white,
  );

  static final Icon settingsIcon = Icon(
    Icons.settings,
    size: 30,
    color: ConstantColor.white,
  );

}
