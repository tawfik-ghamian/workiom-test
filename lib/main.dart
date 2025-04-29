import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'binding/auth_binding.dart';
import 'binding/splash_binding.dart';
import 'view/email_screen.dart';
import 'view/home_screen.dart';
import 'view/sign_in_screen.dart';
import 'view/sign_up_screen.dart';
import 'view/splash_screen.dart';
import 'view/workspace_info_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: SplashScreenBinding(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xFFFFFFFF),
        ),
        primaryColor: const Color(0xFF4E86F7),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        fontFamily: "Rubik",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4E86F7),
          primary: const Color(0xFF4E86F7),
          secondary: const Color(0xFFFFFFFF),
        ),
        useMaterial3: true,
      ),
      title: "Workiom Test",
      home: const SplashScreen(),
      getPages: [
        GetPage(
          name: SplashScreen.routeName,
          page: () => const SplashScreen(),
        ),
        GetPage(
          binding: AuthBinding(),
          name: SignInScreen.routeName,
          page: () => const SignInScreen(),
        ),
        GetPage(
          name: SignUpScreen.routeName,
          page: () => const SignUpScreen(),
        ),
        GetPage(
          name: UserEmailScreen.routeName,
          page: () => const UserEmailScreen(),
        ),
        GetPage(
          name: WorkSpaceInfoScreen.routeName,
          page: () => const WorkSpaceInfoScreen(),
        ),
        GetPage(
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
        ),
      ],
    );
  }
}
