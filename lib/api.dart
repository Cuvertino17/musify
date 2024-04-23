/*
 *  This file is part of BlackHole (https://github.com/Sangwan5688/BlackHole).
 * 
 * BlackHole is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * BlackHole is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with BlackHole.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2021-2023, Ankit Sangwan
 */

import 'dart:convert';
import 'dart:typed_data';
import 'package:dart_des/dart_des.dart';
import 'package:downloader/formet.dart';
import 'package:get/get.dart';

// import 'package:blackhole/Helpers/format.dart';
// import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class SaavnAPI {
  // List preferredLanguages = Hive.box('settings')
  // .get('preferredLanguage', defaultValue: ['english']) as List;
  Map<String, String> headers = {};
  RxBool isloading = false.obs;
  String baseUrl = 'www.jiosaavn.com';
  String apiStr = '/api.php?_format=json&_marker=0&api_version=4&ctx=web6dot0';
  // Box settingsBox = Hive.box('settings');
  Map<String, String> endpoints = {
    'homeData': '__call=webapi.getLaunchData',
    'topSearches': '__call=content.getTopSearches',
    'fromToken': '__call=webapi.get',
    'featuredRadio': '__call=webradio.createFeaturedStation',
    'artistRadio': '__call=webradio.createArtistStation',
    'entityRadio': '__call=webradio.createEntityStation',
    'radioSongs': '__call=webradio.getSong',
    'songDetails': '__call=song.getDetails',
    'playlistDetails': '__call=playlist.getDetails',
    'albumDetails': '__call=content.getAlbumDetails',
    'getResults': '__call=search.getResults',
    'albumResults': '__call=search.getAlbumResults',
    'artistResults': '__call=search.getArtistResults',
    'playlistResults': '__call=search.getPlaylistResults',
    'getReco': '__call=reco.getreco',
    'getAlbumReco': '__call=reco.getAlbumReco', // still not used
    'artistOtherTopSongs':
        '__call=search.artistOtherTopSongs', // still not used
  };

  getsongs(String query) async {
    isloading(true);
    var res = await http.get(Uri.parse(
        'https://www.jiosaavn.com/api.php?_format=json&p=1&q=$query&n=10&__call=search.getResults'));
    final songlist = json.decode(res.body);
    // return
    isloading(false);
    return formet().FormetList(songlist);

    // print(songlist['results']);
  }

  getreco(id) async {
    var res = await http.get(Uri.parse(
        'https://www.jiosaavn.com/api.php?_format=json&_marker=0&api_version=4&ctx=web6dot0&json&__call=reco.getreco&pid=$id'));
    final recolist = json.decode(res.body);
    formet().formetrecolist(res: recolist);
  }

  getartist(String query) async {
    var res2 = await http.get(Uri.parse(
        'https://www.jiosaavn.com/api.php?_format=json&p=1&q=$query&n=2&__call=search.getArtistResults'));
    final artistlist = json.decode(res2.body);

    return formet().formetArtistList(artistlist);
  }

  getartistSongs(token) async {
    print('hello');
    var res3 = await http.get(Uri.parse(
        'https://www.jiosaavn.com/api.php?_format=json&__call=webapi.get&type=artist&p=&n_song=50&n_album=50&includeMetaTags=0&token=$token'));
    final artistPageData = json.decode(res3.body);

    print('hello2');

    return formet().formetArtistSongs(artistPageData);
  }

  getplaylist(query) async {
    var res2 = await http.get(Uri.parse(
        'https://www.jiosaavn.com/api.php?_format=json&p=1&q=$query&n=10&__call=search.getPlaylistResults'));
    final playlists = json.decode(res2.body);

    return formet().formetPlaylist(playlists);
  }

  getplaylistSongs(listid) async {
    var res3 = await http.get(Uri.parse(
        'https://www.jiosaavn.com/api.php?_format=json&_marker=0&api_version=4&ctx=web6dot0&json&__call=playlist.getDetails&listid=$listid'));
    final PlaylistData = json.decode(res3.body);

    return formet().formetPlaylistSongs(PlaylistData);
  }
}
