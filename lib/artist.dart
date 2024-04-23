import 'package:audio_service/audio_service.dart';
import 'package:downloader/api.dart';

import 'package:downloader/helper/checker.dart';
import 'package:downloader/helper/converttomediaiteam.dart';
import 'package:downloader/player.dart';

import 'package:downloader/screens/miniplayer.dart';
import 'package:downloader/service_locator.dart';
import 'package:downloader/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
// import 'package:google_fonts/google_fonts.dart';

class artistPage extends StatefulWidget {
  const artistPage({super.key, required this.artistToken});
  final String artistToken;

  @override
  State<artistPage> createState() => _artistPageState();
}

class _artistPageState extends State<artistPage> {
  final _audioHandler = getIt<AudioHandler>();

  var isloading = false.obs;
  var songdata;
  int len = 0;
  @override
  void initState() {
    isloading(true);
    getArtistSongs();

    super.initState();
  }

  getArtistSongs() async {
    songdata = await SaavnAPI().getartistSongs(widget.artistToken);

    len = songdata["songs"].length;

    if (songdata != null) {
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
                future: getcolorfromimage(songdata['image']),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> Colordata) {
                  // print(Colordata.data.dominantColor.color);
                  return Colordata.hasData == false
                      ? Center(child: CircularProgressIndicator())
                      : CustomScrollView(
                          slivers: <Widget>[
                            //2
                            SliverAppBar(
                              surfaceTintColor: black,
                              pinned: true,
                              backgroundColor: black,
                              expandedHeight: 360.0,
                              flexibleSpace: FlexibleSpaceBar(
                                centerTitle: true,
                                titlePadding: EdgeInsets.only(top: 10),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        '${songdata['name']}',
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
                                        _audioHandler.customAction('name');
                                        _audioHandler.addQueueItems(
                                            converttomedia(songdata['songs']));
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
                                        songdata['image'],
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                    // },

                                    ),
                              ),
                            ),

                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: len,
                                (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 30),
                                    child: GestureDetector(
                                      onTap: () {
                                        _audioHandler.customAction('name');

                                        _audioHandler.addQueueItems(
                                            converttomedia(songdata['songs']));
                                        _audioHandler.skipToQueueItem(index);
                                        Get.to(playerscreen());
                                      },
                                      child: Container(
                                          height: 60,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  songdata["songs"][index]
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
                                                        songdata["songs"][index]
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
                                                        songdata["songs"][index]
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
                                              likedbutton({
                                                // "id": media,
                                                "song": songdata["songs"][index]
                                                    ['song'],
                                                "artist": songdata["songs"]
                                                    [index]['artist'],
                                                "image": songdata["songs"]
                                                    [index]['image'],
                                                "link": songdata["songs"][index]
                                                    ['link']
                                              })
                                            ],
                                          )),
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
    // ;
  }
}
