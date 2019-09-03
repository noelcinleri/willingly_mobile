import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:willingly/app/app.dart';
import 'package:willingly/app/utils/colors.dart';

import 'app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryDark
  ));
  runApp(App());
}
