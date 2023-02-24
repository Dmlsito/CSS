import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import "package:proyecto/globals.dart" as globals;

//JUEGO NO FINALIZADO, MUY AVANZADO, POCOS RETOQUES RESTANTES

void simon() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Menu',
      home: SegundaSimon(),
    );
  }
}

class SegundaSimon extends StatefulWidget {
  TerceraSimon createState() => TerceraSimon();
}

class TerceraSimon extends State<SegundaSimon> {
  var size, heightA, widthA;

  //string con la ruta de la imagen del simon sin luces
  String rutaSimon = "assets/images/simon/simonEmpty.png";
  //string con la ruta del boton rojo
  String rutaRed = "assets/images/simon/buttonRed.png";
  //string con la ruta del boton rojo
  String rutaGreen = "assets/images/simon/buttonGreen.png";
  //string con la ruta del boton rojo
  String rutaYellow = "assets/images/simon/buttonYellow.png";
  //string con la ruta del boton rojo
  String rutaBlue = "assets/images/simon/buttonBlue.png";

  //string con la ruta de la imagen que sale si ganas o pierdes
  String rutaEnding = "assets/images/simon/gg.png";

  bool inGame = false;
  int click = 0;

  double leftEnding = -360;
  double leftGuide = 50;

  int miniGameTime = 5;

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
                image: AssetImage("assets/images/simon/greyBG.png"),
                fit: BoxFit.fitHeight)),

        child: Stack(
          children: [
            Positioned(
                top: 60,
                left: 60,
                child: Container(
                  height: 295,
                  width: 295,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(rutaSimon), fit: BoxFit.fitWidth)),
                )),

            //BOTON PULSABLE VERDE
            Positioned(
                top: 400,
                left: 70,
                child: InkWell(
                  onTap: (() {
                    if (inGame == true) {
                      setState(() {
                        rutaSimon = "assets/images/simon/simonGreen.png";
                        resetImage();

                        playerGuess = playerGuess + "green";
                        playFile("beep3.mp3");
                        timerPress("green");
                        numberClicks();
                      });
                    }
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(rutaGreen),
                            fit: BoxFit.fitWidth)),
                    width: 338 * 0.37,
                    height: 363 * 0.37,
                  ),
                )),

            //BOTON ROJO
            Positioned(
                top: 400,
                left: 220,
                child: InkWell(
                  onTap: (() {
                    if (inGame == true) {
                      setState(() {
                        rutaSimon = "assets/images/simon/simonRed.png";
                        resetImage();

                        playerGuess = playerGuess + "red";
                        playFile("beep1.mp3");
                        numberClicks();
                        timerPress("red");
                      });
                    }
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(rutaRed), fit: BoxFit.fitWidth)),
                    width: 338 * 0.37,
                    height: 363 * 0.37,
                  ),
                )),

            //BOTON AMARILLO
            Positioned(
                top: 550,
                left: 70,
                child: InkWell(
                  onTap: (() {
                    if (inGame == true) {
                      setState(() {
                        rutaSimon = "assets/images/simon/simonYellow.png";
                        resetImage();

                        playerGuess = playerGuess + "yellow";
                        playFile("beep4.mp3");
                        numberClicks();
                        timerPress("yellow");
                      });
                    }
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(rutaYellow),
                            fit: BoxFit.fitWidth)),
                    width: 338 * 0.37,
                    height: 363 * 0.37,
                  ),
                )),

            //BOTON AZUL
            Positioned(
                top: 550,
                left: 220,
                child: InkWell(
                  onTap: (() {
                    if (inGame == true) {
                      setState(() {
                        rutaSimon = "assets/images/simon/simonBlue.png";
                        resetImage();

                        playerGuess = playerGuess + "blue";
                        playFile("beep2.mp3");
                        numberClicks();
                        timerPress("blue");
                      });
                    }
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(rutaBlue), fit: BoxFit.fitWidth)),
                    width: 338 * 0.37,
                    height: 363 * 0.37,
                  ),
                )),

            AnimatedPositioned(
                top: heightA * 0.5 - ((99 * 0.37 / 2)),
                // left: widthA*0.5-((854*0.37)/2),
                left: leftGuide,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/simon/guide.png"),
                          fit: BoxFit.fitWidth)),
                  width: 854 * 0.37,
                  height: 99 * 0.37,
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

            AnimatedPositioned(
                top: heightA * 0.5 - ((372 * 0.6) * 0.5),
                left: leftEnding,
                duration: Duration(milliseconds: 200),
                child: Container(
                  width: 537 * 0.6,
                  height: 372 * 0.6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(rutaEnding), fit: BoxFit.fitWidth)),
                ))
          ],
        ),
      ),
    );
  }

  //AUDIO PLAYER Y TIMER PARA REINICIAR LA CANCIÓN
  final player = AudioPlayer();
  void playFile(String url) {
    player.play(AssetSource(url));
  }

  //TIMER Y FUNCIONES SIMONSAYS
  //SECUENCIA CORRECTA
  String simonGuess = "";
  //SECUENCIA QUE INTRODUCE EL JUGADOR
  String playerGuess = "";

  late Timer timer;
  int _start = 0;
  int n = 0;

  //TIMMER QUE ACTIVA QUE EL SIMON EMPIECE A FUNCIONAR Y CAMBIEN COLORES del simon
  void startTimer() {
    const oneSec = Duration(milliseconds: 500);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 4) {
          setState(() {
            miniGametick();
            n = 0;
            _start = 0;
            rutaSimon = "assets/images/simon/simonEmpty.png";
            inGame = true;
            timer.cancel();
          });
        } else {
          setState(() {
            var intValue = Random().nextInt(4); // Value is >= 0 and < 10.

            if (intValue == 0) {
              rutaSimon = "assets/images/simon/simonRed.png";
              simonGuess = simonGuess + "red";
              playFile("beep1.mp3");
            } else if (intValue == 1) {
              rutaSimon = "assets/images/simon/simonBlue.png";
              simonGuess = simonGuess + "blue";
              playFile("beep2.mp3");
            } else if (intValue == 2) {
              rutaSimon = "assets/images/simon/simonGreen.png";
              simonGuess = simonGuess + "green";
              playFile("beep3.mp3");
            } else if (intValue == 3) {
              rutaSimon = "assets/images/simon/simonYellow.png";
              simonGuess = simonGuess + "yellow";
              playFile("beep4.mp3");
            }

            n++;
            _start++;
          });
        }
      },
    );
  }

  //funcion que reinicia la imagen del simon despues de pulsar un boton
  late Timer timerReset;
  void resetImage() {
    const oneSec = Duration(milliseconds: 200);
    timerReset = Timer.periodic(
      oneSec,
      (Timer timerReset) {
        rutaSimon = "assets/images/simon/simonEmpty.png";
        timerReset.cancel();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startGame();
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
            startTimer();
            leftGuide = 500;
            game++;
          });
        } else {
          //TIMER EMPEZAR JUEGO
          timerGame.cancel();
        }
      },
    );
  }

  late Timer timerEnding;
  void imagenEnding(String ruta) {
    int n = 0;
    const oneSec = Duration(milliseconds: 700);
    timerEnding = Timer.periodic(
      oneSec,
      (Timer timerEnding) {
        if (n == 0) {
          setState(() {
            rutaEnding = ruta;
            leftEnding = 45;
          });
        }
        if (n == 2) {
          timerEnding.cancel();
          if (ruta.contains("gg")) {
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
            globals.win = 0;
            if (globals.gameMode == 1) {
              Navigator.of(context).pushNamed("/inGame");
            } else if (globals.gameMode == 2) {
              //ONLINE: SE TIENE QUE CAMBIAR LUEGO LA CLASE A LA ESPECIFICA DEL ONLINE
              Navigator.of(context).pushNamed("/inGameOnline");
            } else if (globals.gameMode == 3) {
              Navigator.of(context).pushNamed("/gallery");
            }
          }
        } else {
          n++;
        }
      },
    );
  }

  //funcion que cuenta el numero de clicks sobre los botones, al cuarto (ultimo color de la secuencia) comprueba si hemos
  //ganado el minijuego
  void numberClicks() {
    setState(() {
      click++;
      if (click == 4) {
        miniGameTickTimer.cancel();
        inGame = false;

        if (simonGuess == playerGuess) {
          imagenEnding("assets/images/simon/gg.png");
        } else {
          imagenEnding("assets/images/simon/ez.png");
        }

        simonGuess = "";
        playerGuess = "";
        click = 0;
      }
    });
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
          inGame = false;
          imagenEnding("assets/images/simon/ez.png");
          miniGameTickTimer.cancel();
        }
      },
    );
  }

  late Timer timer2;
  int _start2 = 0;
  void timerPress(String s) {
    _start2 = 0;
    const oneSec = Duration(milliseconds: 100);
    timer2 = Timer.periodic(
      oneSec,
      (Timer timer2) {
        if (_start2 == 1) {
          setState(() {
            if (s == "red") {
              rutaRed = "assets/images/simon/buttonRed.png";
            } else if (s == "blue") {
              rutaBlue = "assets/images/simon/buttonBlue.png";
            } else if (s == "yellow") {
              rutaYellow = "assets/images/simon/buttonYellow.png";
            } else if (s == "green") {
              rutaGreen = "assets/images/simon/buttonGreen.png";
            }
            timer2.cancel();
          });
        } else {
          setState(() {
            if (s == "red") {
              rutaRed = "assets/images/simon/buttonRed2.png";
            } else if (s == "blue") {
              rutaBlue = "assets/images/simon/buttonBlue2.png";
            } else if (s == "yellow") {
              rutaYellow = "assets/images/simon/buttonYellow2.png";
            } else if (s == "green") {
              rutaGreen = "assets/images/simon/buttonGreen2.png";
            }
            _start2++;
          });
        }
      },
    );
  }
}
