import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer? advancedPlayer;
  const AudioFile({Key? key, this.advancedPlayer}) : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _position = const Duration();
  Duration _duration = const Duration();
  final String path = "https://luan.xyz/files/audio/ambient_c_motion.mp3";
  //final String localPath = "Internal storage/testsong.mp3";
  final String localPath = "assets/audio/intro.mp3";
  bool isPlaying = false;
  bool isPause = false;
  bool isRepeat = false;
  Color btncolor = Colors.black;
  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    super.initState();
    widget.advancedPlayer?.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    widget.advancedPlayer?.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    widget.advancedPlayer?.setUrl(path);
    widget.advancedPlayer?.onPlayerCompletion.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  Widget btnStart() {
    return IconButton(
      onPressed: () {
        if (isPlaying == false) {
          widget.advancedPlayer?.play(path);
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          widget.advancedPlayer?.pause();
          setState(() {
            isPlaying = false;
          });
        }
        //widget.advancedPlayer?.play(path);
      },
      icon: isPlaying == false
          ? Icon(_icons[0], size: 50, color: Colors.red)
          : Icon(_icons[1], size: 50, color: Colors.blue),
      padding: const EdgeInsets.only(bottom: 10),
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }

  Widget btnLoop() {
    return IconButton(
      icon: const Icon(
        Icons.repeat_rounded,
        color: Colors.black,
        size: 30,
      ),
      onPressed: () {},
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: Icon(
        Icons.repeat_one,
        color: btncolor,
        size: 30,
      ),
      onPressed: () {
        if (isRepeat == false) {
          widget.advancedPlayer?.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat = true;
            btncolor = Colors.blue;
          });
        } else if (isRepeat == false) {
          widget.advancedPlayer?.setReleaseMode(ReleaseMode.RELEASE);
          setState(() {
            isRepeat = false;
            btncolor = Colors.black;
          });
        }
      },
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: const Icon(
        Icons.arrow_right,
        color: Colors.black,
        size: 50,
      ),
      onPressed: () {
        //widget.advancedPlayer?.setPlaybackRate(play : 1.5);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: const Icon(
        Icons.arrow_left,
        color: Colors.black,
        size: 50,
      ),
      onPressed: () {},
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer?.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split(".")[0],
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  _duration.toString().split(".")[0],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          slider(),
          loadAsset(),
        ],
      ),
    );
  }
}
