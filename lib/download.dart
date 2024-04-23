import 'dart:io';

import 'package:downloader/adhelper.dart';
import 'package:downloader/notofication.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class downloadManager {
  checkpermissionnotif() async {
    var status = await Permission.notification.status;

    if (!status.isGranted) {
      status = await Permission.notification.request();
    }
    if (status.isGranted) {
      print('permission already granted');
    } else {
      checkpermissionnotif();
    }
  }

  checkPermission() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      print('permission already granted');
    } else {
      checkPermission();
    }
  }

  download(name, link) async {
    try {
      NotificationService().showNotification(id: 0, title: 'Download Started');

      print('im here');
      var response = await http.get(Uri.parse(link));
      final file = File('/storage/emulated/0/Download/$name.m4a');
      await file.writeAsBytes(response.bodyBytes);
      NotificationService().showNotification(
        id: 1,
        title: 'Downloaded',
        body: '$name downloaded successfully, check your downloads folder',
      );
      MediaScanner.loadMedia(path: '/storage/emulated/0/Download/$name.m4a');
    } catch (e) {
      print(e);
    }

    print('downloaded');
  }
}

checkPermission() async {
  var status = await Permission.storage.status;

  if (!status.isGranted) {
    status = await Permission.storage.request();
  }
  if (status.isGranted) {
    print('permission already granted');
    // You can start the download or access storage
  } else {
    checkPermission();
  }
}
