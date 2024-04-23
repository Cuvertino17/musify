import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_des/dart_des.dart';

import 'package:downloader/service_locator.dart';

import 'package:audio_service/audio_service.dart';

class formet {
  List songlist = [];
  List songlist2 = [];
  List artistlist = [];
  List play_list = [];
  List play_list_songs = [];

  final _audioHandler = getIt<AudioHandler>();

  // Map<String, dynamic> artistDataPage = {};

  String decode(String input) {
    const String key = '38346591';
    final DES desECB = DES(key: key.codeUnits);

    final Uint8List encrypted = base64.decode(input);
    final List<int> decrypted = desECB.decrypt(encrypted);
    final String decoded = utf8
        .decode(decrypted)
        .replaceAll(RegExp(r'\.mp4.*'), '.mp4')
        .replaceAll(RegExp(r'\.m4a.*'), '.m4a')
        .replaceAll(RegExp(r'\.mp3.*'), '.mp3');

    return decoded.replaceAll('http:', 'https:');
  }

  String formatImage(String image) {
    String result = '';
    if (image.contains("150x150")) {
      result = image.replaceAll("150x150", "500x500");
    } else {
      result = image.replaceAll("50x50", "500x500");
    }
    // print(result);
    return result;
  }

  FormetList(res) {
    songlist.clear();
    for (var i = 0; i < res['results'].length; i++) {
      songlist.add({
        'id': res['results'][i]['id'],
        "song": res['results'][i]['song'],
        "artist": res['results'][i]['singers'],
        "image": formatImage(
          res['results'][i]['image'],
        ),
        "link": decode(res['results'][i]['encrypted_media_url'])
      });
    }
    return songlist;
  }

  formetArtistList(res) {
    // print(res['results']);
    artistlist.clear();
    for (var i = 0; i < res['results'].length; i++) {
      artistlist.add({
        'artist_name': res['results'][i]['name'],
        'role': res['results'][i]['role'],
        'image': formatImage(res['results'][i]['image']),
        'artist_token':
            res['results'][i]['perma_url'].toString().split('/').last
      });
    }
    return artistlist;
    // print(artistlist);
  }

  formetArtistSongs(res) {
    var artistDataPage = {
      'name': res['name'],
      'image': formatImage(res['image']),
      'songs': formetsongsforartistpage(res['topSongs']['songs'] as List)
    };

    return (artistDataPage);
  }

  formetsongsforartistpage(List res) {
    // print('this is res $res');
    songlist2.clear();
    for (var i = 0; i < res.length; i++) {
      songlist2.add({
        "song": res[i]['song'],
        "artist": res[i]['singers'],
        "image": formatImage(res[i]['image']),
        "link": decode(res[i]['encrypted_media_url'])
      });
    }

    return songlist2;
  }

  formetrecolist({res}) {
    var recolist = <MediaItem>[];
    // final audioHandler = AudioServiceSingleton().audioHandler;

    for (var i = 0; i < res.length; i++) {
      recolist.add(MediaItem(
          id: decode(res[i]['more_info']['encrypted_media_url']),
          title: res[i]['title'],
          artist: res[i]['subtitle'],
          artUri: Uri.parse(formatImage(res[i]['image']))));

      // myAudioHandler()?.playlist.add({
      //   "id": res[i]['id'],
      //   "name": res[i]['title'],
      //   "artist": res[i]['subtitle'],
      //   "image": formatImage(res[i]['image']),
      //   "url": decode(res[i]['more_info']['encrypted_media_url'])
      // });
    }
    _audioHandler.addQueueItems(recolist);
  }

  formetPlaylist(res) {
    play_list.clear();
    for (var i = 0; i < res['results'].length; i++) {
      print(' id is here ${res['results'][i]['id']}');
      play_list.add({
        'id': res['results'][i]['listid'],
        'title': res['results'][i]['listname'],
        'image': formatImage(res['results'][i]['image']),
        'count': res['results'][i]['count'],
      });
    }
    return play_list;
  }

  formetPlaylistSongs(res) {
    var playlistdata = {
      'listname': res['title'],
      'count': res['list_count'],
      'image': formatImage(res['image']),
      'songs': formetSongsForPlaylist(res['list'] as List)
    };
    return playlistdata;
  }

  formetSongsForPlaylist(List res) {
    play_list_songs.clear();
    for (var i = 0; i < res.length; i++) {
      play_list_songs.add({
        "id": res[i]['id'],
        "song": res[i]['title'],
        "artist": res[i]['subtitle'],
        "image": formatImage(res[i]['image']),
        "link": decode(res[i]['more_info']['encrypted_media_url'])
      });
    }
    return play_list_songs;
  }
}
