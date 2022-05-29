import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const black = Color(0xff000000);
const green = Color(0xff068246);
const white = Color(0xFFFFFFFF);
const red = Color(0xFFF44336);
const primary = Color(0xFFFFD200);
const primaryVariant = Color(0xFFFF7000);
const secondary = Color(0xFF27AE60);
const secondaryVariant = Color(0xFF47B782);
const textColorSecondary = Color(0xFF838383);
const textPrimary = Color(0xFF55585C);
const textColorHint = Color(0xFFA1A1A1);
const unselectedHistory = Color(0xFFEFEFEF);
const kTextPurple = Color(0xFF573353);
const kBackgroundInput = Color(0xFFFFF6ED);
const kIconColor = Color(0xFFFC9D45);
const kColorGrey = Color(0xFF9E9E9E);
const green2 = Color(0xFF1CC37A);
const grey300 = Color(0xFFE0E0E0);
const grey500 = Color(0xFF9E9E9E);
const grey600 = Color(0xFF757575);
const grey700 = Color(0xFF616161);

const grey = Color(0xFFEBEFF0);
const orange = Color(0xFFFB7834);
const lightGreyBackground = Color(0xFFF1F1F1);
const background = Color(0xFFF6F6F6);
const textPrimaryVariant = Color(0xFF2D2B37);

const primaryPetugas = Color(0xFFFF7000);
const secondaryPetugas = Color(0xFF47B782);
const textGrey = Color(0xFF858585);
const header = Color(0xFFFFC736);
const error = Color(0xFFF5365C);
const danger = Color(0xFFBB2124);

void whiteBar() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

const spacer = Spacer();
const designSize = Size(414, 896);
