import 'dart:async';
import 'dart:math';
import "package:proyecto/globals.dart" as globals;

import 'package:flutter/material.dart';

void minijuego1() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Log In',
      home: SegundaReloj(),
    );
  }
}

class SegundaReloj extends StatefulWidget {
  TerceraReloj createState() => TerceraReloj();
}

class TerceraReloj extends State<SegundaReloj> {
  var size, heightA, widthA;

//variables
  int tiempo = 10;
  int random = Random().nextInt(4 + 1) + 1;
  double topPato = 10000;
  double leftPato = 10000;
  AssetImage imgpato = new AssetImage("assets/images/reloj/final-pato.gif");

  Color colorNumero = Colors.yellow;
  Color colorTexto = Colors.yellow;

  double leftGuide = 0;

//timer para que baje el tiempo

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
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage("assets/images/reloj/fondo-Minijuego1.jpeg"),
                  fit: BoxFit.fitWidth)),

          //aqui va el juego
          child: Stack(
            children: [
              //fila donde va el gift del reloj
              Row(
                //alinear al centro
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //padding para dejar separacion con el top
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Image.asset(
                      "assets/images/reloj/reloj.gif",
                      height: 200,
                    ),
                  )
                ],
              ),
              //text donde se mostraran los segundos restantes
              Positioned(
                  top: 300,
                  left: 183,
                  child: Text(
                    tiempo.toString(),
                    style: TextStyle(color: colorNumero, fontSize: 40),
                  )),
              Positioned(
                  top: 500,
                  left: 130,
                  child: InkWell(
                    child: Container(
                      height: 350,
                      width: 150,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/reloj/stop.png"),
                              fit: BoxFit.fitWidth)),
                    ),
                    onTap: () {
                      btnTiempo();
                    },
                  )),
              Positioned(
                  top: 500,
                  left: 60,
                  child: globals.textoConBorde(
                      "Para el tiempo en el segundo: " + random.toString(),
                      22,
                      4,
                      colorTexto,
                      Colors.black)),
              // Positioned(
              //     top: 500,
              //     left: 80,
              //     child: Text(
              //       "Para el tiempo en el segundo: " + random.toString(),
              //       style: TextStyle(color: colorTexto, fontSize: 20),
              //     )),

              AnimatedPositioned(
                  top: topPato,
                  left: leftPato,
                  duration: const Duration(seconds: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imgpato, fit: BoxFit.fitWidth)),
                    width: 300,
                    height: 300,
                  )),
              AnimatedPositioned(
                  top: heightA * 0.5 - ((990.37 / 2)),
                  // left: widthA0.5-((8540.37)/2),
                  left: leftGuide,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/reloj/guideReloj.png"),
                            fit: BoxFit.fitWidth)),
                    width: 400.37,
                    height: 990.37,
                  )),
            ],
          )),
    );
  }

  //FUNCIONES
  late Timer timer;
  late Timer timerPato;
  int contNext = 0;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (tiempo <= 10 && tiempo >= 0) {
          tiempo--;

          if (tiempo == 7) {
            colorNumero = Colors.transparent;
          }
          if (tiempo == 0) {
            globals.win = 0;
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
    });
  }

  //TIMER QUE EMPEZARÁ EL JUEGO Y ELIMINA LA GUÍA
  late Timer timerGame;
  void startGame() {
    int game = 0;
    const oneSec = Duration(milliseconds: 1200);
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

//timer para cuando acabas el minijuego ganes o pierdas, vaya al siguiente minijuego
  void startTimerPato() {
    const oneSec = Duration(seconds: 2);
    timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        contNext++;

        if (contNext == 4) {
          //Navigator.of(context).pushNamed("/inGame");
        }
      });
    });
  }

  void btnTiempo() {
    setState(() {
      if (tiempo == random) {
        print("Acierto");
        colorNumero = Colors.yellow;
        colorTexto = Colors.transparent;
        timer.cancel();
        topPato = 250;
        leftPato = 70;
        imgpato = AssetImage("assets/images/reloj/final-pato.gif");
        globals.win = 1;
        if (globals.gameMode == 1) {
          Navigator.of(context).pushNamed("/inGame");
        } else if (globals.gameMode == 2) {
          Navigator.of(context).pushNamed("/inGame");
        } else if (globals.gameMode == 3) {
          Navigator.of(context).pushNamed("/gallery");
        }
        startTimerPato();
      } else {
        print("Fallo");
        colorNumero = Colors.yellow;
        colorTexto = Colors.transparent;
        timer.cancel();
        topPato = 250;
        leftPato = 70;
        imgpato = AssetImage("assets/images/reloj/final-pato-sad.gif");
        globals.win = 0;
        if (globals.gameMode == 1) {
          Navigator.of(context).pushNamed("/inGame");
        } else if (globals.gameMode == 2) {
          //ONLINE: SE TIENE QUE CAMBIAR LUEGO LA CLASE A LA ESPECIFICA DEL ONLINE
          Navigator.of(context).pushNamed("/inGameOnline");
        } else if (globals.gameMode == 3) {
          Navigator.of(context).pushNamed("/gallery");
        }
        startTimerPato();
      }
    });
  }
}
