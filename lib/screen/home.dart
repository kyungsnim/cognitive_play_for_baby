import 'package:cognitive_play_for_baby/screen/play.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List playList = ["가족", "색깔", "동물", "숫자", "과일"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: <Widget>[
        const SliverAppBar(
          backgroundColor: Colors.yellow,
          // pinned: true, // 목록위에 유지
          floating: true, // 스크롤 내릴 경우 없어지고 위로 올리면 나오는 설정
          expandedHeight: 100.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('황제이 인지 놀이',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //         (BuildContext context, int index) {
        //       return Card(
        //         margin: EdgeInsets.all(15),
        //         child: Container(
        //           color: Colors.blue[100 * (index % 9 + 1)],
        //           height: 80,
        //           alignment: Alignment.center,
        //           child: Text(
        //             "Item $index",
        //             style: TextStyle(fontSize: 30),
        //           ),
        //         ),
        //       );
        //     },
        //     childCount: 1000, // 1000 list items
        //   ),
        // ),
        SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.to(() => Play(playList[index]));
                  },
                  child: Stack(children: [
                    Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        child: Image.asset(
                          'assets/images/${playList[index]}.jpeg',
                          height: 200,
                          width: 200,
                          fit: BoxFit.fill,
                        )),
                    Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            boxShadow: [
                            ]),
                        child: Center(
                          child: Text(
                            playList[index],
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.7)),
                          ),
                        )),
                  ]),
                ),
              );
            }, childCount: playList.length),
          ),
        ),
      ]),
    );
  }

  Color _randomColor(int index) {
    if (index % 3 == 0) {
      return Colors.pink;
    } else if (index % 3 == 1) {
      return Colors.blueAccent;
    }

    return Colors.amber;
  }
}
