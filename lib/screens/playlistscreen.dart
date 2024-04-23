import 'package:audio_service/audio_service.dart';
import 'package:downloader/api.dart';
import 'package:downloader/audiohandler.dart';
import 'package:downloader/download.dart';
import 'package:downloader/helper/checker.dart';
import 'package:downloader/helper/converttomediaiteam.dart';
import 'package:downloader/player.dart';
import 'package:downloader/screens/miniplayer.dart';
import 'package:downloader/service_locator.dart';
import 'package:downloader/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

class playlist extends StatefulWidget {
  const playlist({super.key, required this.listid});

  final String listid;

  @override
  State<playlist> createState() => _playlistState();
}

class _playlistState extends State<playlist> {
  final _audioHandler = getIt<AudioHandler>();
  // final _myaudioHandler = getIt<MyAudioHandler>();

  var isloading = false.obs;
  var listdata;
  int len = 0;
  @override
  void initState() {
    isloading(true);
    getPlaylistSongs();
    // TODO: implement initState
    super.initState();
  }

  getPlaylistSongs() async {
    listdata = await SaavnAPI().getplaylistSongs(widget.listid);
    // print('im here');
    len = listdata["songs"].length;
    // print(songdata["songs"].length);
    print(listdata);
    if (listdata != null) {
      isloading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: black,
        body: isloading == true
            ? Center(child: CircularProgressIndicator())
            : FutureBuilder<PaletteGenerator>(
                future: getcolorfromimage(listdata['image']),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> Colordata) {
                  // print(Colordata.data.dominantColor.color);
                  return Colordata.hasData == false
                      ? Center(child: CircularProgressIndicator())
                      : CustomScrollView(
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
                                        '${listdata['listname']}',
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
                                        // _audioHandler.stop();
                                        _audioHandler.customAction('name');
                                        _audioHandler.addQueueItems(
                                            converttomedia(listdata['songs']));
                                        _audioHandler.skipToQueueItem(0);

                                        // _audioHandler.play();
                                        Get.to(playerscreen());
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colordata
                                            .data!.dominantColor!.color,
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
                                      ).createShader(Rect.fromLTRB(0, -140,
                                          rect.width, rect.height - 20));
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
                                            Colordata
                                                .data!.dominantColor!.color,
                                            // Colordata.data.dominantColor.color,

                                            // Colordata.data!.dominantColor!.color,
                                            black
                                          ])),
                                      child: Image.network(
                                        listdata['image'],
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
                                childCount: len,
                                (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 30),
                                    child: GestureDetector(
                                      onTap: () {
                                        // _myaudioHandler.clearit();
                                        _audioHandler.stop();
                                        _audioHandler.customAction('name');
                                        // _audioHandler.queue.value.clear();
                                        // _audioHandler.customAction('');

                                        // converttomedia(listdata['songs']);
                                        _audioHandler.addQueueItems(
                                            converttomedia(listdata['songs']));
                                        _audioHandler.skipToQueueItem(index);
                                        Get.to(playerscreen());

                                        // _audioHandler.addQueueItem(MediaItem(
                                        //   id: listdata["songs"][index]['link'],
                                        //   title: listdata["songs"][index]['song'],
                                        //   artist: listdata["songs"][index]['artist'],
                                        //   artUri: Uri.parse(
                                        //       listdata["songs"][index]['image']),
                                        // ));
                                        // // SaavnAPI().getreco(songList[index]['id']);

                                        // playercontroller().play(
                                        //     name1: songdata["songs"][index]['song'],
                                        //     artist1: songdata["songs"][index]['artist'],
                                        //     image1: songdata["songs"][index]['image'],
                                        //     url: songdata["songs"][index]['link']);
                                      },
                                      child: Container(
                                          height: 60,
                                          // width: MediaQuery.of(context).size.width*9,
                                          // color: Colors.amberAccent,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  listdata["songs"][index]
                                                      ['image'],
                                                  height: 50,
                                                  width: 50,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 180,
                                                      child: Text(
                                                        listdata["songs"][index]
                                                            ['song'],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 180,
                                                      child: Text(
                                                        listdata["songs"][index]
                                                            ['artist'],
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: subwhite,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: likedbutton({
                                                  // "id": media,
                                                  "song": listdata["songs"]
                                                      [index]['song'],
                                                  "artist": listdata["songs"]
                                                      [index]['artist'],
                                                  "image": listdata["songs"]
                                                      [index]['image'],
                                                  "link": listdata["songs"]
                                                      [index]['link']
                                                }),
                                              )
                                              // Padding(
                                              //     padding:
                                              //         const EdgeInsets.only(
                                              //             right: 0),
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
                }),
        bottomNavigationBar: miniplayer(),
      ),
    );
  }
}
