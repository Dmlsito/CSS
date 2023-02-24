import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import "package:proyecto/globals.dart" as globals;
import 'package:proyecto/menu/ajustes.dart';
import 'package:proyecto/menu/menu.dart';
import 'package:proyecto/menu/ranking.dart';

import '../user/transition.dart';
import 'online.dart';

void mainMenu() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'mainMenu',
      home: SegundaMainMenu(),
    );
  }
}

class SegundaMainMenu extends StatefulWidget {
  TerceraMainMenu createState() => TerceraMainMenu();
}

class TerceraMainMenu extends State<SegundaMainMenu> {
  var size, heightA, widthA;

  @override
  Widget build(BuildContext context) {
    setState(() {
      size = MediaQuery.of(context).size;
      heightA = size.height;
      widthA = size.width;
    });

    return Scaffold(
      //cuerpo principal del login
      body: Container(
          height: heightA,
          width: widthA,

          //imagen de fondo login
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/mainBG.png"),
                  fit: BoxFit.fitHeight)),
          child: Stack(
            children: [
              Positioned(
                  left: 20,
                  top: 30,
                  child: InkWell(
                    onTap: () {
                      //ponemos el valor de gameMode a modo historia
                      globals.gameMode = 1;
                      Navigator.of(context).pushNamed("/inGame");
                    },
                    child: Container(
                      width: 1050 * 0.35,
                      height: 550 * 0.35,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/botones/historia.png"),
                              fit: BoxFit.fitWidth)),
                    ),
                  )),
              Positioned(
                  left: 20,
                  top: 240,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(RightSlide(child: Online()));
                    },
                    child: Container(
                      width: 1050 * 0.35,
                      height: 550 * 0.35,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/botones/online.png"),
                              fit: BoxFit.fitWidth)),
                    ),
                  )),
              Positioned(
                  left: 20,
                  top: 450,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("/gallery");
                    },
                    child: Container(
                      width: 1050 * 0.35,
                      height: 314 * 0.35,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/botones/galeria.png"),
                              fit: BoxFit.fitWidth)),
                    ),
                  )),
              Positioned(
                  left: 20,
                  top: 575,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(RightSlide(child: Ranking()));
                    },
                    child: Container(
                      width: 510 * 0.35,
                      height: 510 * 0.35,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/botones/ranking.png"),
                              fit: BoxFit.fitWidth)),
                    ),
                  )),
              Positioned(
                  left: 210,
                  top: 575,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(RightSlide(child: Ajustes()));
                    },
                    child: Container(
                      width: 510 * 0.35,
                      height: 510 * 0.35,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/botones/ajustes.png"),
                              fit: BoxFit.fitWidth)),
                    ),
                  )),
              Align(
                alignment: Alignment.bottomLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(LeftSlide(child: SegundaMenu()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, left: 10),
                    alignment: Alignment.bottomLeft,
                    width: 45,
                    height: 45,
                    //color: Colors.black,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/arrow.png"),
                            fit: BoxFit.fitHeight)),
                  ),
                ),
              )
            ],
          )),
    );
  }

  //FUNCIONES

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //playFile("menu.mp3");
  }

  //AUDIO PLAYER Y TIMER PARA REINICIAR LA CANCIÓN
  final player = AudioPlayer();
  void playFile(String url) {
    player.play(AssetSource(url));
  }

  late Timer timer;
  int _start = 64;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            playFile("menu.mp3");
            _start = 64;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
