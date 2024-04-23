import 'package:downloader/constants.dart';
import 'package:downloader/screens/liked.dart';
import 'package:downloader/screens/likedartists.dart';
import 'package:downloader/screens/recent.dart';
import 'package:flutter/material.dart';

class libs extends StatelessWidget {
  const libs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => liked()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: -10),
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image(image: AssetImage('assets/like.png'))),
                title: Text(
                  'Liked tracks t',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('songs • ${likedbox.values.length}'),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            // print(recentbox.values);
            // await recentbox.clear();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => recent()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: -10),
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image(image: AssetImage('assets/recent.png'))),
                title: Text(
                  'recently played tracks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('songs • ${recentbox.values.length}'),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => likedartist()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: -10),
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image(image: AssetImage('assets/dance.png'))),
                title: Text(
                  'favourite artists',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('songs • ${artistbox.values.length}'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
