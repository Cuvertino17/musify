import 'package:audio_service/audio_service.dart';
import 'package:downloader/card.dart';
import 'package:downloader/constants.dart';
import 'package:downloader/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class likedrecents extends StatelessWidget {
  likedrecents({super.key});

  final _audioHandler = getIt<AudioHandler>();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 25, bottom: 10),
        child: Text(
          'Liked Recently ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: 60 * 3,
        child: PageView.builder(
          padEnds: false,
          controller: PageController(),
          itemCount: (6).ceil(),
          itemBuilder: (p0, p1) {
            return ValueListenableBuilder(
                valueListenable: likedbox.listenable(),
                builder: (context, value, Widget) {
                  var Rvdvalues = value.values.toList().reversed.toList();

                  if (value.isEmpty) {
                    return emptyscreen('no tracks added yet', ':)');
                  }
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _audioHandler.addQueueItem(MediaItem(
                            id: Rvdvalues[0]['link'],
                            title: Rvdvalues[0]['song'],
                            artist: Rvdvalues[0]['artist'],
                            artUri: Uri.parse(Rvdvalues[0]['image']),
                          ));
                        },
                        child: Boxcard2(
                            Rvdvalues[0]['image'], Rvdvalues[0]['song']),
                      ),
                      GestureDetector(
                        onTap: () {
                          _audioHandler.addQueueItem(MediaItem(
                            id: Rvdvalues[1]['link'],
                            title: Rvdvalues[1]['song'],
                            artist: Rvdvalues[1]['artist'],
                            artUri: Uri.parse(Rvdvalues[1]['image']),
                          ));
                        },
                        child: Boxcard2(
                            Rvdvalues[1]['image'], Rvdvalues[1]['song']),
                      ),
                      GestureDetector(
                        onTap: () {
                          _audioHandler.addQueueItem(MediaItem(
                            id: Rvdvalues[2]['link'],
                            title: Rvdvalues[2]['song'],
                            artist: Rvdvalues[2]['artist'],
                            artUri: Uri.parse(Rvdvalues[2]['image']),
                          ));
                        },
                        child: Boxcard2(
                            Rvdvalues[2]['image'], Rvdvalues[2]['song']),
                      ),
                      GestureDetector(
                        onTap: () {
                          _audioHandler.addQueueItem(MediaItem(
                            id: Rvdvalues[3]['link'],
                            title: Rvdvalues[3]['song'],
                            artist: Rvdvalues[3]['artist'],
                            artUri: Uri.parse(Rvdvalues[3]['image']),
                          ));
                        },
                        child: Boxcard2(
                            Rvdvalues[3]['image'], Rvdvalues[3]['song']),
                      ),
                      GestureDetector(
                        onTap: () {
                          _audioHandler.addQueueItem(MediaItem(
                            id: Rvdvalues[4]['link'],
                            title: Rvdvalues[4]['song'],
                            artist: Rvdvalues[4]['artist'],
                            artUri: Uri.parse(Rvdvalues[4]['image']),
                          ));
                        },
                        child: Boxcard2(
                            Rvdvalues[4]['image'], Rvdvalues[4]['song']),
                      ),
                    ],
                  );
                });
          },
        ),
      )
    ]);
    ;
  }
}
