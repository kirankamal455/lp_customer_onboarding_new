//import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lp_customer_onboarding/const/theme_data.dart';

class Themes {
  Themes._();
  static ThemeData get pinkTheme => ThemeData(
        fontFamily: "Roboto",
        primaryColor: voiletPrimary,
        primaryColorLight: pinkAccentPrimary,
        disabledColor: Colors.grey,
        datePickerTheme:
            const DatePickerThemeData(backgroundColor: Colors.white),
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: voiletPrimary,
            selectionColor: voiletPrimary,
            selectionHandleColor: voiletPrimary),
        // appBarTheme: const AppBarTheme(
        //   systemOverlayStyle: SystemUiOverlayStyle.light,
        //   iconTheme: IconThemeData(color: Colors.white),
        // ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: voiletPrimary),
        ),
        colorScheme: theme.colorScheme
            .copyWith(
              secondary: pinkAccent,
              primary: voiletPrimary,
            )
            .copyWith(surface: pinkBackground),
      );

  static ThemeData get greenTheme => ThemeData(
        disabledColor: Colors.grey,
        fontFamily: "Roboto",
        primaryColor: greenPrimary,
        primaryColorLight: secondaryGreenPrimary,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        datePickerTheme:
            const DatePickerThemeData(backgroundColor: Colors.white),
        colorScheme: theme.colorScheme
            .copyWith(
              secondary: greenAccent,
              primary: greenPrimary,
            )
            .copyWith(surface: greenBackground),
      );
  static ThemeData get blueTheme => ThemeData(
        fontFamily: "Roboto",
        primaryColor: bluePrimary,
        primaryColorLight: blueSecondary,
        disabledColor: Colors.grey,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        datePickerTheme:
            const DatePickerThemeData(backgroundColor: Colors.white),
        colorScheme: theme.colorScheme
            .copyWith(
              secondary: blueAccent,
              primary: bluePrimary,
            )
            .copyWith(surface: blueBackground),
      );
  static ThemeData get greyTheme => ThemeData(
        fontFamily: "Roboto",
        primaryColor: greyPrimary,
        primaryColorLight: greySecondary,
        disabledColor: Colors.grey,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        datePickerTheme:
            const DatePickerThemeData(backgroundColor: Colors.white),
        colorScheme: theme.colorScheme
            .copyWith(
              secondary: greyAccent,
              primary: greyPrimary,
            )
            .copyWith(surface: greyBackground),
      );
  static ThemeData get lightBlueTheme => ThemeData(
        fontFamily: "Roboto",
        disabledColor: Colors.grey,
        primaryColor: lightBluePrimary,
        primaryColorLight: lightBlueSecondary,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        datePickerTheme:
            const DatePickerThemeData(backgroundColor: Colors.white),
        colorScheme: theme.colorScheme
            .copyWith(
              secondary: lightBlueAccent,
              primary: lightBluePrimary,
            )
            .copyWith(surface: lightBlueBackground),
      );
  static ThemeData get darkPinkTheme => ThemeData(
        fontFamily: "Roboto",
        disabledColor: Colors.grey,
        primaryColor: darkPinkPrimary,
        primaryColorLight: darkPinkSecondary,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        datePickerTheme:
            const DatePickerThemeData(backgroundColor: Colors.white),
        colorScheme: theme.colorScheme
            .copyWith(
              secondary: darkPinkAccent,
              primary: darkPinkPrimary,
            )
            .copyWith(surface: darkPinkBackground),
      );
  static ThemeData get orangeTheme => ThemeData(
        fontFamily: "Roboto",
        disabledColor: Colors.grey,
        primaryColor: orangePrimary,
        primaryColorLight: orangeSecondary,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        datePickerTheme:
            const DatePickerThemeData(backgroundColor: Colors.white),
        colorScheme: theme.colorScheme
            .copyWith(
              secondary: orangeAccent,
              primary: orangePrimary,
            )
            .copyWith(surface: orangeBackground),
      );
  static ThemeData get burgandiTheme => ThemeData(
        fontFamily: "Roboto",
        disabledColor: Colors.grey,
        primaryColor: burgandyPrimary,
        primaryColorLight: burgandySecondary,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        datePickerTheme:
            const DatePickerThemeData(backgroundColor: Colors.white),
        colorScheme: theme.colorScheme
            .copyWith(
              secondary: burgandyAccent,
              primary: burgandyPrimary,
            )
            .copyWith(surface: burgandyBackground),
      );

  static ThemeData get theme => ThemeData(
        fontFamily: "Poppins",
        primaryColor: voiletPrimary,
        primaryColorLight: pinkAccentPrimary,
        disabledColor: Colors.grey,
        datePickerTheme: const DatePickerThemeData(
            backgroundColor: Colors.white,
            headerBackgroundColor: voiletPrimary,
            // todayForegroundColor: WidgetStatePropertyAll(voiletPrimary),
            headerForegroundColor: Colors.white),
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: voiletPrimary,
            selectionColor: Colors.grey,
            selectionHandleColor: voiletPrimary),
        colorScheme: const ColorScheme.light(primary: voiletPrimary),
        appBarTheme: const AppBarTheme(
          shadowColor: Colors.transparent,
          elevation: 0.0,
          color: voiletPrimary, // Set your app bar background color
          iconTheme: IconThemeData(
            color: Colors
                .white, // This changes all icons, including the back arrow
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
          ),

          // systemOverlayStyle: SystemUiOverlayStyle(
          //   statusBarColor: voiletPrimary,
          //   statusBarIconBrightness: Brightness.light,
          // ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey.withOpacity(0.12),
          filled: true,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          labelStyle: const TextStyle(color: Colors.black),
          errorStyle: const TextStyle(color: Colors.red),
        ),
        checkboxTheme: const CheckboxThemeData(
            side: BorderSide(color: Colors.grey),
            fillColor: WidgetStatePropertyAll(Colors.white)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0.1,
            shadowColor: voiletPrimary,
            backgroundColor: voiletPrimary,
            textStyle:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            minimumSize: const Size(
              double.infinity,
              50,
            ),
            maximumSize: const Size(double.infinity, 50),
          ),
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: voiletPrimary),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
        switchTheme: const SwitchThemeData(
          thumbColor: WidgetStatePropertyAll(Colors.white),
          trackColor: WidgetStatePropertyAll(Colors.blue),
        ),
      );

  // static ThemeData get darkTheme => FlexThemeData.dark(
  //       scheme: FlexScheme.blueM3,
  //       surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  //       blendLevel: 13,
  //       subThemesData: const FlexSubThemesData(
  //         blendOnLevel: 20,
  //         useTextTheme: true,
  //         useM2StyleDividerInM3: true,
  //         elevatedButtonSchemeColor: SchemeColor.onPrimary,
  //         elevatedButtonSecondarySchemeColor: SchemeColor.primary,
  //         alignedDropdown: true,
  //         useInputDecoratorThemeInDialogs: true,
  //       ),
  //       visualDensity: FlexColorScheme.comfortablePlatformDensity,
  //       useMaterial3: true,
  //       swapLegacyOnMaterial3: true,
  //       // To use the Playground font, add GoogleFonts package and uncomment
  //       // fontFamily: GoogleFonts.notoSans().fontFamily,
  //     );
}
