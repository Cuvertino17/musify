import 'package:audio_service/audio_service.dart';
import 'package:downloader/audiohandler.dart';
import 'package:downloader/page_manager.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerSingleton<MyAudioHandler>(MyAudioHandler());
  getIt.registerLazySingleton<PageManager>(() => PageManager());
}
