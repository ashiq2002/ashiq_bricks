import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'style.dart';

import '../color/app_colors.dart';

class AppTheme {
  static const lightThemeFont = "Roboto",
      darkThemeFont = "Roboto";
  // light theme
  static final lightTheme = ThemeData(
    primaryColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.surfaceColor,

    brightness: Brightness.light,

    useMaterial3: true,
    fontFamily: lightThemeFont,
    splashColor: Colors.transparent,
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: AppColors.whiteColor,
        contentPadding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        hintStyle: TextStyle(color: AppColors.blackColor)),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: AppColors.primaryColor),
      bodyMedium: TextStyle(color: AppColors.blackColor, fontSize: 18),
      bodyLarge: TextStyle(color: AppColors.kPrimaryColorx),
      labelSmall: TextStyle(color: AppColors.kPrimaryColorx),
      labelMedium: TextStyle(color: AppColors.kPrimaryColorx),
      labelLarge: TextStyle(color: AppColors.kPrimaryColorx),
      displaySmall: TextStyle(color: AppColors.kPrimaryColorx),
      displayMedium: TextStyle(color: AppColors.kPrimaryColorx),
      displayLarge: TextStyle(color: AppColors.kPrimaryColorx),
    ),
    switchTheme: SwitchThemeData(
      thumbColor:
          MaterialStateProperty.resolveWith<Color>((states) => lightThemeColor),
    ),
    appBarTheme: AppBarTheme(
      //color:CustomColor.kPrimaryColorx,

      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: AppColors.primarySlate500),
      backgroundColor: AppColors.whiteColor,
      scrolledUnderElevation: 0,
      titleTextStyle: robotoSemiBold.copyWith(
        fontSize: 18.sp,
        color: AppColors.primarySlate800

      ),
      actionsIconTheme: IconThemeData(color: AppColors.kPrimaryColorx),
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: AppColors.whiteColor,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.whiteColor,
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.kPrimaryColorx,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(size: 28),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: AppColors.kPrimaryColorx)),
    // colorScheme: ColorScheme(background: CustomColor.whiteColor, brightness: null, primary: null, onPrimary: null)
  );

  /// dark theme

  static final darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.kPrimaryColorx,
    useMaterial3: true,
    fontFamily: darkThemeFont,
    splashColor: Colors.transparent,
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: AppColors.whiteColor,
        contentPadding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        hintStyle: TextStyle(color: AppColors.blackColor)),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: AppColors.blackColor),
      bodyMedium: TextStyle(color: AppColors.blackColor),
      bodyLarge: TextStyle(color: AppColors.whiteColor),
      labelSmall: TextStyle(color: AppColors.whiteColor),
      labelMedium: TextStyle(color: AppColors.whiteColor),
      labelLarge: TextStyle(color: AppColors.whiteColor),
      displaySmall: TextStyle(color: AppColors.whiteColor),
      displayMedium: TextStyle(color: AppColors.whiteColor),
      displayLarge: TextStyle(color: AppColors.whiteColor),
    ),
    switchTheme: SwitchThemeData(
      trackColor:
          MaterialStateProperty.resolveWith<Color>((states) => darkThemeColor),
    ),
    appBarTheme: AppBarTheme(
      // color:CustomColor.kPrimaryColorx,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.whiteColor),
      backgroundColor: AppColors.kPrimaryColorx,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor,
        fontSize: 18, //20
      ),
      actionsIconTheme: IconThemeData(color: lightThemeColor),
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: AppColors.kPrimaryColorx,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.kPrimaryColorx,
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.whiteColor,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(size: 28),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: AppColors.whiteColor)),
    // colorScheme: ColorScheme(background: CustomColor.kPrimaryColorx)
  );

  // colors
  static Color lightThemeColor = Colors.white,
      white = Colors.white,
      black = Colors.black,
      darkThemeColor = AppColors.kPrimaryColorx;
}

// ThemeData theme() {
//   return ThemeData(
//     scaffoldBackgroundColor: Colors.white,
//     fontFamily: "DMSans",
//       primaryColor: CustomColor.kPrimaryColorx,
//     useMaterial3: true,
//
//     bottomNavigationBarTheme:bottomNavigationBarTheme(),
//     splashColor: Colors.transparent,
//       // highlightColor: Colors.transparent,
//     navigationBarTheme:navigationBarTheme(),
//
//   );
// }
//
// ThemeData darkTheme() {
//   return ThemeData(
//     scaffoldBackgroundColor: Colors.white,
//     fontFamily: "DMSans",
//     primaryColor: CustomColor.kPrimaryColorx,
//     useMaterial3: true,
//     appBarTheme: DarkappBarTheme(),
//     bottomNavigationBarTheme:bottomNavigationBarTheme(),
//     splashColor: Colors.transparent,
//     // highlightColor: Colors.transparent,
//     navigationBarTheme:navigationBarTheme(),
//
//   );
// }
//
// AppBarTheme DarkappBarTheme() {
//   return const AppBarTheme(
//     color:CustomColor.kPrimaryColorx,
//     elevation: 0,
//     centerTitle: true,
//
//     iconTheme: IconThemeData(color:CustomColor.whiteColor),
//     titleTextStyle: TextStyle(color: CustomColor.whiteColor, fontSize: 18),
//   );
// }
//

//
//  BottomNavigationBarThemeData? bottomNavigationBarTheme() {
//   return const BottomNavigationBarThemeData(
//     backgroundColor: CustomColor.kPrimaryColorx,
//     elevation: 1,
//     type: BottomNavigationBarType.fixed,
//     selectedItemColor: CustomColor.whiteColor,
//     showUnselectedLabels: true,
//     selectedIconTheme: IconThemeData(
//       size: 28
//     ),
//     unselectedItemColor: Colors.grey,
//     selectedLabelStyle: TextStyle(
//       color: CustomColor.whiteColor
//     )
//   );
// }
//
// NavigationBarThemeData? navigationBarTheme() {
//   return const NavigationBarThemeData(
//     backgroundColor: CustomColor.kPrimaryColorx,
//     elevation: 0,
//     indicatorColor: CustomColor.whiteColor,
//   );
// }
