import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:themoviedb/ui/widgets/app/my_app.dart';

void main()  {
  //TODO
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}
