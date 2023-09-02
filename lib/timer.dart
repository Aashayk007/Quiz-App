import 'dart:async';

class QuizTimer {
  final int durationInSeconds;
  late Timer _timer;
  late Function onTimerTick;
  late Function onTimerComplete;

  QuizTimer({
    required this.durationInSeconds,
    required this.onTimerTick,
    required this.onTimerComplete,
  });

  void startTimer() {
    int secondsRemaining = durationInSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      secondsRemaining--;
      onTimerTick(secondsRemaining);
      if (secondsRemaining <= 0) {
        timer.cancel();
        onTimerComplete();
      }
    });
  }

  void cancelTimer() {
    _timer.cancel();
  }
}
