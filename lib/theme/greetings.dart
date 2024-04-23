String getGreeting() {
  final now = DateTime.now();
  final currentTime = now.hour;

  String greeting;

  if (currentTime >= 5 && currentTime < 12) {
    greeting = 'Good morning';
  } else if (currentTime >= 12 && currentTime < 17) {
    greeting = 'Good afternoon';
  } else if (currentTime >= 17 && currentTime < 21) {
    greeting = 'Good evening';
  } else {
    greeting = 'Good night';
  }

  return greeting;
}
