import 'dart:async';
import 'dart:ui';

class Delayed {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Delayed({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer!= null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
