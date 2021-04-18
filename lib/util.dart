import 'package:flutter/material.dart';

enum TodoCardSettings {
  edit,
  delete,
}

enum AddmodalStatus {
  add_todo,
  add_task,
}

class CustomColors {
  static const Color PurpleLight = Color.fromRGBO(248, 87, 195, 1);
  static const Color PurpleDark = Color.fromRGBO(224, 19, 156, 1);
  static const Color PurpleShadow = Color.fromRGBO(209, 2, 99, 0.27);

  static const Color HeaderBlueLight = Color.fromRGBO(129, 199, 245, 1);
  static const Color HeaderBlueDark = Color.fromRGBO(56, 103, 213, 1);
  static const Color HeaderGreyLight = Color.fromRGBO(225, 255, 255, 0.31);

  static const Color TextHeader = Color.fromRGBO(85, 78, 143, 1);
  static const Color TextHeaderGrey = Color.fromRGBO(104, 104, 104, 1);
  static const Color TextSubHeaderGrey = Color.fromRGBO(161, 161, 161, 1);
  static const Color TextSubHeader = Color.fromRGBO(139, 135, 179, 1);
  static const Color TextBody = Color.fromRGBO(130, 160, 183, 1);
  static const Color TextGrey = Color.fromRGBO(198, 198, 200, 1);
  static const Color TextWhite = Color.fromRGBO(243, 243, 243, 1);
  static const Color HeaderCircle = Color.fromRGBO(255, 255, 255, 0.17);
}
