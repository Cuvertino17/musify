import 'package:downloader/screens/liked.dart';
import 'package:downloader/screens/recent.dart';
import 'package:downloader/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class lib extends StatefulWidget {
  const lib({super.key});

  @override
  State<lib> createState() => _libState();
}

class _libState extends State<lib> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: getAppBar(),
      body: getBody(context),
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
                  child: Text('Library',
                      style: TextStyle(
                          fontSize: 25,
                          color: white,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        )),
  );
}

Widget getBody(BuildContext cntx) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, left: 10),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                cntx, MaterialPageRoute(builder: (context) => liked()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              child: ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image(image: AssetImage('assets/like.png'))),
                title: Text(
                  'Liked tracks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("watch all tracks you've liked"),
                trailing: Icon(
                  CupertinoIcons.pin_fill,
                  size: 17,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(recent()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              child: ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image(image: AssetImage('assets/like.png'))),
                title: Text(
                  'Favourite Artist',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("all your favourite artist"),
                trailing: Icon(
                  CupertinoIcons.pin_fill,
                  size: 17,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
