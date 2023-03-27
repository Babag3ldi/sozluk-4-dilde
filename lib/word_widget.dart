import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:text_to_speech/text_to_speech.dart';

class WordWidget extends StatefulWidget {
  int tb;
  final String title;
  final String languageCode;
  // final int cLang;
  // final int index;
  WordWidget({
    Key? key,
    required this.tb,
    required this.title,
    required this.languageCode, // required this.cLang,
    //required this.index
  }) : super(key: key);

  @override
  State<WordWidget> createState() => _WordWidgetState();
}

class _WordWidgetState extends State<WordWidget> {
  AudioPlayer player = AudioPlayer();
  TextToSpeech tts = TextToSpeech();
  bool showIcon = false;
  double volume = 1; // Range: 0-1
  double rate = 1.0; // Range: 0-2
  double pitch = 1.0; // Range: 0-2
  String? voice;
  String? language;

  @override
  void initState() {
    print(widget.languageCode);
    if (widget.tb == 1) {
      showIcon = false;
      print(widget.tb);
    } else
      showIcon = true;
    player = AudioPlayer();
    super.initState();
  }

  Future _speak() async {
    String audioPath = 'assets/mp3/${widget.title}.mp3';
    print(audioPath);
    player.stop();
    await player.setAsset(audioPath);

    player.play();
    print("yes= ");

    // await flutterTts.setSpeechRate(0.6);
    // await flutterTts.speak(outputText);
  }

  void speak(String text) {
    tts.setVolume(volume);
    tts.setRate(rate);
    if (widget.languageCode != null) {
      tts.setLanguage(widget.languageCode);
    }
    tts.setPitch(pitch);
    tts.speak(text);
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(widget.languageCode);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    print('yes');
    print(voices);
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: const TextStyle(fontSize: 18),
      ),
      // leading: Text(
      //   (tb + 1).toString(),
      //   style: const TextStyle(fontSize: 18),
      // ),
      trailing: widget.tb != 0
          ? null
          : IconButton(
              icon: const Icon(Icons.volume_up),
              onPressed: () async {
                voice = await getVoiceByLang(widget.languageCode);
                widget.tb == 0 ? await _speak() : speak(widget.title);

                //play ound
              },
            ),
    );
  }
}
