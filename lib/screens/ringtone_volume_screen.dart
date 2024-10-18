import 'package:flutter/material.dart';

class RingtoneVolumeScreen extends StatefulWidget {
  const RingtoneVolumeScreen(this.ringtoneVolume, {super.key});

  final int ringtoneVolume;

  @override
  State<RingtoneVolumeScreen> createState() => _RingtoneVolumeScreenState();
}

class _RingtoneVolumeScreenState extends State<RingtoneVolumeScreen> {
  late double _currentVolume;

  @override
  void initState() {
    _currentVolume = widget.ringtoneVolume.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        return Navigator.pop(context, _currentVolume.toInt());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ringtone Volume'),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _currentVolume.toInt());
            },
            child: const Text('BACK'),
          ),
        ),
        body: Center(
          child: Slider(
            value: _currentVolume,
            min: 0,
            max: 100,
            divisions: 100,
            label: _currentVolume.round().toString(),
            onChanged: (val) {
              setState(() {
                _currentVolume = val;
              });
            },
          ),
        ),
      ),
    );
  }
}
