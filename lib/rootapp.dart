import 'package:downloader/search.dart';
import 'package:downloader/screens/home.dart';
import 'package:downloader/screens/miniplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'theme/colors.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        body: Stack(children: [
          getBody(),
          Positioned(
            bottom: 0, // This sticks the widget to the bottom of the Stack
            left: 0,
            right: 0,
            child: Column(
              children: [
                // miniplayer(),
              ],
            ),
          ),
        ]),
        bottomNavigationBar: getFooter());
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: [
        homecompo(),
        home(),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      FeatherIcons.home,
      FeatherIcons.search,
    ];
    return Material(
      color: black,
      child: Container(
        height: 100,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(items.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      activeTab = index;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.transparent),
                      width: MediaQuery.of(context).size.width * 0.4,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 5),
                      child: Icon(
                        items[index],
                        color: activeTab == index ? Colors.greenAccent : white,
                      )),
                );
              })),
        ),
      ),
    );
  }
}
