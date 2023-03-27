import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:jasur/detail_page.dart';
import 'package:jasur/trans/eng.dart';
import 'package:jasur/trans/jap.dart';
import 'package:jasur/trans/ru.dart';
import 'package:jasur/trans/tm.dart';
import 'package:jasur/word_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Esasy extends StatefulWidget {
  const Esasy({Key? key}) : super(key: key);

  @override
  State<Esasy> createState() => _EsasyState();
}

class _EsasyState extends State<Esasy> {
  List<String> dil = ['ENGLISH', 'TURKMEN', 'RUSSIAN', 'JAPAN'];
  List<String> dilCCode = ['en-GB', 'not', 'ru-RU', 'ja-JP'];
  TextStyle st = const TextStyle(fontSize: 12);
  List<DropdownMenuItem<int>> gornushiItems = [
    const DropdownMenuItem<int>(
        value: 0, child: Text('EN', style: TextStyle(fontSize: 12))),
    const DropdownMenuItem<int>(
        value: 1, child: Text('TM', style: TextStyle(fontSize: 12))),
    const DropdownMenuItem<int>(
        value: 2, child: Text('RU', style: TextStyle(fontSize: 12))),
    const DropdownMenuItem<int>(
        value: 3, child: Text('JP', style: TextStyle(fontSize: 12)))
  ];
  final FocusNode searchFocusNode = FocusNode();
  int currentLang = 0;
  List<String> word = [];
  List<String> found = [];
  List<String> sozEN = eng;
  List<String> sozJap = jap;
  List<String> sozTM = tm;
  List<String> sozRU = rus;
  List<List<String>> diller = [];
  bool searchEnabled = false;
  String searchText = "Search";
  List<int> indx = [];
  Widget gozleg(String label) {
    return TextField(
      focusNode: searchFocusNode,
      style: const TextStyle(fontSize: 20, color: Colors.white),
      decoration: InputDecoration(
        hintStyle: const TextStyle(fontSize: 20, color: Colors.white),
        hintText: label,
        fillColor: Colors.white,
      ),
      onChanged: (value) {
        found = [];
        indx = [];
        List<int> inx = [];
        for (int i = 0; i < word.length; i++) {
          if (word[i].toLowerCase().contains(value.trim().toLowerCase())) {
            found.add(word[i]);
            inx.add(i);
          }
        }
        setState(() {
          indx = inx;
        });
      },
    );
  }

  @override
  void initState() {
    diller = [sozEN, sozTM, sozRU, sozJap];
    word = sozEN;
    super.initState();
    print(word.length);
  }

  Widget defaultList() {
    return ListView.builder(
        itemCount: eng.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WordWidget(
                          tb: currentLang,
                          title: word[i],
                          languageCode: dilCCode[currentLang],
                        )));
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFB350288),
                  fixedSize: const Size(280, 46),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13))),
              child: Text(
                word[i],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo,
        centerTitle: false,
        title: searchEnabled
            ? Center(
                child:
                    Container(width: sizeWidth * 70, child: gozleg(searchText)))
            : Text(
                dil[currentLang],
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
        actions: [
          searchEnabled
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () {
                    setState(() {
                      searchEnabled = false;
                    });
                  },
                )
              : IconButton(
                  tooltip: "Search",
                  icon: const Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    setState(() {
                      searchEnabled = true;
                      searchFocusNode.requestFocus();
                    });
                  },
                ),
          SizedBox(
            width: 80,
            child: DropdownButtonFormField2(
              style: const TextStyle(color: Colors.white),
              value: currentLang,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                iconColor: Colors.red,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(15),
                // ),
              ),
              isExpanded: true,
              buttonHeight: 60,
              buttonDecoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15)),
              buttonPadding: const EdgeInsets.only(left: 20, right: 10),
              dropdownDecoration: BoxDecoration(
                color:  Colors.indigo,
                borderRadius: BorderRadius.circular(15),
              ),
              items: gornushiItems,
              onChanged: (value) {
                int index = int.parse(value.toString());
                setState(() {
                  currentLang = index;
                  word = diller[currentLang];
                });
              },
            ),
          ),
        ],
      ),
      body: searchEnabled
          ? ListView.builder(
              itemCount: found.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailPage(index: indx[index])));
                  },
                  child: WordWidget(
                    tb: currentLang,
                    title: found[index],
                    languageCode: dilCCode[currentLang],
                  ),
                );
              })
          : ListView.builder(
              itemCount: word.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailPage(index: index)));
                  },
                  child: WordWidget(
                    tb: currentLang,
                    title: word[index],
                    languageCode: dilCCode[currentLang],
                  ),
                );
              }),
    );
  }
}
