import 'dart:async';
import "package:proyecto/globals.dart" as globals;

import 'package:flutter/material.dart';

void minijuego2() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Log In',
      home: SegundaCarrera(),
    );
  }
}

class SegundaCarrera extends StatefulWidget {
  TerceraCarrera createState() => TerceraCarrera();
}

class TerceraCarrera extends State<SegundaCarrera> {
  //variables
  var size, heightA, widthA;
  int tiempoInicio = 1;
  Color colorInicio = Colors.white;
  Color colorBordeInicio = Colors.black;
  Color colorGo = Colors.transparent;
  Color colorBordeGo = Colors.transparent;
  double topIA = 600;
  double topJugador = 600;

  double topFin = 10000;
  double leftFin = 10000;
  AssetImage imgFin = new AssetImage("assets/images/carrera/win.gif");

  double topMeta = -1000;
  double leftMeta = 20;
  AssetImage imgMeta = new AssetImage("assets/images/carrera/meta.png");

  AssetImage imgFondo =
      new AssetImage("assets/images/carrera/fondoCarrera.png");

  double leftGuide = 50;

  @override
  void initState() {
    startGame();
  }

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
      decoration: BoxDecoration(
          image: DecorationImage(image: imgFondo, fit: BoxFit.fitHeight)),
      //aqui va el juego
      child: Stack(
        children: [
          Positioned(
            top: 100,
            left: 120,
            child: Container(
              height: 300,
              width: 300,
              child: globals.textoConBorde(
                  "Preparados ...", 28, 5, colorInicio, colorBordeInicio),
              // child: Text(
              //   "Preparados...",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //       color: colorInicio, fontSize: 28, fontFamily: "fuente1"),
              // ),
            ),
          ),
          //texto GO!
          Positioned(
            top: 200,
            left: 140,
            child: Container(
              height: 300,
              width: 300,
              child:
                  globals.textoConBorde("GO !", 50, 8, colorGo, colorBordeGo),
              // child: Text(
              //   "GO",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //       color: colorGo, fontSize: 40, fontFamily: "fuente1"),
              // ),
            ),
          ),
          //linea de meta
          AnimatedPositioned(
              top: topMeta,
              left: leftMeta,
              duration: const Duration(seconds: 1),
              child: Container(
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: imgMeta, fit: BoxFit.fitWidth)),
                width: 370,
                height: 100,
              )),
          //imagen coche jugador
          Positioned(
              top: topJugador,
              left: 60,
              child: InkWell(
                child: Container(
                  height: 250,
                  width: 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/carrera/supra.png"),
                          fit: BoxFit.fitWidth)),
                ),
                onTap: () {
                  cocheJugador();
                },
              )),
          //imagen coche IA
          Positioned(
              top: topIA,
              left: 250,
              child: InkWell(
                child: Container(
                  height: 250,
                  width: 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/carrera/corvette2.png"),
                          fit: BoxFit.fitWidth)),
                ),
                onTap: () {},
              )),

          //desaparecer guide
          AnimatedPositioned(
              top: topFin,
              left: leftFin,
              duration: const Duration(seconds: 2),
              child: Container(
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: imgFin, fit: BoxFit.fitWidth)),
                width: 300,
                height: 300,
              )),

          AnimatedPositioned(
              top: heightA * 0.5 - ((99 * 0.37 / 2)),
              // left: widthA0.5-((8540.37)/2),
              left: leftGuide,
              duration: const Duration(milliseconds: 500),
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/carrera/guideCarrera.png"),
                        fit: BoxFit.fitWidth)),
                width: 746 * 0.37,
                height: 81 * 0.37,
              )),
        ],
      ),
    ));
  }

  //TIMER QUE EMPEZARÁ EL JUEGO Y ELIMINA LA GUÍA
  late Timer timerGame;
  void startGame() {
    int game = 0;
    const oneSec = Duration(milliseconds: 1000);
    timerGame = Timer.periodic(
      oneSec,
      (Timer timerGame) {
        if (game == 0) {
          setState(() {
            leftGuide = 500;
            game++;
          });
        } else {
          //TIMER EMPEZAR JUEGO

          timerGame.cancel();
          startTimer();
        }
      },
    );
  }

//timer para desaparecer el texto de inicio
  late Timer timer;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        tiempoInicio--;
        print(tiempoInicio);
        if (tiempoInicio == 0) {
          colorInicio = Colors.transparent;
          colorBordeInicio = Colors.transparent;
          colorGo = Colors.white;
          colorBordeGo = Colors.black;
          imgFondo = AssetImage("assets/images/carrera/fondo.gif");
          startTimerIA();
        }
        if (tiempoInicio == -2) {
          colorGo = Colors.transparent;
          colorBordeGo = Colors.transparent;
        }
      });
    });
  }

//timer para el coche de la IA
  late Timer timerIA;
  void startTimerIA() {
    const oneSec = Duration(milliseconds: 250);
    timerIA = Timer.periodic(oneSec, (Timer timerIA) {
      setState(() {
        if (tiempoInicio <= 0) {
          topIA = topIA - 10;
          print(topIA);
        }

        if (topIA == 300.0) {
          print('entrando');
          topMeta = 50;
          leftMeta = 20;
        }

        if (topIA == 50) {
          timerIA.cancel();
          timer.cancel();
          imgFin = AssetImage("assets/images/carrera/lose.gif");
          topFin = 250;
          leftFin = 50;
          globals.win = 0;

          if (globals.gameMode == 1) {
            Navigator.of(context).pushNamed("/inGame");
          } else if (globals.gameMode == 2) {
            Navigator.of(context).pushNamed("/inGameOnline");
          } else if (globals.gameMode == 3) {
            Navigator.of(context).pushNamed("/gallery");
          }
        }
      });
    });
  }

  void cocheJugador() {
    setState(() {
      if (tiempoInicio <= 0) {
        if (topJugador != 50) {
          topJugador = topJugador - 10;
        } else {
          timerIA.cancel();
          timer.cancel();
          imgFin = AssetImage("assets/images/carrera/win.gif");
          globals.win = 1;
          topFin = 250;
          leftFin = 50;
          if (globals.gameMode == 1) {
            Navigator.of(context).pushNamed("/inGame");
          } else if (globals.gameMode == 2) {
            Navigator.of(context).pushNamed("/inGameOnline");
          } else if (globals.gameMode == 3) {
            Navigator.of(context).pushNamed("/gallery");
          }
        }
      }
    });
  }
}
