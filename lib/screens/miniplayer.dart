import 'package:downloader/audiohandler.dart';
import 'package:downloader/player.dart';
import 'package:downloader/screens/recent.dart';
import 'package:downloader/service_locator.dart';
import 'package:downloader/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';

final _audioHandler = getIt<AudioHandler>();

Widget miniplayer() {
  return StreamBuilder<List<MediaItem>>(
      stream: _audioHandler.queue,
      builder: (context, q) {
        // ignore: unnecessary_null_comparison
        return q.data!.isEmpty
            ? Container(
                height: 1,
              )
            : StreamBuilder<PlaybackState>(
                stream: _audioHandler.playbackState,
                builder: (context, snapshot) {
                  print('mini here ${snapshot.data?.processingState}');
                  return snapshot.hasData && snapshot.data != null
                      ? FutureBuilder<PaletteGenerator>(
                          future: getcolorfromimage(_audioHandler
                                  .mediaItem.value?.artUri ??
                              'https://i.ytimg.com/vi/9sNQFJAb3Ss/maxresdefault.jpg'),
                          builder: (BuildContext context,
                              AsyncSnapshot<PaletteGenerator> Colordata) {
                            return Colordata.hasData == false
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: white,
                                  ))
                                : Material(
                                    color: Colors.transparent,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(playerscreen());
                                      },
                                      onPanUpdate: (details) {
                                        if (details.delta.dx <= -5) {
                                          _audioHandler.skipToNext();

                                          // print('dragging right');
                                        } else if (details.delta.dx >= 5) {
                                          // print('dragging left');
                                          _audioHandler.skipToPrevious();
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        padding: EdgeInsets.only(left: 5),
                                        decoration: BoxDecoration(
                                            color: Colordata
                                                .data!.dominantColor!.color,
                                            // gradient: LinearGradient(
                                            //     begin: Alignment.centerLeft,
                                            //     end: Alignment.centerRight,
                                            //     colors: [
                                            //       Colordata.data!.dominantColor!
                                            //           .color,
                                            //       Colordata.data!
                                            //           .darkMutedColor!.color,
                                            //       // Colors.redAccent,

                                            //       // Color.fromARGB(
                                            //       // 255, 12, 12, 12)
                                            //     ]),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        height: 60,
                                        // width: 360,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Hero(
                                              tag: 'tag01',
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Image.network(
                                                  '${_audioHandler.mediaItem.value?.artUri}',
                                                  fit: BoxFit.cover,
                                                  height: 50,
                                                  width: 50,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, top: 10),
                                              child: Column(children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    '${_audioHandler.mediaItem.value?.title}',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    '${_audioHandler.mediaItem.value?.artist}',
                                                    style: TextStyle(
                                                        // fontSize: 15,
                                                        color: white

                                                        // fontWeight: FontWeight.bold
                                                        ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                )
                                              ]),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  // playercontroller().player
                                                  if (_audioHandler
                                                          .playbackState
                                                          .value
                                                          .playing ==
                                                      true) {
                                                    _audioHandler.pause();
                                                  } else {
                                                    _audioHandler.play();
                                                  }
                                                  // setState(() {});
                                                },
                                                icon: _audioHandler
                                                            .playbackState
                                                            .value
                                                            .playing ==
                                                        true
                                                    ? Icon(
                                                        Icons.pause,
                                                        size: 30,
                                                        // color: white,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .play_arrow_rounded,
                                                        size: 30,
                                                        // color: white,
                                                      )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: IconButton(
                                                  onPressed: () {
                                                    _audioHandler.skipToNext();
                                                  },
                                                  icon: Icon(
                                                      Icons.skip_next_rounded)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                          })
                      : Container(
                          height: 1,
                        );
                });
      });
}
