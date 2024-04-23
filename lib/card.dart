import 'package:downloader/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

// image, Title, Subtitle, uri
Widget Boxcard(image, Title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          // border: Border.all(color: Color.fromARGB(255, 22, 22, 22)),
          // gradient: LinearGradient(colors: [
          //   Color.fromARGB(255, 26, 26, 26),
          //   Color.fromARGB(255, 56, 53, 53),
          // ]),
          color: Color(0xff2A2A2A),
          // color: Color.fromARGB(255, 34, 34, 34),
          borderRadius: BorderRadius.circular(4)),
      height: 60,
      width: 153,
      // color: primary,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image(
                image: AssetImage(image),
                width: 60,
                height: 60,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            Title,
            style:
                GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}

Widget Boxcard2(image, Title) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15),
    height: 90,
    width: 130,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CachedNetworkImage(
            placeholder: ((context, url) => Image.asset('assets/music.png')),
            // image: image,
            // width: 110,
            // height: 90,
            fit: BoxFit.cover, imageUrl: image,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Title,
            style: TextStyle(fontSize: 18),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        )
      ],
    ),
  );
}
