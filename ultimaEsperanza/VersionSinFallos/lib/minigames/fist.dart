import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import "package:proyecto/globals.dart" as globals;

class SegundaFist extends StatefulWidget {
  TerceraFist createState() => TerceraFist();
}

class TerceraFist extends State<SegundaFist> {
  int miniGameTime = 5;
  //posiciones
  double leftGuide = 50;
  double topFist = -20;
  double leftFist = 100;
  double topKarate = 900;

  Duration duracionFist = Duration(seconds: 1);

  //rutas de imagenes
  String rutaWood = "assets/images/karate/wood.png";
  String rutaKarate = "assets/images/karate/karateJoe.png";

  var size, heightA, widthA;

  @override
  Widget build(BuildContext context) {
    setState(() {
      size = MediaQuery.of(context).size;
      heightA = size.height;
      widthA = size.width;
    });

    return Scaffold(
      //cuerpo principal del menú
      body: Container(
        height: heightA,
        width: widthA,

        //color: Colors.grey,

        //imagen de fondo menú
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/karate/greyBG.png"),
                fit: BoxFit.fitHeight)),

        child: Stack(
          children: [
            //imagen de la madera
            Positioned(
                top: 460,
                left: 55,
                child: Container(
                  width: 1445 * 0.21,
                  height: 619 * 0.21,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(rutaWood), fit: BoxFit.fitHeight)),
                )),

            //imagen del puño
            AnimatedPositioned(
              top: topFist,
              left: leftFist,
              duration: duracionFist,
              child: Container(
                width: 636 * 0.3,
                height: 1178 * 0.3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/karate/fist.png"),
                        fit: BoxFit.fitHeight)),
              ),
              //duration: Duration(milliseconds: 100)
            ),

            //boton de accion
            Positioned(
                left: 110,
                top: 620,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      timerBarra.cancel();
                      timer.cancel();
                      duracionFist = Duration(milliseconds: 100);
                      topFist = 220;
                      romperMadera();
                    });
                  },
                  child: Container(
                    height: 625 * 0.3,
                    width: 625 * 0.3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/karate/romperButton.png"),
                            fit: BoxFit.fitHeight)),
                  ),
                )),

            //karateka que sale si ganas o pierdes
            AnimatedPositioned(
                left: 30,
                top: topKarate,
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: 1775 * 0.37,
                  width: 989 * 0.37,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(rutaKarate),
                          fit: BoxFit.fitHeight)),
                )),

            //barra que sube y baja
            Positioned(
                top: 50,
                left: 350,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Container(
                    width: 270,
                    height: 30,
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      backgroundColor: Color.fromARGB(255, 0, 59, 80),
                      value: valorBarra,
                    ),
                  ),
                )),

            //imagen de la meta de la barra
            Positioned(
                top: 100,
                left: 275,
                child: Container(
                  height: 65 * 0.2,
                  width: 607 * 0.2,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/karate/META.png"),
                          fit: BoxFit.fitHeight)),
                )),

            //'guide' del karate
            AnimatedPositioned(
                top: heightA * 0.5 - ((103 * 0.37 / 2)),
                // left: widthA*0.5-((854*0.37)/2),
                left: leftGuide,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/karate/guide.png"),
                          fit: BoxFit.fitWidth)),
                  width: 712 * 0.37,
                  height: 103 * 0.37,
                )),

            Align(
              alignment: Alignment.bottomRight,
              child: Stack(children: [
                Text(
                  miniGameTime.toString(),
                  style: TextStyle(
                    fontSize: 45,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 10
                      ..color = Colors.black,
                  ),
                ),
                Text(
                  miniGameTime.toString(),
                  style: TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  //TIMER QUE EMPEZARÁ EL JUEGO Y ELIMINA LA GUÍA
  int game = 0;
  late Timer timerGame;
  void startGame() {
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
          miniGametick();
          timerGame.cancel();
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    startGame();
    valueBarra();
  }

  //TIMER Y FUNCIONES SIMONSAYS

  //SECUENCIA CORRECTA
  String simonGuess = "";
  //SECUENCIA QUE INTRODUCE EL JUGADOR
  String playerGuess = "";

  late Timer timer;
  int _start = 0;
  int n = 0;

  //TIMER QUE HACE QUE EL PUÑO SE MUEVA
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (topFist == -20) {
          setState(() {
            topFist = topFist + 20;
          });
        } else if (topFist == 0) {
          setState(() {
            topFist = -20;
          });
        }
      },
    );
  }

  double valorBarra = 0;
  bool boolBarra = true;
  late Timer timerBarra;

  void valueBarra() {
    const oneSec = Duration(milliseconds: 32);
    timerBarra = Timer.periodic(
      oneSec,
      (Timer timerBarra) {
        if (valorBarra < 0.1) {
          boolBarra = true;
        } else if (valorBarra > 0.9) {
          boolBarra = false;
        }

        if (boolBarra == false) {
          setState(() {
            valorBarra = valorBarra - 0.1;
          });
        } else {
          setState(() {
            valorBarra = valorBarra + 0.1;
          });
        }
      },
    );
  }

  int start2 = 0;
  late Timer timer2;
  //timer que sale al pulsar el boton de romper
  void romperMadera() {
    const oneSec = Duration(milliseconds: 200);
    timer2 = Timer.periodic(
      oneSec,
      (Timer timer2) {
        if (valorBarra >= 0.8) {
          if (start2 == 0) {
            setState(() {
              rutaWood = "assets/images/karate/brokenWood.png";
            });
            start2++;
          } else if (start2 == 3) {
            setState(() {
              topKarate = 380;
            });
            start2++;
          } else if (start2 == 8) {
            timer2.cancel();
            miniGameTickTimer.cancel();
            globals.win = 1;

            if (globals.gameMode == 1) {
              Navigator.of(context).pushNamed("/inGame");
            } else if (globals.gameMode == 2) {
              //ONLINE: SE TIENE QUE CAMBIAR LUEGO LA CLASE A LA ESPECIFICA DEL ONLINE
              Navigator.of(context).pushNamed("/inGameOnline");
            } else if (globals.gameMode == 3) {
              Navigator.of(context).pushNamed("/gallery");
            }
          } else {
            start2++;
          }
        } else {
          rutaKarate = "assets/images/karate/karateFail.png";
          if (start2 == 0) {
            start2++;
          } else if (start2 == 3) {
            setState(() {
              topKarate = 380;
            });
            start2++;
          } else if (start2 == 8) {
            timer2.cancel();
            miniGameTickTimer.cancel();
            globals.win = 0;

            if (globals.gameMode == 1) {
              Navigator.of(context).pushNamed("/inGame");
            } else if (globals.gameMode == 2) {
              //ONLINE: SE TIENE QUE CAMBIAR LUEGO LA CLASE A LA ESPECIFICA DEL ONLINE
              Navigator.of(context).pushNamed("/inGameOnline");
            } else if (globals.gameMode == 3) {
              Navigator.of(context).pushNamed("/gallery");
            }
          } else {
            start2++;
          }
        }
      },
    );
  }

  late Timer miniGameTickTimer;
  void miniGametick() {
    const oneSec = Duration(seconds: 1);
    miniGameTickTimer = Timer.periodic(
      oneSec,
      (Timer miniGameTickTimer) {
        if (miniGameTime > 0) {
          setState(() {
            miniGameTime--;
          });
        } else {
          globals.win = 0;
          Navigator.of(context).pushNamed("/inGame");
          miniGameTickTimer.cancel();
        }
      },
    );
  }
}
