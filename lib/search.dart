import 'package:downloader/adhelper.dart';
import 'package:downloader/artist.dart';
import 'package:downloader/audiohandler.dart';
import 'package:downloader/constants.dart';
import 'package:downloader/download.dart';
import 'package:downloader/helper/checker.dart';

import 'package:downloader/player.dart';

import 'package:downloader/screens/playlistscreen.dart';
import 'package:downloader/service_locator.dart';
import 'package:downloader/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:downloader/api.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:downloader/audiohandler.dart';

import 'package:audio_service/audio_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  var myContr = Get.put(MyadController());
  var myContr2 = Get.put(MyadControlleraftersearch());

  // hintstyle = AnimatedTextKit(animatedTexts: animatedTexts)
  // final audioHandler = AudioServiceSingleton().audioHandler;
  var searched = false;
  var isSearching = false;
  final _audioHandler = getIt<AudioHandler>();
  final myController = TextEditingController();
  List songList = [];
  List artistlist = [];
  List play_list = [];

  getSonglist(query) async {
    setState(() {
      isSearching = true;
    });
    songList.clear();
    songList = await SaavnAPI().getsongs('$query');
    setState(() {
      isSearching = false;
      searched = true;
    });

    // print(songList);
  }

  getArtistlist(query) async {
    artistlist.clear();
    artistlist = await SaavnAPI().getartist('$query');
    setState(() {});

    print(artistlist);
  }

  getplaylist(query) async {
    play_list.clear();
    play_list = await SaavnAPI().getplaylist('$query');
    setState(() {});
  }

  @override
  void initState() {
    myContr.loadAd();
    myContr2.loadAd();

    searched = false;
    downloadManager().checkpermissionnotif();
    downloadManager().checkPermission();
    // AppOpenAdmanager().showAd();
    // rewardedInterstitialAd().loadAd();

    // AppOpenAdManager().showAdIfAvailable();
    // showad().loadAd();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(148),
          child: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextField(
                        controller: myController,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.search,
                        cursorColor: Color.fromARGB(255, 255, 255, 255),
                        onSubmitted: (value) async {
                          getSonglist(value);
                          getArtistlist(value);
                          getplaylist(value);

                          print("Search triggered with value: $value");
                          myController.clear();
                          // Handle the search logic here
                        },
                        style: TextStyle(
                            // fontSize: 18,
                            color: white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'circular'),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          suffixIcon: Icon(
                            FeatherIcons.search,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          hintText: 'Search Your Song',
                          fillColor: const Color.fromARGB(255, 39, 39, 38),
                          hintStyle: GoogleFonts.openSans(
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TabBar(
                      indicatorWeight: 1,
                      labelPadding: EdgeInsets.only(bottom: 5),
                      // indicatorPadding: EdgeInsets.only(bottom: 5),
                      // padding: EdgeInsets.only(bottom: 5),
                      indicatorColor: Colors.greenAccent,
                      labelColor: Colors.amber,
                      dividerColor: black,
                      tabs: [
                        Text(
                          'Songs',
                          style: TextStyle(
                              fontSize: 18,
                              color: white,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'circular'),
                        ),
                        Text(
                          'Artist',
                          style: TextStyle(
                              fontSize: 18,
                              color: white,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'circular'),
                        ),
                        Text(
                          'Playlist',
                          style: TextStyle(
                              fontSize: 18,
                              color: white,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'circular'),
                        )
                      ]),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
            elevation: 0,
          ),
        ),
        body: TabBarView(children: [
          isSearching
              ? Center(child: CircularProgressIndicator())
              : searched == false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        emptyscreen('what you want to listen', ':)'),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(() => Container(
                              alignment: Alignment.center,
                              // width: MediaQuery.of(context).size.width * 0.9,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: myContr.isAdLoaded.value
                                  ? ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxHeight: 200,
                                        minHeight: 100,
                                      ),
                                      child: AdWidget(ad: myContr.nativeAd!))
                                  : const SizedBox(),
                            )),
                      ],
                    )
                  : songList.length <= 0
                      ? emptyscreen('no match found', ':(')
                      : ListView.separated(
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: songList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 30, right: 25),
                              child: InkWell(
                                onTap: () async {
                                  _audioHandler.addQueueItem(MediaItem(
                                    id: songList[index]['link'],
                                    title: songList[index]['song'],
                                    artist: songList[index]['artist'],
                                    artUri: Uri.parse(songList[index]['image']),
                                  ));
                                  SaavnAPI().getreco(songList[index]['id']);

                                  _audioHandler.play();

                                  Get.to(playerscreen());
                                },
                                child: Container(
                                    padding: EdgeInsets.only(right: 20),
                                    alignment: Alignment.center,
                                    height: 60,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: FadeInImage.assetNetwork(
                                              height: 50,
                                              width: 50,
                                              placeholder: 'assets/music.png',
                                              image: songList[index]['image'],
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 170,
                                                child: Text(
                                                  songList[index]['song'],
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: white,
                                                    // fontWeight: FontWeight.w500
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 170,
                                                child: Text(
                                                  songList[index]['artist'],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: subwhite,
                                                    // fontWeight: FontWeight.bold
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                            "song": songList[index]['song'],
                                            "artist": songList[index]['artist'],
                                            "image": songList[index]['image'],
                                            "link": songList[index]['link']
                                          }),
                                        ),
                                        // IconButton(
                                        //     onPressed: () {},
                                        //     icon:
                                        //         Icon(FeatherIcons.moreVertical))
                                        // Padding(
                                        //   padding: const EdgeInsets.only(right: 20),
                                        //   child: GestureDetector(
                                        //     onTap: () {
                                        //       downloadManager().download(
                                        //           songList[index]['song'],
                                        //           songList[index]['link']);
                                        //     },
                                        //     child: Container(
                                        //       decoration: BoxDecoration(
                                        //         borderRadius: BorderRadius.circular(4),
                                        //         color: Colors.purple[900],
                                        //       ),
                                        //       child: Padding(
                                        //         padding: const EdgeInsets.all(12.0),
                                        //         child: Icon(
                                        //           FeatherIcons.download,
                                        //           size: 24,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    )),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            if (index == 4) {
                              return Obx(() => Container(
                                    alignment: Alignment.center,
                                    // width: MediaQuery.of(context).size.width * 0.9,
                                    padding:
                                        EdgeInsets.only(left: 25, right: 25),
                                    child: myContr.isAdLoaded.value
                                        ? ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              maxHeight: 100,
                                              minHeight: 100,
                                            ),
                                            child:
                                                AdWidget(ad: myContr.nativeAd!))
                                        : const SizedBox(),
                                  ));
                            }
                            return SizedBox(
                              height: 1,
                            );
                          },
                        ),
          isSearching
              ? Center(child: CircularProgressIndicator())
              : searched == false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        emptyscreen('who do you want to listen', ':)'),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(() => Container(
                              alignment: Alignment.center,
                              // width: MediaQuery.of(context).size.width * 0.9,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: myContr.isAdLoaded.value
                                  ? ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxHeight: 200,
                                        minHeight: 100,
                                      ),
                                      child: AdWidget(ad: myContr.nativeAd!))
                                  : const SizedBox(),
                            )),
                      ],
                    )
                  : artistlist.length <= 0
                      ? emptyscreen('no artist found', ':(')
                      : Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                // scrollDirection: Axis.horizontal,
                                // shrinkWrap: true,
                                itemCount: artistlist.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(artistPage(
                                        artistToken: artistlist[index]
                                            ['artist_token'],
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 25),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                              height: 60,
                                              width: 60,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'assets/user.png',
                                                  image: artistlist[index]
                                                      ['image'],
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 180,
                                                  child: Text(
                                                    artistlist[index]
                                                        ['artist_name'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    artistlist[index]['role'],
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: subwhite,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Artistlikedbutton({
                                            'id': artistlist[index]
                                                ['artist_token'],
                                            'name': artistlist[index]
                                                ['artist_name'],
                                            'image': artistlist[index]['image']
                                          })
                                          // Icon(
                                          //   FeatherIcons.chevronRight,
                                          //   size: 40,
                                          // )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
          isSearching
              ? Center(child: CircularProgressIndicator())
              : searched == false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        emptyscreen('any playlist?', ':)'),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(() => Container(
                              alignment: Alignment.center,
                              // width: MediaQuery.of(context).size.width * 0.9,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: myContr.isAdLoaded.value
                                  ? ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxHeight: 200,
                                        minHeight: 100,
                                      ),
                                      child: AdWidget(ad: myContr.nativeAd!))
                                  : const SizedBox(),
                            )),
                      ],
                    )
                  : play_list.length <= 0
                      ? emptyscreen('no playlist found', ':(')
                      : ListView.builder(
                          itemCount: play_list.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(
                                    playlist(listid: play_list[index]['id']));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 25),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        height: 60,
                                        width: 60,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: 'assets/album.png',
                                            image: play_list[index]['image'],
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 180,
                                            child: Text(
                                              play_list[index]['title'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: white,
                                                  fontWeight: FontWeight.w500),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              'Songs · ${play_list[index]['count']}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: subwhite,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
        ]),
      ),
    );
  }
}

