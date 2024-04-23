import 'dart:async';

import 'package:audio_service/audio_service.dart';

import 'package:downloader/helper/checker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:just_audio/just_audio.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
        // androidNotificationIcon: 'mipmap-hdpi/ic_launcher',
        androidNotificationChannelId: 'com.foretech.musify.audio',
        androidNotificationChannelName: 'Musify',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
        notificationColor: Color.fromARGB(255, 33, 33, 34)),
  );
}

class MyAudioHandler extends BaseAudioHandler {
  var playlist = ConcatenatingAudioSource(children: []);
  // var playlist = [];

  var currentindex = 0;
  var playstate = '/stopped'.obs;
  var isplaying = false.obs;
  var isloaded = false.obs;
  final _player = AudioPlayer();
  final boolController = StreamController<bool>.broadcast();
  var isloopmode = false.obs;
  var pos = 0.0.obs;

  MyAudioHandler() {
    // _loadEmptyPlaylist();
    _notifyAudioHandlerAboutPlaybackEvents();
    // listenForStateChanges();
    listenToPlayerState();
    _loadEmptyPlaylist();
    _listenForDurationChanges();
    _positionstream();
    // _listenForCurrentSongIndexChanges();
    // _listenForSequenceStateChanges();
  }

  Future<void> _loadEmptyPlaylist() async {
    try {
      await _player.setAudioSource(playlist);
    } catch (e) {
      print("Error: $e");
    }
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    _player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
          LoopMode.all: AudioServiceRepeatMode.all,
        }[_player.loopMode]!,
        shuffleMode: (_player.shuffleModeEnabled)
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: event.currentIndex,

        // queueIndex: 0,
      ));
    });
  }

  // void _addcurrentmediaiteam(newmediaitem) {
  //   mediaItem.add(newmediaitem);
  //   // position
  // }

  // void listenForStateChanges() {
  //   _player.playerStateStream.listen((event) {
  //     if (event.processingState == ProcessingState.completed) {
  //       skipToNext();
  //       // The audio playback has completed
  //       print("Audio playback completed!");
  //     } else if (event.processingState == ProcessingState.idle) {
  //       isloaded(true);
  //       playstate('idle');
  //     }
  //   });
  // }

  listenToPlayerState() {
    return _player.playingStream;
  }

  clearit() {
    print('logging here');
    playlist.children.clear();
    print(playlist.children.length);
  }
// this song >>>>

  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) {
      var index = _player.currentIndex;
      final newQueue = queue.value;
      if (index == null || newQueue.isEmpty) return;
      if (_player.shuffleModeEnabled) {
        index = _player.shuffleIndices!.indexOf(index);
      }
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
      recentSongs({
        "song": newMediaItem.title.toString(),
        "artist": newMediaItem.artist.toString(),
        "image": newMediaItem.artUri.toString(),
        "link": newMediaItem.id.toString()
      });
    });
  }

  _positionstream() {
    _player.positionStream.listen((p) {
      pos(p.inSeconds.toDouble());
    });
  }

  // playhandler() {
  //   isloaded(true);

  //   // _player.setUrl(playlist[currentindex].id);
  //   _addcurrentmediaiteam(playlist[currentindex]);
  //   play();
  // }

  @override
  Future<void> play() => _player.play();
  @override
  Future<void> stop() {
    _player.stop();
    playlist.clear();
    // TODO: implement stop
    return super.stop();
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        _player.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        _player.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.group:
      case AudioServiceRepeatMode.all:
        _player.setLoopMode(LoopMode.all);
        break;
    }
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // manage Just Audio
    final audioSource = mediaItems.map(_createAudioSource);
    playlist.addAll(audioSource.toList());

    // notify system
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
    // print(playlist.children[0]);
    // print('here is queue $queue');
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    playlist.clear();
    queue.value.clear();
    // manage Just Audio
    final audioSource = _createAudioSource(mediaItem);
    playlist.add(audioSource);

    // notify system
    final newQueue = queue.value..add(mediaItem);
    queue.add(newQueue);
  }

  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(
      Uri.parse(mediaItem.id as String),
      tag: mediaItem,
    );
  }

  @override
  Future<void> removeQueueItemAt(int index) async {
    // manage Just Audio
    playlist.removeAt(index);

    // notify system
    final newQueue = queue.value..removeAt(index);
    queue.add(newQueue);
  }

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {
    print('logging from custom action');
    playlist.clear();
    queue.value.clear();
  }

  @override
  Future<void> skipToQueueItem(int index) {
    _player.seek(null, index: index);
    play();

    return super.skipToQueueItem(index);
  }

  @override
  Future<void> pause() {
    _player.pause();

    return super.pause();
  }

  @override
  Future<void> skipToNext() {
    isloaded(false);
    _player.seekToNext();

    return super.skipToNext();
  }

  @override
  Future<void> skipToPrevious() {
    isloaded(false);
    _player.seekToPrevious();

    return super.skipToPrevious();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);
}
