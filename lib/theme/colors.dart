import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:palette_generator/palette_generator.dart';

// const Color primary = Color(0xFF04be4e);
const Color primary = Color.fromARGB(255, 4, 100, 190);
const Color black = Color(0xFF131213);
const Color white = Color(0xFFFFFFFF);
const Color subwhite = Color.fromARGB(255, 201, 197, 197);
const Color grey = Color(0xFF5f5f5f);
const Color card = Color.fromARGB(255, 117, 67, 179);
const Color black2 = Color.fromARGB(255, 11, 8, 8);

Future<PaletteGenerator> getcolorfromimage(link) async {
  final paletteGenerator = await PaletteGenerator.fromImageProvider(
      // Image.network(link).image,
      NetworkImage('$link')
      // maximumColorCount: 20,
      );

  print('bro im here ${paletteGenerator.dominantColor!.color}');

  // Return the dominant color
  return paletteGenerator;
}
