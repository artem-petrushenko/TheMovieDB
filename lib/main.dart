import 'dart:async';

import 'package:flutter/material.dart';

import 'package:themoviedb/src/app.dart';

import 'package:themoviedb/src/common/widget/navigation/navigation.dart';

Future<void> main() async => runZonedGuarded(
      () async {
        runApp(App(navigation: Navigation()));
      },
      (error, stackTrace) => Error.throwWithStackTrace(error, stackTrace),
    );
