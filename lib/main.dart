import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'core/constants/color_constants.dart';
import 'core/constants/string_constants.dart';
import 'core/constants/ui_constants.dart';
import 'shared/injection_container.dart' as di;
import 'presentation/screens/home_screen.dart';
import 'presentation/blocs/random_image/random_image_bloc.dart';
import 'presentation/blocs/theme/theme_bloc.dart';
import 'presentation/blocs/theme/theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint(StringConstants.mainStartingAppInit);

  // Initialize WebView for Android
  WebViewPlatform.instance ??= AndroidWebViewPlatform();

  await di.init();
  debugPrint(StringConstants.mainDependencyInjectionInitialized);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Custom Light Theme
  ThemeData get _lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primary,
      brightness: Brightness.light,
      primary: ColorConstants.primary,
      secondary: ColorConstants.secondary,
      surface: ColorConstants.surfaceLight,
      background: ColorConstants.backgroundLight,
      error: ColorConstants.error,
    ),
    scaffoldBackgroundColor: ColorConstants.backgroundLight,
    cardTheme: CardThemeData(
      elevation: UiConstants.elevation2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiConstants.radius16),
      ),
      color: ColorConstants.surfaceLight,
      shadowColor: ColorConstants.shadowLight.withValues(alpha: 0.1),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: UiConstants.buttonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiConstants.radius16),
        ),
        elevation: UiConstants.elevation2,
        backgroundColor: ColorConstants.primary,
        foregroundColor: Colors.white,
        shadowColor: ColorConstants.primary.withValues(alpha: 0.3),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: ColorConstants.surfaceLight,
      foregroundColor: ColorConstants.textPrimaryLight,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UiConstants.radius12),
        borderSide: BorderSide(color: ColorConstants.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UiConstants.radius12),
        borderSide: BorderSide(color: ColorConstants.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UiConstants.radius12),
        borderSide: BorderSide(color: ColorConstants.primary, width: 2),
      ),
      contentPadding: UiConstants.cardPadding,
      fillColor: ColorConstants.surfaceLight,
      filled: true,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorConstants.primary;
        }
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorConstants.primary.withValues(alpha: 0.3);
        }
        return Colors.grey.withValues(alpha: 0.3);
      }),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: UiConstants.fontSize36.sp,
        fontWeight: UiConstants.fontWeightBold,
        color: ColorConstants.textPrimaryLight,
      ),
      displayMedium: TextStyle(
        fontSize: UiConstants.fontSize32,
        fontWeight: UiConstants.fontWeightBold,
        color: ColorConstants.textPrimaryLight,
      ),
      displaySmall: TextStyle(
        fontSize: UiConstants.fontSize28,
        fontWeight: UiConstants.fontWeightSemiBold,
        color: ColorConstants.textPrimaryLight,
      ),
      headlineLarge: TextStyle(
        fontSize: UiConstants.fontSize24,
        fontWeight: UiConstants.fontWeightSemiBold,
        color: ColorConstants.textPrimaryLight,
      ),
      headlineMedium: TextStyle(
        fontSize: UiConstants.fontSize20,
        fontWeight: UiConstants.fontWeightSemiBold,
        color: ColorConstants.textPrimaryLight,
      ),
      headlineSmall: TextStyle(
        fontSize: UiConstants.fontSize18,
        fontWeight: UiConstants.fontWeightMedium,
        color: ColorConstants.textPrimaryLight,
      ),
      titleLarge: TextStyle(
        fontSize: UiConstants.fontSize16,
        fontWeight: UiConstants.fontWeightSemiBold,
        color: ColorConstants.textPrimaryLight,
      ),
      titleMedium: TextStyle(
        fontSize: UiConstants.fontSize16,
        fontWeight: UiConstants.fontWeightMedium,
        color: ColorConstants.textPrimaryLight,
      ),
      titleSmall: TextStyle(
        fontSize: UiConstants.fontSize14,
        fontWeight: UiConstants.fontWeightMedium,
        color: ColorConstants.textPrimaryLight,
      ),
      bodyLarge: TextStyle(
        fontSize: UiConstants.fontSize16,
        fontWeight: UiConstants.fontWeightRegular,
        color: ColorConstants.textPrimaryLight,
      ),
      bodyMedium: TextStyle(
        fontSize: UiConstants.fontSize14,
        fontWeight: UiConstants.fontWeightRegular,
        color: ColorConstants.textPrimaryLight,
      ),
      bodySmall: TextStyle(
        fontSize: UiConstants.fontSize12,
        fontWeight: UiConstants.fontWeightRegular,
        color: ColorConstants.textSecondaryLight,
      ),
      labelLarge: TextStyle(
        fontSize: UiConstants.fontSize14,
        fontWeight: UiConstants.fontWeightMedium,
        color: ColorConstants.textPrimaryLight,
      ),
      labelMedium: TextStyle(
        fontSize: UiConstants.fontSize12,
        fontWeight: UiConstants.fontWeightMedium,
        color: ColorConstants.textSecondaryLight,
      ),
      labelSmall: TextStyle(
        fontSize: UiConstants.fontSize10,
        fontWeight: UiConstants.fontWeightMedium,
        color: ColorConstants.textSecondaryLight,
      ),
    ),
  );

  // Custom Dark Theme
  ThemeData get _darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primary,
      brightness: Brightness.dark,
      primary: ColorConstants.primary,
      secondary: ColorConstants.secondary,
      surface: ColorConstants.surfaceDark,
      background: ColorConstants.backgroundDark,
      error: ColorConstants.error,
    ),
    scaffoldBackgroundColor: ColorConstants.backgroundDark,
    cardTheme: CardThemeData(
      elevation: UiConstants.elevation2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiConstants.radius16),
      ),
      color: ColorConstants.surfaceDark,
      shadowColor: Colors.black.withValues(alpha: 0.2),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: UiConstants.buttonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiConstants.radius16),
        ),
        elevation: UiConstants.elevation2,
        backgroundColor: ColorConstants.primary,
        foregroundColor: Colors.white,
        shadowColor: ColorConstants.primary.withValues(alpha: 0.3),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: ColorConstants.surfaceDark,
      foregroundColor: ColorConstants.textPrimaryDark,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UiConstants.radius12),
        borderSide: BorderSide(color: ColorConstants.borderDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UiConstants.radius12),
        borderSide: BorderSide(color: ColorConstants.borderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UiConstants.radius12),
        borderSide: BorderSide(color: ColorConstants.primary, width: 2),
      ),
      contentPadding: UiConstants.cardPadding,
      fillColor: ColorConstants.surfaceDark,
      filled: true,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorConstants.secondary;
        }
        return ColorConstants.surfaceDark;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorConstants.secondary.withValues(alpha: 0.3);
        }
        return Colors.grey.withValues(alpha: 0.3);
      }),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: UiConstants.fontSize36.sp,
        fontWeight: UiConstants.fontWeightBold,
        color: ColorConstants.textPrimaryDark,
      ),
      displayMedium: TextStyle(
        fontSize: UiConstants.fontSize32,
        fontWeight: UiConstants.fontWeightBold,
        color: ColorConstants.textPrimaryDark,
      ),
      displaySmall: TextStyle(
        fontSize: UiConstants.fontSize28,
        fontWeight: UiConstants.fontWeightSemiBold,
        color: ColorConstants.textPrimaryDark,
      ),
      headlineLarge: TextStyle(
        fontSize: UiConstants.fontSize24,
        fontWeight: UiConstants.fontWeightSemiBold,
        color: ColorConstants.textPrimaryDark,
      ),
      headlineMedium: TextStyle(
        fontSize: UiConstants.fontSize20,
        fontWeight: UiConstants.fontWeightSemiBold,
        color: ColorConstants.textPrimaryDark,
      ),
      headlineSmall: TextStyle(
        fontSize: UiConstants.fontSize18,
        fontWeight: UiConstants.fontWeightMedium,
        color: ColorConstants.textPrimaryDark,
      ),
      titleLarge: TextStyle(
        fontSize: UiConstants.fontSize16,
        fontWeight: UiConstants.fontWeightSemiBold,
        color: ColorConstants.textPrimaryDark,
      ),
      titleMedium: TextStyle(
        fontSize: UiConstants.fontSize16,
        fontWeight: UiConstants.fontWeightMedium,
        color: ColorConstants.textPrimaryDark,
      ),
      titleSmall: TextStyle(
        fontSize: UiConstants.fontSize14,
        fontWeight: UiConstants.fontWeightMedium,
        color: ColorConstants.textPrimaryDark,
      ),
      bodyLarge: TextStyle(
        fontSize: UiConstants.fontSize16,
        fontWeight: UiConstants.fontWeightRegular,
        color: ColorConstants.textPrimaryDark,
      ),
      bodyMedium: TextStyle(
        fontSize: UiConstants.fontSize14,
        fontWeight: UiConstants.fontWeightRegular,
        color: ColorConstants.textPrimaryDark,
      ),
      bodySmall: TextStyle(
        fontSize: UiConstants.fontSize12,
        fontWeight: UiConstants.fontWeightRegular,
        color: ColorConstants.textSecondaryDark,
      ),
      labelLarge: TextStyle(
        fontSize: UiConstants.fontSize14,
        fontWeight: UiConstants.fontWeightMedium,
        color: ColorConstants.textPrimaryDark,
      ),
      labelMedium: TextStyle(
        fontSize: UiConstants.fontSize12,
        fontWeight: UiConstants.fontWeightMedium,
        color: ColorConstants.textSecondaryDark,
      ),
      labelSmall: TextStyle(
        fontSize: UiConstants.fontSize10,
        fontWeight: UiConstants.fontWeightMedium,
        color: ColorConstants.textSecondaryDark,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    debugPrint(StringConstants.myAppBuildingWithScreenUtilInit);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<RandomImageBloc>(
              create: (_) => di.getIt<RandomImageBloc>(),
            ),
            BlocProvider<ThemeBloc>(
              create: (_) => ThemeBloc(),
            ),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                title: StringConstants.appName,
                debugShowCheckedModeBanner: false,
                theme: _lightTheme,
                darkTheme: _darkTheme,
                themeMode: themeState.themeMode,
                home: const HomeScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
