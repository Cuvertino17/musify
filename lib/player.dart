import 'package:downloader/adhelper.dart';
import 'package:downloader/download.dart';
import 'package:downloader/helper/checker.dart';
import 'package:downloader/page_manager.dart';
import 'package:downloader/progressbar.dart';
import 'package:downloader/repeat_button.dart';
import 'package:downloader/service_locator.dart';
import 'package:downloader/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:palette_generator/palette_generator.dart';

class playerscreen extends StatefulWidget {
  const playerscreen({super.key});

  @override
  State<playerscreen> createState() => _playerscreenState();
}

class _playerscreenState extends State<playerscreen> {
  final _audioHandler = getIt<AudioHandler>();
  var myContr = interstitalad();
  final pageManager = getIt<PageManager>();

  var isloopmode = false;

  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
    myContr.loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Hero(
          tag: 'tag01',
          child: IconButton(
            onPressed: () => navigator!.pop(),
            icon: Icon(Icons.keyboard_arrow_down_rounded),
            iconSize: 30,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Now Playing',
            style: TextStyle(
                fontSize: 18, color: white, fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder<PlaybackState>(
          stream: _audioHandler.playbackState,
          builder: (context, snapshot) {
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
                          : Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colordata.data!.dominantColor!.color,
                                    Colors.black
                                  ])),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.75,
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.network(
                                          '${_audioHandler.mediaItem.value?.artUri}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.63,
                                          child: Text(
                                            '${_audioHandler.mediaItem.value?.title}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        likedbutton({
                                          // "id": media,
                                          "song":
                                              '${_audioHandler.mediaItem.value?.title}',
                                          "artist":
                                              '${_audioHandler.mediaItem.value?.artist}',
                                          "image":
                                              '${_audioHandler.mediaItem.value?.artUri}',
                                          "link":
                                              '${_audioHandler.mediaItem.value?.id}'
                                        })
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    child: Text(
                                      '${_audioHandler.mediaItem.value!.artist}',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 200, 195, 195),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 45, right: 45, top: 30),
                                    child: AudioProgressBar(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RepeatButton(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  _audioHandler
                                                      .skipToPrevious();
                                                },
                                                icon: Icon(
                                                  Icons.skip_previous_rounded,
                                                  size: 45,
                                                  color: white,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (_audioHandler
                                                          .playbackState
                                                          .value
                                                          .playing ==
                                                      true) {
                                                    _audioHandler.pause();
                                                  } else {
                                                    _audioHandler.play();
                                                  }
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: white,
                                                  radius: 27,
                                                  child: _audioHandler
                                                              .playbackState
                                                              .value
                                                              .playing ==
                                                          true
                                                      ? Icon(
                                                          Icons.pause,
                                                          size: 30,
                                                          color: black,
                                                        )
                                                      : Icon(
                                                          Icons.play_arrow,
                                                          size: 30,
                                                          color: black,
                                                        ),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    _audioHandler.skipToNext();
                                                  },
                                                  icon: Icon(
                                                    Icons.skip_next_rounded,
                                                    size: 45,
                                                    color: white,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            myContr.interstitialAd!.show();
                                            myContr.loadAd();

                                            downloadManager().download(
                                                '${_audioHandler.mediaItem.value!.title}',
                                                '${_audioHandler.mediaItem.value!.id}');
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            // color: Colors.amber,
                                            child: Icon(
                                              FeatherIcons.download,
                                              color: white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                    })
                : Center(
                    child: CircularProgressIndicator(
                    color: Colors.amber,
                  ));
          }),
      bottomNavigationBar: DraggableScrollableSheet(
          initialChildSize: 0.09,
          minChildSize: 0.09,
          maxChildSize: 0.65,
          builder: (context, scontroller) {
            return ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.black12.withOpacity(0.3),
                // height: 600,
                child: StreamBuilder<List<MediaItem>>(
                    stream: _audioHandler.queue,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          height: 1,
                        );
                      }

                      return Column(
                        children: [
                          Container(
                            height: 4,
                            width: 20,
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Expanded(
                            child: ListView.builder(
                                controller: scontroller,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.transparent),
                                    child: GestureDetector(
                                      onTap: () {
                                        snapshot.data![index].artUri;
                                        _audioHandler.skipToQueueItem(index);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Container(
                                          child: ListTile(
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image(
                                                  height: 50,
                                                  width: 50,
                                                  image: NetworkImage(
                                                      '${snapshot.data![index].artUri}')),
                                            ),
                                            title: SizedBox(
                                              width: 200,
                                              child: Text(
                                                snapshot.data![index].title,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            subtitle: SizedBox(
                                              width: 200,
                                              child: Text(
                                                snapshot.data![index].artist ??
                                                    '',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            trailing: _audioHandler
                                                        .mediaItem.value?.id ==
                                                    snapshot.data![index].id
                                                ? Icon(
                                                    Icons.music_note_rounded,
                                                    color: Colors.green,
                                                  )
                                                : Icon(FeatherIcons.feather),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    }),
              ),
            );
          }),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          timeLabelPadding: 10,
          progressBarColor: Colors.white,
          barHeight: 5.0,
          thumbRadius: 5,
          thumbColor: white,
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: pageManager.seek,
        );
      },
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = const Icon(
              Icons.repeat_rounded,
              color: white,
              size: 29,
            );
            break;
          case RepeatState.repeatSong:
            icon = const Icon(
              Icons.repeat_one_rounded,
              color: Colors.greenAccent,
              size: 32,
            );
            break;
          case RepeatState.repeatPlaylist:
            icon = const Icon(
              Icons.repeat_rounded,
              color: Colors.greenAccent,
              size: 32,
            );
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: pageManager.repeat,
        );
      },
    );
  }
}
