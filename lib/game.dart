import 'dart:math';

import 'package:jasur/trans/eng.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:text_to_speech/text_to_speech.dart';

class WordGame extends StatefulWidget {
  const WordGame({Key? key}) : super(key: key);

  @override
  State<WordGame> createState() => _WordGameState();
}

class _WordGameState extends State<WordGame> {
  Random random = new Random();
  List<int> randomNum = [];
  int jogap = 10;
  int soragSany = 0;
  String? voice;
  generat_random() {
    int len = 10;
    // randomNum=List<int>.generate(10, (int index) => {
    //    random.nextInt(100);});

    for (int i = 0; i < soragSany; i++) {
      randomNum[i] = random.nextInt(1047);
    }
    print('_numberList  = $randomNum');
  }

  TextToSpeech tts = TextToSpeech();
  String? languageCode = 'en-GB';
  speak(String text) async {
    voice = await getVoiceByLang(languageCode!);
    tts.setVolume(1);
    tts.setRate(1);
    if (languageCode != null) {
      tts.setLanguage(languageCode!);
    }
    tts.setPitch(1);
    tts.speak(text);
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

  String butttonText = 'Indiki';
  String soz = "";
  TextEditingController answeredText = TextEditingController();
  @override
  void initState() {
    generat_random();
    soz = eng[randomNum[0]];
    super.initState();
  }

  int bal = 0;
  Color renk = Colors.blue;
  int index = 0;
  next() {
    if (index == soragSany) {
      // Navigator.pushAndRemoveUntil(context, MaterilPageRoute(
      //                   builder: (context) => FinishPage(bal: bal)), (route) => false);
    }
    index = index + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              child: Text(
                bal.toString(),
                style: TextStyle(color: renk),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.volume_up_outlined,
              size: 50,
              color: Colors.blue,
            ),
            onPressed: () async {
              await speak(soz);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text("Write the heard word:"),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: answeredText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            maxLength: 120,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                if (soz == answeredText.text) {
                  next();
                }
              },
              child: Text(butttonText))
        ],
      ),
    );
  }
}
