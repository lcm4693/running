import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste/components/button.dart';
import 'package:teste/database/dao/treinos_dao.dart';
import 'package:teste/model/treino.dart';
import 'package:teste/utils/date-util.dart';

class TreinoScreen extends StatefulWidget {
  @override
  _TreinoScreenState createState() => _TreinoScreenState();
}

class _TreinoScreenState extends State<TreinoScreen> {
  Timer _timer;
  int _counter = 0;
  static final labelPause = "Pause";
  static final labelContinue = "Continue";
  final TreinoDAO _dao = TreinoDAO();

  void _pauseTimer() {
    if (_timer != null) {
      if (_timer.isActive) {
        setState(() => _timer.cancel());
      } else {
        startTimer();
      }
    }
  }

  void _stopTimer() {
    //SAVE

    final Treino treino =
        Treino(0, new DateTime.now().millisecondsSinceEpoch, _counter);

    _dao.save(treino).then((id) {
      debugPrint('ID:' + id.toString());
      _cleanAttributes();
    });
  }

  void _incrementCounter() {
    setState(() => _counter = _counter + 1);
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _incrementCounter();

    _timer = new Timer.periodic(oneSec, (Timer timer) => _incrementCounter());
  }

  void _cleanAttributes() {
    if (_timer != null) {
      setState(() {
        _timer.cancel();
        _counter = 0;
        _timer = null;
      });
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  bool _timerAtivo() {
    return (_timer != null && _timer.isActive);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              DateUtil.printDuration(new Duration(seconds: _counter.floor())),
              style: TextStyle(fontSize: 48),
            ),
            Visibility(
              child: RaisedButton(
                padding: EdgeInsets.all(42),
                color: Colors.lightGreenAccent,
                shape: CircleBorder(
                  side: BorderSide(),
                ),
                onPressed: startTimer,
                child: Text(
                  "Start",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              visible: _counter == 0,
            ),
            Visibility(
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Button(
                  onLongPress: _pauseTimer,
                  label: labelPause,
                  icon: Icons.pause,
                ),
              ),
              visible: _timerAtivo(),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Visibility(
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Button(
                            onPress: () {
                              _pauseTimer();
                            },
                            label: labelContinue,
                            icon: Icons.play_arrow,
                          ),
                        ),
                        visible: (_timer != null && !_timer.isActive),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Visibility(
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Button(
                            onLongPress: _stopTimer,
                            label: 'Stop',
                            icon: Icons.stop,
                          ),
                        ),
                        visible: _timer != null && !_timer.isActive,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
