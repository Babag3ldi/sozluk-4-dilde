import 'dart:io';
import 'dart:math';

import 'package:jasur/trans/eng.dart';
import 'package:jasur/trans/jap.dart';
import 'package:jasur/trans/ru.dart';
import 'package:jasur/trans/tm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:text_to_speech/text_to_speech.dart';

class DetailPage extends StatefulWidget {
  final int index;
  final int lnIndex;
  const DetailPage({Key? key, required this.index, this.lnIndex = 0})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Random random = new Random();
  List<int> randomNum = [];
  generat_random() {
    int len = 10;
    // randomNum=List<int>.generate(10, (int index) => {
    //    random.nextInt(100);});
    randomNum = List.generate(len, (index) => random.nextInt(1047));
    // for (int i = 0; i < len; i++) {
    //   randomNum[i] = random.nextInt(1047);
    // }
    print('_numberList  = $randomNum');
  }

  List<String> lnTexts = ['Iňlisçe', 'Türkmençe', 'Rusça', 'Ýaponça'];
  List<Widget> lnWidgets = [];
  AudioPlayer player = AudioPlayer();

  final String defaultLanguage = 'en-US';

  TextToSpeech tts = TextToSpeech();

  double volume = 1; // Range: 0-1
  double rate = 1.0; // Range: 0-2
  double pitch = 1.0; // Range: 0-2

  String? language;
  String? languageCode = 'ja-JP';
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  String? voice;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;
  @override
  void initState() {
    player = AudioPlayer();
    generat_random();
    super.initState();
  }

  initTTS() async {
    languageCode = 'ja-JP';
    voice = await getVoiceByLang(languageCode!);
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(languageCode!);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    print('yes');
    print(voices);
    return null;
  }

  void speak(String text) {
    tts.setVolume(volume);
    tts.setRate(rate);
    if (languageCode != null) {
      tts.setLanguage(languageCode!);
    }
    tts.setPitch(pitch);
    tts.speak(text);
  }

  Future _speak(String d) async {
    String audioPath = 'assets/mp3/$d.mp3';
    print(audioPath);
    player.stop();
    await player.setAsset(audioPath);

    player.play();
    print("yes= ");

    // await flutterTts.setSpeechRate(0.6);
    // await flutterTts.speak(outputText);
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Row(children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              lnTexts[0],
              style: const TextStyle(
                fontWeight: FontWeight.w900,
              ),
            )
          ]),
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          children: [
            Text(
              lnTexts[0],
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 23,
                  color: Color(0xFF3600B3)),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    eng[widget.index],
                    style:
                        const TextStyle(fontSize: 20, color: Color(0xFF101011)),
                  ),
                  // const SizedBox(
                  //   width: 150,
                  // ),
                  // IconButton(
                  //   icon: const Icon(Icons.volume_up),
                  //   onPressed: () async {
                  //     languageCode = 'en-GB';
                  //     voice = await getVoiceByLang(languageCode!);

                  //     speak(eng[widget.index]);
                  //     //play ound
                  //   },
                  // ),
                  IconButton(
                    icon: const Icon(
                      Icons.volume_up,
                      //  color: Colors.blue
                    ),
                    onPressed: () async {
                      languageCode = 'en-GB';
                      voice = await getVoiceByLang(languageCode!);

                      _speak(eng[widget.index]);
                      //play ound
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Text(
              lnTexts[1],
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 23,
                  color: Color(0xFF3600B3)),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                tm[widget.index],
                style: TextStyle(fontSize: 20, color: Color(0xFF101011)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Text(
              lnTexts[2],
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 23,
                  color: Color(0xFF3600B3)),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    rus[widget.index],
                    style: TextStyle(fontSize: 20, color: Color(0xFF101011)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up),
                    onPressed: () async {
                      languageCode = 'ru-RU';
                      voice = await getVoiceByLang(languageCode!);
                      speak(rus[widget.index]);
                      //play ound
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Text(
              lnTexts[3],
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 23,
                  color: Color(0xFF3600B3)),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    jap[widget.index],
                    style: TextStyle(fontSize: 20, color: Color(0xFF101011)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up),
                    onPressed: () async {
                      languageCode = 'ja-JP';
                      voice = await getVoiceByLang(languageCode!);
                      speak(jap[widget.index]);
                      //play ound
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ],
        ));
  }
}
