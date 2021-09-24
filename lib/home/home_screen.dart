import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:oneradio/home/components/audio_file.dart';

import 'components/app_drawer.dart';
import 'components/appbar_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AudioPlayer? advancedPlayer;
  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appDrawer(),
      appBar: homeAppbar(),
      body: Center(
        child: AudioFile(advancedPlayer: advancedPlayer),
      ),
    );
  }
}
