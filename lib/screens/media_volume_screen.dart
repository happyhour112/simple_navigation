import 'package:flutter/material.dart';

class MediaVolumeScreen extends StatefulWidget {
  const MediaVolumeScreen({
    super.key,
    required this.mediaVolume,
    required this.onMediaVolumeUpdate,
  });

  final int mediaVolume;
  final void Function(int volume) onMediaVolumeUpdate;

  @override
  State<MediaVolumeScreen> createState() => _MediaVolumeScreenState();
}

class _MediaVolumeScreenState extends State<MediaVolumeScreen> {
  late int _currentVolume;

  @override
  void initState() {
    _currentVolume = widget.mediaVolume;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        return Navigator.pop(context, _currentVolume);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Media Volume'),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _currentVolume);
            },
            child: const Text('BACK'),
          ),
        ),
        body: Center(
          child: Slider(
            value: _currentVolume.toDouble(),
            min: 0,
            max: 100,
            divisions: 100,
            label: _currentVolume.toString(),
            onChanged: (val) {
              setState(() {
                _currentVolume = val.toInt();
                widget.onMediaVolumeUpdate(_currentVolume);
              });
            },
          ),
        ),
      ),
    );
  }
}
