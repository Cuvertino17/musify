import 'package:downloader/constants.dart';
import 'package:downloader/helper/converttomediaiteam.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:vibration/vibration.dart';

bool checkliked(dynamic searchValue) {
  // Iterate through the values in the box and check if any of them match the searchValue.
  final box = likedbox;

  for (var i = 0; i < box.length; i++) {
    final value = box.getAt(i);
    // print(value['link']);
    // print('checking this $searchValue');

    if (value['link'] == searchValue) {
      return true;
    }
  }

  return false;
}

Widget likedbutton(songinfo) {
  // print(checkliked(songinfo['link']));
  return ValueListenableBuilder(
      valueListenable: likedbox.listenable(),
      builder: (BuildContext, box, Widget) {
        return IconButton(
            onPressed: () {
              Vibration.vibrate(duration: 50);
              checkliked(songinfo['link'])
                  ? removefromliked(songinfo['link'])
                  : addtolikedsongs(songinfo);
            },
            icon: checkliked(songinfo['link'])
                ? Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.red[900],
                  )
                : Icon(CupertinoIcons.heart));
        // return checkliked(songinfo['link'])
        // ? Icon(
        //     CupertinoIcons.heart_fill,
        //     color: Colors.red[900],
        //   )
        // : Icon(CupertinoIcons.heart);
      });
}

bool checkrecent(dynamic searchValue) {
  final box = recentbox;

  for (var i = 0; i < box.length; i++) {
    final value = box.getAt(i);
    // print(value['link']);
    // print('checking this $searchValue');

    if (value['link'] == searchValue) {
      return true;
    }
  }

  return false;
}

recentSongs(songinfo) {
  print(" already in recents ${checkrecent(songinfo['link'])}");
  checkrecent(songinfo['link']) ? null : addtorecentsongs(songinfo);
}

bool checkartistliked(dynamic searchValue) {
  // Iterate through the values in the box and check if any of them match the searchValue.
  final box = artistbox;

  for (var i = 0; i < box.length; i++) {
    final value = box.getAt(i);
    // print(value['link']);
    // print('checking this $searchValue');

    if (value['id'] == searchValue) {
      return true;
    }
  }
  return false;
}

Widget Artistlikedbutton(info) {
  return ValueListenableBuilder(
      valueListenable: artistbox.listenable(),
      builder: (BuildContext, box, Widget) {
        return IconButton(
            onPressed: () {
              Vibration.vibrate(duration: 50);
              checkartistliked(info['id'])
                  ? unlikeartist(info['id'])
                  : likeartist(info);
            },
            icon: checkartistliked(info['id'])
                ? Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.red[900],
                  )
                : Icon(CupertinoIcons.heart));
      });
}
