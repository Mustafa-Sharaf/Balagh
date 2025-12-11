import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Notifications.dart';
import 'app_theme/app_theme.dart';
import 'app_theme/theme_controller.dart';
import 'language/Language.dart';
import 'language/Language_Controller.dart';
import 'modules/Home/Home_Screen.dart';
import 'modules/Notifications/Notifications_Screen.dart';
import 'modules/Profile/Profile_Screen.dart';
import 'modules/SignUp/SignUp_Screen.dart';
import 'modules/Submit_Report/Submit_Report_Screen.dart';
import 'modules/signIn/SignIn_Screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  await Notifications().initNotifications();
  Get.put(MyLanguageController());
  final themeController =Get.put(ThemeController());
  themeController.loadThemeFromStorage();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final myLanguageController = Get.find<MyLanguageController>();
    final ThemeController themeController = Get.find();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SignInScreen(),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      locale:myLanguageController.intiaLanguage.value,
      translations: MyLanguage(),
      getPages: [
        GetPage(name: '/signIn', page: ()=>const SignInScreen()),
        GetPage(name: '/signUp', page: ()=>const SignUpScreen()),
        GetPage(name: '/home', page: ()=> HomeScreen()),
        GetPage(name: '/submitReportScreen', page: ()=> SubmitReportScreen()),
        GetPage(name: '/profile', page: ()=> ProfileScreen()),
        GetPage(name: '/notificationsScreen', page: ()=> NotificationsScreen()),

      ],
    );
  }
}

