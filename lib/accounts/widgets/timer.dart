import 'package:flutter/material.dart';

class TimeRemainingWidget extends StatelessWidget {
  const TimeRemainingWidget({required this.time, this.max = 30});

  // Time should be an int between 0-30 (representing number of seconds remaining)
  final int time;
  final int max;

  double progress() {
    return time / max;
  }

  Color color() {
    var frac = progress();
    if (frac <= 0.17) {
      return Colors.red;
    }
    return Colors.green;
    // 5 seconds, assuming 30 second interval.
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Text(
        time.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color(),
          leadingDistribution: TextLeadingDistribution.even,
        ),
      ),
      CircularProgressIndicator(value: progress(), color: color()),
    ]);
  }
}
