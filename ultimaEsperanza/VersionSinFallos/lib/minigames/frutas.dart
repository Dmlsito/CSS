import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import "package:proyecto/globals.dart" as globals;

void frutas() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'mainMenu',
      home: SegundaFrutas(),
    );
  }
}

class SegundaFrutas extends StatefulWidget {
  TerceraFrutas createState() => TerceraFrutas();
}

class TerceraFrutas extends State<SegundaFrutas> {
  var size, heightA, widthA;
  String primerDrag = "assets/images/frutas/peach.png";
  String rutaTexto = "assets/images/frutas/10.png";
  int frutasRestantes = 10;
  int miniGameTime = 6;

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
                  image: AssetImage("assets/images/frutas/bg.png"),
                  fit: BoxFit.fitHeight)),
          child: Stack(
            children: [
              Positioned(
                  top: 60,
                  left: 13,
                  child: Container(
                    height: 170 * 0.27,
                    width: 1383 * 0.27,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(rutaTexto),
                    )),
                  )),

              //CAJA DE MELOCOTONES
              Positioned(
                top: 160,
                left: 20,
                child: DragTarget<String>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                      height: 406 * 0.35,
                      width: 490 * 0.35,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/images/frutas/peachBox.png"),
                      )),
                    );
                  },
                  onAccept: (String data) {
                    if (data == "assets/images/frutas/peach.png") {
                      randomFrutas();
                      guardarFruta();
                    } else {
                      globals.win = 0;
                      Navigator.of(context).pushNamed("/inGame");
                    }
                  },
                ),
              ),

              //CAJA DE PLATANOS
              Positioned(
                top: 160,
                left: 215,
                child: DragTarget<String>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                      height: 406 * 0.35,
                      width: 490 * 0.35,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/images/frutas/bananaBox.png"),
                      )),
                    );
                  },
                  onAccept: (String data) {
                    if (data == "assets/images/frutas/banana.png") {
                      randomFrutas();
                      guardarFruta();
                    } else {
                      globals.win = 0;
                      Navigator.of(context).pushNamed("/inGame");
                    }
                  },
                ),
              ),

              //CAJA DE CEREZAS
              Positioned(
                top: 340,
                left: 20,
                child: DragTarget<String>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                      height: 406 * 0.35,
                      width: 490 * 0.35,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/images/frutas/cherryBox.png"),
                      )),
                    );
                  },
                  onAccept: (String data) {
                    if (data == "assets/images/frutas/cherry.png") {
                      randomFrutas();
                      guardarFruta();
                    } else {
                      globals.win = 0;
                      Navigator.of(context).pushNamed("/inGame");
                    }
                  },
                ),
              ),

              //CAJA DE PERAS
              Positioned(
                top: 340,
                left: 215,
                child: DragTarget<String>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                      height: 406 * 0.35,
                      width: 490 * 0.35,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/images/frutas/pearBox.png"),
                      )),
                    );
                  },
                  onAccept: (String data) {
                    if (data == "assets/images/frutas/pear.png") {
                      randomFrutas();
                      guardarFruta();
                    } else {
                      globals.win = 0;
                      Navigator.of(context).pushNamed("/inGame");
                    }
                  },
                ),
              ),

              //PRIMER DRAGGABLE
              Positioned(
                left: 140,
                top: 590,
                child: Draggable<String>(
                  data: primerDrag,
                  child: Container(
                    height: 350 * 0.3,
                    width: 350 * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(primerDrag),
                    )),
                  ),
                  feedback: Container(
                    height: 350 * 0.3,
                    width: 350 * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(primerDrag),
                    )),
                  ),
                  childWhenDragging: Container(
                    height: 350 * 0.3,
                    width: 350 * 0.3,
                  ),
                ),
              ),

              AnimatedPositioned(
                  top: heightA * 0.5 - ((102 * 0.37 / 2)),
                  // left: widthA*0.5-((854*0.37)/2),
                  left: leftGuide,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/frutas/guide.png"),
                            fit: BoxFit.fitWidth)),
                    width: 867 * 0.37,
                    height: 102 * 0.37,
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
          )),
    );
  }

  //FUNCIONES

  void guardarFruta() {
    frutasRestantes--;
    setState(() {
      if (frutasRestantes == 10) {
        rutaTexto = "assets/images/frutas/10.png";
      } else if (frutasRestantes == 9) {
        rutaTexto = "assets/images/frutas/9.png";
      } else if (frutasRestantes == 8) {
        rutaTexto = "assets/images/frutas/8.png";
      } else if (frutasRestantes == 7) {
        rutaTexto = "assets/images/frutas/7.png";
      } else if (frutasRestantes == 6) {
        rutaTexto = "assets/images/frutas/6.png";
      } else if (frutasRestantes == 5) {
        rutaTexto = "assets/images/frutas/5.png";
      } else if (frutasRestantes == 4) {
        rutaTexto = "assets/images/frutas/4.png";
      } else if (frutasRestantes == 3) {
        rutaTexto = "assets/images/frutas/3.png";
      } else if (frutasRestantes == 2) {
        rutaTexto = "assets/images/frutas/2.png";
      } else if (frutasRestantes == 1) {
        rutaTexto = "assets/images/frutas/1.png";
      } else {
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
      }
    });
  }

  //FUNCION PARA DAR VALOR A LOS DRAGGABLE, ES DECIR, UNA FRUTA RANDOM
  void randomFrutas() {
    setState(() {
      var intValue = Random().nextInt(4); // Value is >= 0 and < 3.
      if (intValue == 0) {
        primerDrag = "assets/images/frutas/peach.png";
      } else if (intValue == 1) {
        primerDrag = "assets/images/frutas/banana.png";
      } else if (intValue == 2) {
        primerDrag = "assets/images/frutas/cherry.png";
      } else {
        primerDrag = "assets/images/frutas/pear.png";
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomFrutas();
    startGame();
    //playFile("menu.mp3");
  }

  //TIMER QUE EMPEZARÁ EL JUEGO Y ELIMINA LA GUÍA
  double leftGuide = 50;
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
          //TIMER EMPEZAR JUEGO
          miniGametick();
          timerGame.cancel();
        }
      },
    );
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

          if (globals.gameMode == 1) {
            Navigator.of(context).pushNamed("/inGame");
          } else if (globals.gameMode == 2) {
            //ONLINE: SE TIENE QUE CAMBIAR LUEGO LA CLASE A LA ESPECIFICA DEL ONLINE
            Navigator.of(context).pushNamed("/inGameOnline");
          } else if (globals.gameMode == 3) {
            Navigator.of(context).pushNamed("/gallery");
          }

          miniGameTickTimer.cancel();
        }
      },
    );
  }
}
