import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Play extends StatefulWidget {
  var playList;
  Play(this.playList);
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  var animalList = ["강아지", "사자", "호랑이", "말", "양", "염소", "기린", "코끼리", "고양이", "캥거루"];
  var numberList = List.generate(10, (index) => index);
  var peopleList = ["엄마", "아빠", "할아버지", "할머니", "외할아버지", "외할머니", "이모", "큰아빠", "언니", "큰엄마"];
  var colorList = ["빨간색", "주황색", "노란색", "초록색", "파란색", "남색", "보라색"];
  var fruitList = ["사과", "바나나", "수박", "포도", "참외", "키위", "멜론", "블루베리", "토마토", "오렌지"];
  var playList;

  @override
  void initState() {
    super.initState();
    animalList.shuffle();
    numberList.shuffle();
    colorList.shuffle();
    peopleList.shuffle();

    switch(widget.playList) {
      case "가족": playList = peopleList; break;
      case "색깔": playList = colorList; break;
      case "숫자": playList = numberList; break;
      case "과일": playList = fruitList; break;
      default : playList = animalList; break;
    }
    // audioPlayer = AudioPlayer();
    // audioCache = AudioCache(fixedPlayer: audioPlayer);

    if (Platform.isIOS) {
      audioCache.fixedPlayer?.startHeadlessService();
      audioPlayer.startHeadlessService();
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.yellow,
              // pinned: true, // 목록위에 유지
              floating: true, // 스크롤 내릴 경우 없어지고 위로 올리면 나오는 설정
              expandedHeight: 100.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.playList, style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(8),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ) ,
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        play(playList[index]);
                      },
                      child: Stack(
                        children: [
                          widget.playList == "색깔" ? SizedBox() : Image.asset('assets/images/${playList[index]}.jpeg', height: 200, width: 200, fit: BoxFit.fill,),
                          Container(
                              height: 200.0,
                              decoration: BoxDecoration(
                                  color: widget.playList == "색깔" ? whatColor(playList[index]) : Colors.black.withOpacity(0.2),
                                  boxShadow: [
                                    // BoxShadow(
                                    //     color: whatColor(index.toString()).withOpacity(0.5),
                                    //     offset: Offset(3, 3),
                                    //     blurRadius: 5)
                                  ]),
                              child: Center(
                                child: Text(
                                  playList[index].toString(),
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.7)),
                                ),
                              )
                          ),
                        ]
                      ),
                    ),
                  );
                },
                    childCount: playList.length),

              ),
            ),
            // Container(
            //     child: ListView(
            //       // crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         playTitle('색깔'),
            //         playCognitive(colorList, color: true),
            //         SizedBox(height: 10),
            //         playTitle('사람'),
            //         playCognitive(peopleList),
            //         SizedBox(height: 10),
            //         playTitle('동물'),
            //         playCognitive(animalList),
            //         SizedBox(height: 10),
            //         playTitle('숫자'),
            //         playNumber(),
            //         SizedBox(height: 10),
            //         playTitle('과일'),
            //         playCognitive(fruitList),
            //       ],
            //     )),
          ]
        ));
  }

  play(sound) {
    audioCache.play('audios/$sound.mp3');
  }

  playTitle(title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 50,
        ),
      ),
    );
  }


  playCognitive(List list, {color}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CarouselSlider(
          options: CarouselOptions(
            // height: 400.0,
            aspectRatio: 16 / 9,
            viewportFraction: 0.7,
            initialPage: 0,
          ),
          items: list.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    play(i);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: color != null ? whatColor(i) : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: whatColor(i).withOpacity(0.5),
                                offset: Offset(3, 3),
                                blurRadius: 5)
                          ]),
                      child: Center(
                        child: Text(
                          '$i',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.7)),
                        ),
                      )),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  playNumber() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CarouselSlider(
          options: CarouselOptions(
            // height: 400.0,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
          ),
          items: numberList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    play(i);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(3, 3),
                                blurRadius: 5)
                          ]),
                      child: Center(
                        child: Text(
                          '${i+1}',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                      )),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Color whatColor(String i) {
    switch (i) {
      case "빨간색":
        return Colors.red;
      case "주황색":
        return Colors.orange;
      case "노란색":
        return Colors.yellow;
      case "초록색":
        return Colors.green;
      case "파란색":
        return Colors.blue;
      case "남색":
        return Colors.indigo;
      case "보라색":
        return Colors.purple;
    }
    return Colors.grey;
  }
}
