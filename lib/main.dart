import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:themoviedb/ui/screens/app/my_app.dart';

void main()  {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}
