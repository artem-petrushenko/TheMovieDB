import 'package:flutter/material.dart';

import 'package:themoviedb/theme/app_colors.dart';

final ThemeData themeData = ThemeData(
  fontFamily: 'Roboto',
  backgroundColor: AppColors.kBackgroundColor,
  scaffoldBackgroundColor: AppColors.kBackgroundColor,
  appBarTheme: appBarTheme,
  bottomNavigationBarTheme: appBottomNavigationBarTheme,
  textTheme: appTextTheme,
  textSelectionTheme: appTextSelectionThemeData,
  inputDecorationTheme: appInputDecorationTheme,
  elevatedButtonTheme: appElevatedButtonThemeData,
  textButtonTheme: appTextButtonThemeData,

  // iconTheme: appIconThemeData,
);
const BottomNavigationBarThemeData appBottomNavigationBarTheme =
    BottomNavigationBarThemeData(
  backgroundColor: AppColors.kBackgroundWidgetsColor,
  selectedIconTheme: IconThemeData(color: AppColors.kIconColor),
  unselectedIconTheme: IconThemeData(color: AppColors.kSupportTextColor),
  selectedItemColor: AppColors.kIconColor,
  unselectedItemColor: AppColors.kSupportTextColor,
  showSelectedLabels: true,
  showUnselectedLabels: false,
);
const AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: AppColors.kBackgroundColor,
);

const IconThemeData appIconThemeData = IconThemeData(
  color: AppColors.kIconColor,
);

const TextButtonThemeData appTextButtonThemeData = TextButtonThemeData();

final ElevatedButtonThemeData appElevatedButtonThemeData =
    ElevatedButtonThemeData(
        style: ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(11.0),
    ),
  ),
  backgroundColor: MaterialStateProperty.all(AppColors.kBackgroundWidgetsColor),
  minimumSize: MaterialStateProperty.all(
    const Size(57, 57),
  ),
));

const TextSelectionThemeData appTextSelectionThemeData = TextSelectionThemeData(
  cursorColor: AppColors.kIconColor,
  selectionColor: AppColors.kIconColor,
  selectionHandleColor: AppColors.kIconColor,
);

const InputDecorationTheme appInputDecorationTheme = InputDecorationTheme(
  contentPadding: EdgeInsets.only(left: 15.0),
  floatingLabelBehavior: FloatingLabelBehavior.never,
  fillColor: AppColors.kBackgroundWidgetsColor,
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(
      Radius.circular(11.0),
    ),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(11.0),
    ),
    borderSide: BorderSide(
      color: Colors.transparent,
      width: 0,
    ),
  ),
);

const TextTheme appTextTheme = TextTheme(
  headline1: TextStyle(
      fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.kTextColor),
  // Топ текст
  headline2: TextStyle(
      fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.kTextColor),
  // Интересы
  headline3: TextStyle(
      fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.kTextColor),
  // Категории, актеры, категории фильмов
  headline4: TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.kTextColor),
  // Название категории
  subtitle1: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.kSupportTextColor),
  // Текст под заголовком
  subtitle2: TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.kTextColor),
  // Рейтинг, жанр и время в инфе о фильме
  headline5: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: AppColors.kSupportTextColor),
  headline6: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.kSupportTextColor),
  // Текст кнопок на тдругие страницы
  // Актеры и описание фильма
  button: TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.kTextColor),
  // Вспомогательный текст на входе
  bodyText1: TextStyle(
      fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.kTextColor),
  // Категории,
  bodyText2: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w300,
      color: AppColors.kSupportTextColor),
  // Поисковая строка
  overline: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.kSupportTextColor), // Текст в полях ввода,
  // caption:
);
