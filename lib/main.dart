import 'dart:io';
import 'package:downloader/adhelper.dart';
import 'package:downloader/rootapp.dart';
import 'package:downloader/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:downloader/notofication.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initall();
  // await setupServiceLocator();
  // await MobileAds.instance.initialize();
  // await Hive.initFlutter();
  // await Hive.openBox('liked');
  // await Hive.openBox('recents');
  // await Hive.openBox('artist');
  // interstitalad().loadAd();
  // NotificationService().initNotification();
  // Paint.enableDithering = true;
  // MobileAds.instance.initialize();
  // FlutterDisplayMode.setHighRefreshRate();

  // if (Platform.isAndroid) {
  //   FlutterDisplayMode.setHighRefreshRate();
  // }

  runApp(const MyApp());
}

// setOptimalDisplayMode() {
//   FlutterDisplayMode.setHighRefreshRate();
// }
initall() async {
  await setupServiceLocator();
  await MobileAds.instance.initialize();
  await Hive.initFlutter();
  await Hive.openBox('liked');
  await Hive.openBox('recents');
  await Hive.openBox('artist');
  interstitalad().loadAd();
  NotificationService().initNotification();
  // Paint.enableDithering = true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'circular',
            useMaterial3: true,
            brightness: Brightness.dark),
        home: RootApp());
  }
}
