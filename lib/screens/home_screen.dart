import 'package:flutter/material.dart';
import 'package:simple_navigation/screens/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.username, {super.key});

  final String username;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int mediaVolume = 50;

  void setMediaVolume(int volume) {
    setState(() {
      mediaVolume = volume;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(
                    mediaVolume: mediaVolume,
                    onMediaVolumeUpdate: setMediaVolume,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome ${widget.username},',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            const Text(
              'Click the settings button to navigate to the setting screen',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
