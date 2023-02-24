import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import "package:proyecto/globals.dart" as globals;

class Pipes extends StatefulWidget {
  const Pipes({super.key});

  @override
  State<Pipes> createState() => _PipesState();
}

class _PipesState extends State<Pipes> {
  // Variables, timer, funciones, initState...

  List<String> puzzleSeleccionado = [];
  late Timer _timer;
  int index = 0;
  int tiempoRestante = 20;
  int tiempoRestanteMensaje = 5;
  int tiempoInicio = 5;
  double leftGuide = 40;

  bool bloqueoTuberias = true;
  bool puzzleCompletado = false;
  bool partidaFinalizada = false;
  int opcionPuzzle = 0;

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  void initState() {
    super.initState();
    opcionPuzzle = random(1, 4);
    seleccionarPuzzle();
    puzzleSeleccionado;
    startGame();
    // temporizadorInicio();
  }

  //TIMER QUE EMPEZARÁ EL JUEGO Y ELIMINA LA GUÍA
  int game = 0;
  late Timer timerGame;

  void startGame() {
    const oneSec = Duration(milliseconds: 1100);
    timerGame = Timer.periodic(
      oneSec,
      (Timer timerGame) {
        if (game == 0) {
          setState(() {
            leftGuide = 500;
            game++;
          });
        } else {
          bloqueoTuberias = false;
          temporizadorJuego();
          timerGame.cancel();
        }
      },
    );
  }

  // Temporizador
  // void temporizadorInicio() {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //         (Timer timer) {
  //       setState(() {
  //         tiempoInicio--;
  //       });
  //       if (tiempoInicio == 0) {
  //         verImagenInicial = false;
  //         timer.cancel();
  //         temporizador();
  //       }
  //     },
  //   );
  // }