PreferredSizeWidget getAppBar() {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    elevation: 0,
    // centerTitle: true,
    title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   child: Icon(FeatherIcons.user),
                // ),
                // Padding(
                // padding: const EdgeInsets.all(15.0),
                // child:
                InkWell(
                  onTap: () {
                    Get.to(playerscreen());
                    // final boxy = Hive.box('recoList');
                    // print(boxy.getAt(2));
                  },
                  child: Text('Search',
                      style: GoogleFonts.openSans(
                          fontSize: 25,
                          color: white,
                          fontWeight: FontWeight.bold)),
                ),
                // ),
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

// Widget homeBody() {
//   return SingleChildScrollView(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Text(
//                 'Trending',
//                 style: TextStyle(
//                     fontSize: 25, color: white, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Container(
//               height: 205,
//               // width: 65,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 5,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 20, left: 20),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 150,
//                           width: 150,
//                           child: Image.asset(
//                             'assets/emi.jpg',
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Text('Song',
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   color: white,
//                                   fontWeight: FontWeight.w500)),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Text(
//                 'Top Artist',
//                 style: TextStyle(
//                     fontSize: 25, color: white, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Container(
//               height: 205,
//               // width: 65,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 9,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 20, left: 20),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 150,
//                           width: 150,
//                           child: Image.asset(
//                             'assets/emi.jpg',
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Text('Song',
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   color: white,
//                                   fontWeight: FontWeight.w500)),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Text(
//                 'New Releases',
//                 style: TextStyle(
//                     fontSize: 25, color: white, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Container(
//               height: 205,
//               // width: 65,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 9,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 20, left: 20),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 150,
//                           width: 150,
//                           child: Image.asset(
//                             'assets/emi.jpg',
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Text('Song',
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   color: white,
//                                   fontWeight: FontWeight.w500)),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         )
//       ],
//     ),
//   );
// }
