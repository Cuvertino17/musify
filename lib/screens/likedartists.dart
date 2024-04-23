import 'package:downloader/artist.dart';
import 'package:downloader/constants.dart';
import 'package:downloader/helper/checker.dart';
import 'package:downloader/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class likedartist extends StatefulWidget {
  const likedartist({super.key});

  @override
  State<likedartist> createState() => _likedartistState();
}

class _likedartistState extends State<likedartist> {
// final _audioHandler = getIt<AudioHandler>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        // appBar: getAppBar(),
        body: ValueListenableBuilder(
          valueListenable: artistbox.listenable(),
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
                            'favourite artists',
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
                        // GestureDetector(
                        //   onTap: () {
                        //     // _audioHandler.stop();
                        //     // _audioHandler.customAction('name');
                        //     // _audioHandler.addQueueItems(
                        //     //     converttomedia(listdata['songs']));
                        //     // _audioHandler.play();
                        //     // Get.to(playerscreen());
                        //   },
                        //   child: CircleAvatar(
                        //     backgroundColor: Colors.red[900],
                        //     child: Icon(
                        //       Icons.play_arrow_rounded,
                        //       color: white,
                        //     ),
                        //   ),
                        // )

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
                                Color.fromARGB(255, 24, 15, 149),
                                // Colordata.data.dominantColor.color,

                                // Colordata.data!.dominantColor!.color,
                                black
                              ])),
                          child: Image.asset(
                            'assets/dance.png',
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
                    childCount: artistbox.length,
                    (context, index) {
                      // print(snapshot.getAt(index)['name']);
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => artistPage(
                                          artistToken:
                                              snapshot.getAt(index)['id'],
                                        )));
                            // _audioHandler.stop();
                            // _audioHandler.customAction('name');

                            // _audioHandler.addQueueItems(
                            //     converttomedia(snapshot.values as List));
                            // _audioHandler.skipToQueueItem(index);
                            // Get.to(playerscreen());
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
                                            snapshot.getAt(index)['name'],
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
                                            'Artist',
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
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Artistlikedbutton({
                                        'id': snapshot.getAt(index)['id'],
                                        'name': snapshot.getAt(index)['name'],
                                        'image': snapshot.getAt(index)['image']
                                      }))
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
