import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final likedbox = Hive.box('liked');
final recentbox = Hive.box('recents');
final artistbox = Hive.box('artist');

Widget emptyscreen(String mssg, String logo) {
  return Center(
      child: Container(
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          mssg,
          style: TextStyle(fontSize: 25),
        ),
        Text(
          ' $logo',
          style: TextStyle(fontSize: 30, color: Colors.lightBlue),
        )
      ],
    ),
  ));
}
