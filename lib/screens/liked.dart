import 'package:audio_service/audio_service.dart';
import 'package:downloader/constants.dart';
import 'package:downloader/helper/checker.dart';
import 'package:downloader/helper/converttomediaiteam.dart';
import 'package:downloader/player.dart';
import 'package:downloader/service_locator.dart';
import 'package:downloader/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class liked extends StatefulWidget {
  const liked({super.key});

  @override
  State<liked> createState() => _likedState();
}

class _likedState extends State<liked> {
  final _audioHandler = getIt<AudioHandler>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        // appBar: getAppBar(),
        body: ValueListenableBuilder(
          valueListenable: likedbox.listenable(),
          builder: (BuildContext context, snapshot, Widget? child) {
            return CustomScrollView(
              slivers: <Widget>[
                //2
                SliverAppBar(
                  // actions: [
                  //   Padding(
                  //     padding: const EdgeInsets.only(right: 40.0),
                  //     child: IconButton(
                  //         onPressed: () {}, icon: Icon(CupertinoIcons.heart)),
                  //   )
                  // ],

                  surfaceTintColor: black,
                  pinned: true,
                  // elevation: 0,
                  backgroundColor: black,
                  expandedHeight: 360.0,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: EdgeInsets.only(top: 10),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 10),
                        //   child: Icon(
                        //     FeatherIcons.user,
                        //     color: Colors.indigoAccent,
                        //   ),
                        // ),
                        Container(
                          // color: Colors.amber,
                          // width: ,
                          child: Text(
                            'Liked Tracks',
                            style: TextStyle(
                                fontSize: 17,
                                color: white,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            _audioHandler.stop();
                            _audioHandler.customAction('name');
                            _audioHandler.addQueueItems(
                                converttomedia(snapshot.values.toList()));
                            // _audioHandler.play();
                            _audioHandler.skipToQueueItem(0);

                            Get.to(playerscreen());
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.red[900],
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: white,
                            ),
                          ),
                        )

                        //  icon: Icon(FeatherIcons.play)
                      ],
                    ),
                    background: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [black, Colors.transparent],
                          ).createShader(Rect.fromLTRB(
                              0, -140, rect.width, rect.height - 20));
                        },
                        blendMode: BlendMode.darken,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 20),
                          // padding: EdgeInsets.all(800),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.red[900]!,
                                // Colordata.data.dominantColor.color,

                                // Colordata.data!.dominantColor!.color,
                                black
                              ])),
                          child: Image.asset(
                            'assets/like.png',
                            height: 200,
                            width: 200,
                            fit: BoxFit.fill,
                          ),
                        )
                        // },

                        ),
                  ),
                ),
                //3
                // Text(
                //   'Top Songs',
                //   style: TextStyle(
                //     fontSize: 18,
                //     color: subwhite,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: likedbox.length,
                    (context, index) {
                      print(snapshot.getAt(index)['song']);
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 30),
                        child: GestureDetector(
                          onTap: () {
                            print(snapshot.values.toList());
                            // _audioHandler.stop();
                            _audioHandler.customAction('name');

                            _audioHandler.addQueueItems(
                                converttomedia(snapshot.values.toList()));
                            _audioHandler.skipToQueueItem(index);
                            Get.to(playerscreen());
                          },
                          child: Container(
                              height: 60,
                              // width: MediaQuery.of(context).size.width*9,
                              // color: Colors.amberAccent,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      snapshot.getAt(index)['image'],
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 180,
                                          child: Text(
                                            snapshot.getAt(index)['song'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: white,
                                                fontWeight: FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 180,
                                          child: Text(
                                            snapshot.getAt(index)['artist'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: subwhite,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: likedbutton({
                                      // "id": media,
                                      "song": snapshot.getAt(index)['song'],
                                      "artist": snapshot.getAt(index)['artist'],
                                      "image": snapshot.getAt(index)['image'],
                                      "link": snapshot.getAt(index)['link']
                                    }),
                                  )
                                  // Padding(
                                  //     padding: const EdgeInsets.only(right: 0),
                                  //     child: Icon(Icons.more_vert))
                                ],
                              )
                              //  Text(songList[index]['song'])
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          // child:
        ));
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
                  child: Text('Liked tracks',
                      style: TextStyle(
                          fontSize: 25,
                          color: white,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        )),
    // actions: [
    //   Padding(
    //     padding: const EdgeInsets.only(right: 30),
    //     child: IconButton(
    //         onPressed: () async {
    //           // AppOpenAdManager().showAdIfAvailable();
    //           // Get.to(infopage());
    //         },
    //         icon: Icon(FeatherIcons.info)),
    //   )
    // ],
  );
}
