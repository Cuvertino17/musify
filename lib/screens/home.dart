import 'package:audio_service/audio_service.dart';

import 'package:downloader/adhelper.dart';
import 'package:downloader/constants.dart';
import 'package:downloader/player.dart';
import 'package:downloader/screens/libs.dart';

import 'package:downloader/screens/liked.dart';
import 'package:downloader/screens/likedartists.dart';
import 'package:downloader/screens/likedrecents.dart';
import 'package:downloader/screens/playedrecents.dart';
import 'package:downloader/screens/recent.dart';
import 'package:downloader/service_locator.dart';
import 'package:downloader/theme/colors.dart';
import 'package:downloader/theme/greetings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:downloader/card.dart';
import 'package:get/get.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class homecompo extends StatefulWidget {
  const homecompo({super.key});

  @override
  State<homecompo> createState() => _homecompoState();
}

class _homecompoState extends State<homecompo> {
  var myContr = Get.put(MyadControllerforsearch());
  final _audioHandler = getIt<AudioHandler>();

  @override
  void initState() {
    super.initState();
    // interstitalad().interstitialAd!.show();
    initit();
    myContr.loadAd();
    _requestPermissionsAndExecuteLogic();
  }

  initit() async {
    await setupServiceLocator();
  }

  Future<void> _requestPermissionsAndExecuteLogic() async {
    // Request notification permission
    var notificationStatus = await Permission.notification.status;
    if (notificationStatus.isDenied) {
      await Permission.notification.request();
    }

    // Request storage permission (assuming WRITE_EXTERNAL_STORAGE)
    var storageStatus = await Permission.storage.status;
    if (storageStatus.isDenied) {
      await Permission.storage.request();
    }

    // Check if both permissions are granted
    if (await Permission.notification.isGranted &&
        await Permission.storage.isGranted) {
      // Execute your logic here
      print('im here');

      print('Notification and storage permissions granted');
    } else {
      var statuses = await [
        Permission.storage,
        Permission.notification,
      ].request();
      // Handle if either permission is not granted
      print('Notification or storage permission not granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: black,
      appBar: getAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: [
            libs(),
            SizedBox(
              height: 20,
            ),
            plydrecents(),
            likedrecents(),
            SizedBox(
              height: 5,
            ),
            // Obx(() => Container(
            //       alignment: Alignment.center,
            //       // width: MediaQuery.of(context).size.width * 0.9,
            //       padding: EdgeInsets.symmetric(horizontal: 15),
            //       child: myContr.isAdLoaded.value
            //           ? ConstrainedBox(
            //               constraints: const BoxConstraints(
            //                 maxHeight: 200,
            //                 minHeight: 100,
            //               ),
            //               child: AdWidget(ad: myContr.nativeAd!))
            //           : const SizedBox(),
            //     )),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                    ),
                    child: Text(
                      'Made With ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.red[900],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget getAppBar() {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    elevation: 0,
    // centerTitle: true,
    title: Padding(
        padding: const EdgeInsets.only(left: 0, right: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   child: Icon(FeatherIcons.user),
                // ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(getGreeting(),
                      style: TextStyle(
                          fontSize: 25,
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'circular')),
                ),
              ],
            ),
          ],
        )),
  );
}