  void temporizadorJuego() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timerJuego) {
        setState(() {
          tiempoRestante--;
        });
        if (tiempoRestante == 0) {
          partidaFinalizada = true;
          timerJuego.cancel();
          temporizadorMensaje();
        }
      },
    );
  }

  void temporizadorMensaje() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timerMensaje) {
        setState(() {
          if (partidaFinalizada) {
            tiempoRestanteMensaje--;
          }
          if (tiempoRestanteMensaje == 0) {
            if (puzzleCompletado) {
              timerMensaje.cancel();
              partidaFinalizada = false;
              globals.win = 1;
              cargarPantallaModoJuego();
            } else {
              timerMensaje.cancel();
              partidaFinalizada = false;
              globals.win = 0;
              cargarPantallaModoJuego();
            }
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/pipes/background4.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.05),
                      child: Image(
                        width: screenWidth * 0.42,
                        image: AssetImage("assets/images/pipes/deposito.png"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: screenHeight * 0.17, left: screenWidth * 0.4),
                      child: Image(
                        width: screenWidth * 0.165,
                        image: AssetImage("assets/images/pipes/bomba_agua.png"),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.065),
                  child: SizedBox(
                    height: screenHeight * 0.5,
                    child: GridView.count(
                      crossAxisCount: 5,
                      children: List.generate(
                        puzzleSeleccionado.length,
                        (index) {
                          return InkWell(
                            child: Container(
                              margin: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                color: cambiarBgColorpuzzleTuberias2(index),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                image: DecorationImage(
                                  image: AssetImage(
                                      puzzleSeleccionado.elementAt(index)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(
                                () {
                                  if (!partidaFinalizada && !bloqueoTuberias) {
                                    rotarTuberias(index);
                                    comprobarResultado();
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: screenHeight * 0.01, left: screenWidth * 0.03),
            child: globals.textoConBorde(
                tiempoRestante.toString(), 30, 4, Colors.white, Colors.black),
          ),
          Container(
            margin: EdgeInsets.only(
                top: screenHeight * 0.242, left: screenWidth * 0.073),
            child: Image(
              width: screenWidth * 0.054,
              image: AssetImage("assets/images/pipes/blockPipe.png"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: screenHeight * 0.253, left: screenWidth * 0.875),
            child: Image(
              width: screenWidth * 0.05,
              image: AssetImage("assets/images/pipes/1n.png"),
            ),
          ),
          Visibility(
            visible: partidaFinalizada,
            child: Center(
              child: JelloIn(
                duration: const Duration(seconds: 5),
                child: Image(image: AssetImage(mostrarImagenFinal())),
              ),
            ),
          ),
          AnimatedPositioned(
            top: screenHeight * 0.45,
            left: leftGuide,
            duration: const Duration(milliseconds: 500),
            child: globals.textoConBorde(
                "Conecta las tuberías !", 35, 5, Colors.white, Colors.black),
          ),
          // Visibility(
          //   visible: verImagenInicial,
          //   child: Center(
          //     child: Bounce(
          //       duration: const Duration(seconds: 2),
          //       child:
          //           Image(image: AssetImage(mostrarImagenInicio())),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Color cambiarBgColorpuzzleTuberias2(index) {
    Color colorBgTuberia = Colors.blueGrey;
    setState(() {
      if (puzzleCompletado) {
        colorBgTuberia = Colors.green[600]!;
      }
    });
    return colorBgTuberia;
  }

  void rotarTuberias(int index) {
    if (puzzleSeleccionado[index] == "assets/images/pipes/1.png") {
      puzzleSeleccionado[index] = "assets/images/pipes/2.png";
    } else if (puzzleSeleccionado[index] == "assets/images/pipes/2.png") {
      puzzleSeleccionado[index] = "assets/images/pipes/1.png";
    } else if (puzzleSeleccionado[index] == "assets/images/pipes/3.png") {
      puzzleSeleccionado[index] = "assets/images/pipes/4.png";
    } else if (puzzleSeleccionado[index] == "assets/images/pipes/4.png") {
      puzzleSeleccionado[index] = "assets/images/pipes/5.png";
    } else if (puzzleSeleccionado[index] == "assets/images/pipes/5.png") {
      puzzleSeleccionado[index] = "assets/images/pipes/6.png";
    } else if (puzzleSeleccionado[index] == "assets/images/pipes/6.png") {
      puzzleSeleccionado[index] = "assets/images/pipes/3.png";
    }
  }

  // String mostrarImagenInicio() {
  //   String rutaImagenInicio = "";
  //
  //   if (tiempoInicio >= 3) {
  //     rutaImagenInicio = "assets/images/pipes/ready.gif";
  //   } else {
  //     rutaImagenInicio = "assets/images/pipes/go.gif";
  //   }
  //
  //   return rutaImagenInicio;
  // }

  String mostrarImagenFinal() {
    String rutaImagenFinal = "";

    if (puzzleCompletado) {
      rutaImagenFinal = "assets/images/pipes/win.gif";
    } else {
      rutaImagenFinal = "assets/images/pipes/gameover.gif";
    }

    return rutaImagenFinal;
  }

  void seleccionarPuzzle() {
    if (opcionPuzzle == 1) {
      puzzleSeleccionado = [
        "assets/images/pipes/6.png", //0
        "assets/images/pipes/4.png", //1
        "assets/images/pipes/3.png", //2
        "assets/images/pipes/2.png", //3
        "assets/images/pipes/1.png", //4
        "assets/images/pipes/6.png", //5
        "assets/images/pipes/5.png", //6
        "assets/images/pipes/2.png", //7
        "assets/images/pipes/3.png", //8
        "assets/images/pipes/4.png", //9
        "assets/images/pipes/5.png", //10
        "assets/images/pipes/4.png", //11
        "assets/images/pipes/6.png", //12
        "assets/images/pipes/4.png", //13
        "assets/images/pipes/3.png", //14
        "assets/images/pipes/4.png", //15
        "assets/images/pipes/5.png", //16
        "assets/images/pipes/2.png", //17
        "assets/images/pipes/3.png", //18
        "assets/images/pipes/2.png", //19
        "assets/images/pipes/3.png", //20
        "assets/images/pipes/1.png", //21
        "assets/images/pipes/5.png", //22
        "assets/images/pipes/6.png", //23
        "assets/images/pipes/5.png", //24
      ];
      //...
    } else if (opcionPuzzle == 2) {
      puzzleSeleccionado = [
        "assets/images/pipes/2.png", //0
        "assets/images/pipes/6.png", //1
        "assets/images/pipes/3.png", //2
        "assets/images/pipes/5.png", //3
        "assets/images/pipes/5.png", //4
        "assets/images/pipes/6.png", //5
        "assets/images/pipes/3.png", //6
        "assets/images/pipes/2.png", //7
        "assets/images/pipes/3.png", //8
        "assets/images/pipes/4.png", //9
        "assets/images/pipes/5.png", //10
        "assets/images/pipes/1.png", //11
        "assets/images/pipes/4.png", //12
        "assets/images/pipes/3.png", //13
        "assets/images/pipes/3.png", //14
        "assets/images/pipes/4.png", //15
        "assets/images/pipes/2.png", //16
        "assets/images/pipes/6.png", //17
        "assets/images/pipes/1.png", //18
        "assets/images/pipes/2.png", //19
        "assets/images/pipes/3.png", //20
        "assets/images/pipes/4.png", //21
        "assets/images/pipes/5.png", //22
        "assets/images/pipes/6.png", //23
        "assets/images/pipes/1.png", //24
      ];
    } else if (opcionPuzzle == 3) {
      puzzleSeleccionado = [
        "assets/images/pipes/4.png", //0
        "assets/images/pipes/1.png", //1
        "assets/images/pipes/5.png", //2
        "assets/images/pipes/6.png", //3
        "assets/images/pipes/5.png", //4
        "assets/images/pipes/6.png", //5
        "assets/images/pipes/1.png", //6
        "assets/images/pipes/3.png", //7
        "assets/images/pipes/2.png", //8
        "assets/images/pipes/3.png", //9
        "assets/images/pipes/6.png", //10
        "assets/images/pipes/3.png", //11
        "assets/images/pipes/1.png", //12
        "assets/images/pipes/5.png", //13
        "assets/images/pipes/6.png", //14
        "assets/images/pipes/4.png", //15
        "assets/images/pipes/5.png", //16
        "assets/images/pipes/5.png", //17
        "assets/images/pipes/4.png", //18
        "assets/images/pipes/2.png", //19
        "assets/images/pipes/3.png", //20
        "assets/images/pipes/1.png", //21
        "assets/images/pipes/5.png", //22
        "assets/images/pipes/5.png", //23
        "assets/images/pipes/6.png", //24
      ];
    }
  }

  void comprobarResultado() {
    switch (opcionPuzzle) {
      case 1:
        if (puzzleSeleccionado[0] == "assets/images/pipes/3.png" &&
            puzzleSeleccionado[1] == "assets/images/pipes/5.png" &&
            puzzleSeleccionado[4] == "assets/images/pipes/1.png" &&
            puzzleSeleccionado[5] == "assets/images/pipes/4.png" &&
            puzzleSeleccionado[6] == "assets/images/pipes/6.png" &&
            puzzleSeleccionado[8] == "assets/images/pipes/4.png" &&
            puzzleSeleccionado[9] == "assets/images/pipes/6.png" &&
            puzzleSeleccionado[10] == "assets/images/pipes/3.png" &&
            puzzleSeleccionado[11] == "assets/images/pipes/5.png" &&
            puzzleSeleccionado[12] == "assets/images/pipes/4.png" &&
            puzzleSeleccionado[13] == "assets/images/pipes/6.png" &&
            puzzleSeleccionado[15] == "assets/images/pipes/4.png" &&
            puzzleSeleccionado[16] == "assets/images/pipes/6.png" &&
            puzzleSeleccionado[17] == "assets/images/pipes/1.png" &&
            puzzleSeleccionado[20] == "assets/images/pipes/3.png" &&
            puzzleSeleccionado[21] == "assets/images/pipes/2.png" &&
            puzzleSeleccionado[22] == "assets/images/pipes/6.png") {
          puzzleCompletado = true;
        }
        break;
      //...

      case 2:
        if (puzzleSeleccionado[0] == "assets/images/pipes/1.png" &&
            puzzleSeleccionado[1] == "assets/images/pipes/4.png" &&
            puzzleSeleccionado[2] == "assets/images/pipes/5.png" &&
            puzzleSeleccionado[3] == "assets/images/pipes/4.png" &&
            puzzleSeleccionado[4] == "assets/images/pipes/6.png" &&
            puzzleSeleccionado[5] == "assets/images/pipes/3.png" &&
            puzzleSeleccionado[6] == "assets/images/pipes/6.png" &&
            puzzleSeleccionado[7] == "assets/images/pipes/1.png" &&
            puzzleSeleccionado[8] == "assets/images/pipes/3.png" &&
            puzzleSeleccionado[9] == "assets/images/pipes/5.png" &&
            puzzleSeleccionado[10] == "assets/images/pipes/4.png" &&
            puzzleSeleccionado[11] == "assets/images/pipes/2.png" &&
            puzzleSeleccionado[12] == "assets/images/pipes/6.png" &&
            puzzleSeleccionado[13] == "assets/images/pipes/4.png" &&
            puzzleSeleccionado[14] == "assets/images/pipes/6.png" &&
            puzzleSeleccionado[15] == "assets/images/pipes/3.png" &&
            puzzleSeleccionado[16] == "assets/images/pipes/2.png" &&
            puzzleSeleccionado[17] == "assets/images/pipes/5.png" &&
            puzzleSeleccionado[18] == "assets/images/pipes/1.png" &&
            puzzleSeleccionado[22] == "assets/images/pipes/3.png" &&
            puzzleSeleccionado[23] == "assets/images/pipes/6.png") {
          puzzleCompletado = true;
        }
        break;

      case 3:
        if (puzzleSeleccionado[0] == "assets/images/pipes/3.png" &&
            puzzleSeleccionado[1] == "assets/images/pipes/2.png" &&
            puzzleSeleccionado[2] == "assets/images/pipes/5.png" &&
            puzzleSeleccionado[3] == "assets/images/pipes/4.png" &&
            puzzleSeleccionado[4] == "assets/images/pipes/6.png" &&
            puzzleSeleccionado[5] == "assets/images/pipes/4.png" &&
            puzzleSeleccionado[6] == "assets/images/pipes/2.png" &&
            puzzleSeleccionado[7] == "assets/images/pipes/6.png" &&
            puzzleSeleccionado[8] == "assets/images/pipes/1.png" &&
            puzzleSeleccionado[10] == "assets/images/pipes/3.png" &&
            puzzleSeleccionado[11] == "assets/images/pipes/5.png" &&
            puzzleSeleccionado[13] == "assets/images/pipes/3.png" &&
            puzzleSeleccionado[14] == "assets/images/pipes/5.png" &&
            puzzleSeleccionado[15] == "assets/images/pipes/4.png" &&
            puzzleSeleccionado[16] == "assets/images/pipes/6.png" &&
            puzzleSeleccionado[17] == "assets/images/pipes/4.png" &&
            puzzleSeleccionado[18] == "assets/images/pipes/5.png" &&
            puzzleSeleccionado[19] == "assets/images/pipes/1.png" &&
            puzzleSeleccionado[20] == "assets/images/pipes/3.png" &&
            puzzleSeleccionado[21] == "assets/images/pipes/2.png" &&
            puzzleSeleccionado[22] == "assets/images/pipes/6.png" &&
            puzzleSeleccionado[23] == "assets/images/pipes/3.png" &&
            puzzleSeleccionado[24] == "assets/images/pipes/6.png") {
          puzzleCompletado = true;
        }
        break;
    }

    if (puzzleCompletado && tiempoRestante > 0) {
      partidaFinalizada = true;
      _timer.cancel();
      temporizadorMensaje();
    }
  }

  void cargarPantallaModoJuego() {
    if (globals.gameMode == 1) {
      Navigator.of(context).pushNamed("/inGame");

      // Para volver a la clase Online //
    } else if (globals.gameMode == 2) {
      Navigator.of(context).pushNamed("/inGameOnline");

      // Para volver a la clase Galeria //
    } else if (globals.gameMode == 3) {
      Navigator.of(context).pushNamed("/gallery");
    }
  }
}
