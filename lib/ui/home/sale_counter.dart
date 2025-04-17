import 'dart:async';
import 'package:flutter/material.dart';

class SaleCounter extends StatefulWidget {
  const SaleCounter({super.key});

  @override
  State<SaleCounter> createState() => _SaleCounterState();
}

class _SaleCounterState extends State<SaleCounter> {
  late Timer _timer;
  Duration _timeLeft = Duration();

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    DateTime targetDate =
        DateTime(2025, 10, 25, 0, 0, 0); // Ngày sale: 25/10/2025 00:00:00
    _updateTimeLeft(targetDate);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTimeLeft(targetDate);
    });
  }

  void _updateTimeLeft(DateTime targetDate) {
    final now = DateTime.now();
    final difference = targetDate.difference(now);

    setState(() {
      if (difference.isNegative) {
        _timeLeft = Duration.zero; // Hiển thị 00:00:00 thay vì lỗi
        _timer.cancel(); // Dừng Timer
      } else {
        _timeLeft = difference;
      }
    });
  }

  String _formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    return "$days : ${_twoDigits(hours)} : ${_twoDigits(minutes)} : ${_twoDigits(seconds)}";
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF181828), Color(0xFF0E2556)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Text(
            "When is the next Major Steam Sale?",
            style: TextStyle(fontSize: 20, color: Color(0xFF66C0F4)),
          ),
          Text(
            "Winter Sale 2025",
            style: TextStyle(
              fontSize: 26,
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "on 25 October 2025",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightGreenAccent, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _formatDuration(_timeLeft),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreenAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
