import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Contoh2 extends StatefulWidget {
  const Contoh2({Key? key}) : super(key: key);

  @override
  _Contoh2State createState() => _Contoh2State();
}

class _Contoh2State extends State<Contoh2> {
  int _percent = 100;
  int _getSteam = 0;
  double _circular = 1;

  late StreamSubscription<int> _sub;
  final Stream<int> _myStream =
      Stream.periodic(const Duration(seconds: 1), (int count) {
    return count;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double avaHeight = constraints.maxHeight;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CircularPercentIndicator(
                    radius: avaHeight / 5,
                    lineWidth: 10,
                    percent: _circular,
                    center: Text("$_percent %"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _sub = _myStream.listen((event) {
            _getSteam = event;
            setState(() {
              if (_percent - _getSteam <= 0) {
                _sub.cancel();
                _percent = 0;
                _circular = 0;
              } else {
                _percent = _percent - _getSteam;
                _circular = _percent / 100;
              }
            });
          });
        },
      ),
    );
  }
}
