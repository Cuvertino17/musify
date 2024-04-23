import 'package:audio_service/audio_service.dart';
import 'package:downloader/constants.dart';

converttomedia(List iteamlist) {
  var convertedlist = <MediaItem>[];

  for (var i = 0; i < iteamlist.length; i++) {
    convertedlist.add(MediaItem(
      id: iteamlist[i]['link'],
      title: iteamlist[i]['song'],
      artist: iteamlist[i]['artist'],
      artUri: Uri.parse(iteamlist[i]['image']),
    ));
  }

  return convertedlist;
}

addtolikedsongs(songdetail) {
  likedbox.add(songdetail);
}

addtorecentsongs(songdetail) {
  recentbox.add(songdetail);
}

removefromliked(searchValue) async {
  final box = likedbox;

  for (var i = 0; i < box.length; i++) {
    final value = box.getAt(i);
    print(value['link']);
    print('checking this $searchValue');

    if (value['link'] == searchValue) {
      await box.deleteAt(i);
      // return true;
    }
  }
}

likeartist(info) {
  artistbox.add(info);
}

unlikeartist(id) async {
  final box = artistbox;

  for (var i = 0; i < box.length; i++) {
    final value = box.getAt(i);
    print(value['id']);
    // print('checking this $searchValue');

    if (value['id'] == id) {
      await box.deleteAt(i);
      // return true;
    }
  }
}
