import 'package:flutter/material.dart';
import 'package:simple_navigation/screens/media_volume_screen.dart';
import 'package:simple_navigation/screens/ringtone_volume_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
    required this.mediaVolume,
    required this.onMediaVolumeUpdate,
  });

  final int mediaVolume;
  final void Function(int volume) onMediaVolumeUpdate;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _ringtoneVolume = 50;
  late int _mediaVolume;

  Future<void> _navigateAndGetVolume(BuildContext context) async {
    final int volume = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RingtoneVolumeScreen(_ringtoneVolume),
      ),
    );

    if (!context.mounted) return;

    setState(() {
      _ringtoneVolume = volume;
    });
  }

  Future<void> _awaitAndNavigateMedia(BuildContext context) async {
    final int newVolume = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MediaVolumeScreen(
          mediaVolume: widget.mediaVolume,
          onMediaVolumeUpdate: widget.onMediaVolumeUpdate,
        ),
      ),
    );

    if (!context.mounted) return;

    if (newVolume != widget.mediaVolume) {
      setState(() {
        _mediaVolume = newVolume;
      });
    }
  }

  @override
  void initState() {
    _mediaVolume = widget.mediaVolume;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('BACK'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Card.filled(
            margin: const EdgeInsets.only(left: 16, right: 16),
            elevation: 2.0,
            child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  _navigateAndGetVolume(context);
                },
                child: ListTile(
                  trailing: Text(
                    '$_ringtoneVolume',
                    style: const TextStyle(fontSize: 16),
                  ),
                  title: const Text('Ringtone Volume'),
                )),
          ),
          const SizedBox(height: 8),
          Card.filled(
            margin: const EdgeInsets.only(left: 16, right: 16),
            elevation: 2.0,
            child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  _awaitAndNavigateMedia(context);
                },
                child: ListTile(
                  trailing: Text(
                    '$_mediaVolume',
                    style: const TextStyle(fontSize: 16),
                  ),
                  title: const Text('Media Volume'),
                )),
          ),
        ],
      ),
    );
  }
}
