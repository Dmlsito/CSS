import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:animate_do/animate_do.dart';
import "package:proyecto/globals.dart" as globals;

class Roulette extends StatefulWidget {
  const Roulette({super.key});

  @override
  State<Roulette> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  StreamController<int> controller = StreamController<int>();
  int numeroResultante = 0;
  int numeroApostado = 0;
  int tiempoFinal = 3;
  double leftGuide = 40;
  bool numeroSeleccionado = false;
  bool isDisabled = false;
  bool verImagenFinal = false;
  late Timer timerFinal;

  int game = 0;
  late Timer timerGame;

  @override
  void initState() {
    super.initState();
    startGame();
    // temporizadorInicio();
  }

  void temporizadorMesajeFinal() {
    const oneSec = Duration(seconds: 1);
    timerFinal = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          verImagenFinal = true;
          tiempoFinal--;
        });
        if (tiempoFinal == 0) {
          verImagenFinal = false;
          finJuego();
          timer.cancel();
        }
      },
    );
  }

  void startGame() {
    const oneSec = Duration(milliseconds: 1500);
    timerGame = Timer.periodic(
      oneSec,
      (Timer timerGame) {
        if (game == 0) {
          setState(() {
            leftGuide = 500;
            game++;
          });
        } else {
          timerGame.cancel();
        }
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
                image: AssetImage("assets/images/roulette/tapete.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: screenHeight * 0.1),
              width: screenWidth * 0.9,
              child: FortuneWheel(
                physics: CircularPanPhysics(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                ),
                animateFirst: false,
                onAnimationStart: () {
                  setState(() {
                    isDisabled = true;
                  });
                },
                onAnimationEnd: () {
                  setState(() {
                    isDisabled = false;
                    temporizadorMesajeFinal();
                  });
                },
                onFling: isDisabled
                    ? null
                    : () {
                        if (numeroSeleccionado) {
                          generarNumeroTirada();
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("¡Atención!"),
                              content: const Text(
                                  "Debes seleccionar un número antes de girar la ruleta."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Aceptar"),
                                )
                              ],
                            ),
                          );
                        }
                      },
                selected: controller.stream,
                indicators: const [
                  FortuneIndicator(
                    alignment: Alignment.topCenter,
                    child: TriangleIndicator(
                      color: Colors.amber,
                    ),
                  ),
                ],
                items: const [
                  FortuneItem(
                    child: Text("     0",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    style: FortuneItemStyle(
                        color: Colors.red,
                        borderColor: Colors.white,
                        borderWidth: 3),
                  ),
                  FortuneItem(
                    child: Text("     1",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    style: FortuneItemStyle(
                        color: Colors.black,
                        borderColor: Colors.white,
                        borderWidth: 3),
                  ),
                  FortuneItem(
                    child: Text("     2",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    style: FortuneItemStyle(
                        color: Colors.red,
                        borderColor: Colors.white,
                        borderWidth: 3),
                  ),
                  FortuneItem(
                    child: Text("     3",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    style: FortuneItemStyle(
                        color: Colors.black,
                        borderColor: Colors.white,
                        borderWidth: 3),
                  ),
                  FortuneItem(
                    child: Text("     4",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    style: FortuneItemStyle(
                      color: Colors.red,
                      borderColor: Colors.white,
                      borderWidth: 3,
                    ),
                  ),
                  FortuneItem(
                    child: Text("     5",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    style: FortuneItemStyle(
                        color: Colors.black,
                        borderColor: Colors.white,
                        borderWidth: 3),
                  ),
                  FortuneItem(
                    child: Text("     6",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    style: FortuneItemStyle(
                        color: Colors.red,
                        borderColor: Colors.white,
                        borderWidth: 3),
                  ),
                  FortuneItem(
                    child: Text("     7",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    style: FortuneItemStyle(
                      color: Colors.black,
                      borderColor: Colors.white,
                      borderWidth: 3,
                    ),
                  ),
                  FortuneItem(
                    child: Text("     8",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    style: FortuneItemStyle(
                        color: Colors.red,
                        borderColor: Colors.white,
                        borderWidth: 3),
                  ),
                  FortuneItem(
                    child: Text("     9",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    style: FortuneItemStyle(
                        color: Colors.black,
                        borderColor: Colors.white,
                        borderWidth: 3),
                  ),
                ],
              ),
            ),
          ),
          // Matriz de botones numéricos
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.62),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    globals.textoConBorde("Número apostado: $numeroApostado",
                        26, 4, Colors.white, Colors.black),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: isDisabled
                          ? null
                          : () {
                              setState(() {
                                numeroSeleccionado = true;
                                numeroApostado = 0;
                              });
                            },
                      child: const Text(
                        "0",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: isDisabled
                          ? null
                          : () {
                              setState(() {
                                numeroSeleccionado = true;
                                numeroApostado = 1;
                              });
                            },
                      child: const Text(
                        "1",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: isDisabled
                          ? null
                          : () {
                              setState(() {
                                numeroSeleccionado = true;
                                numeroApostado = 2;
                              });
                            },
                      child: const Text(
                        "2",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: isDisabled
                          ? null
                          : () {
                              setState(() {
                                numeroSeleccionado = true;
                                numeroApostado = 3;
                              });
                            },
                      child: const Text(
                        "3",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: isDisabled
                          ? null
                          : () {
                              setState(() {
                                numeroSeleccionado = true;
                                numeroApostado = 4;
                              });
                            },
                      child: const Text(
                        "4",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: isDisabled
                          ? null
                          : () {
                              setState(() {
                                numeroSeleccionado = true;
                                numeroApostado = 5;
                              });
                            },
                      child: const Text(
                        "5",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: isDisabled
                          ? null
                          : () {
                              setState(() {
                                numeroSeleccionado = true;
                                numeroApostado = 6;
                              });
                            },
                      child: const Text(
                        "6",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: isDisabled
                          ? null
                          : () {
                              setState(() {
                                numeroSeleccionado = true;
                                numeroApostado = 7;
                              });
                            },
                      child: const Text(
                        "7",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: isDisabled
                          ? null
                          : () {
                              setState(() {
                                numeroSeleccionado = true;
                                numeroApostado = 8;
                              });
                            },
                      child: const Text(
                        "8",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: isDisabled
                          ? null
                          : () {
                              setState(() {
                                numeroSeleccionado = true;
                                numeroApostado = 9;
                              });
                            },
                      child: const Text(
                        "9",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: isDisabled
                        ? null
                        : () {
                            setState(() {
                              if (numeroSeleccionado) {
                                generarNumeroTirada();
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("¡Atención!"),
                                    content: const Text(
                                        "Debes seleccionar un número antes de girar la ruleta."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Aceptar"),
                                      )
                                    ],
                                  ),
                                );
                              }
                            });
                          },
                    child: globals.textoConBorde(
                        "Girar ruleta", 16, 3, Colors.white, Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: verImagenFinal,
            child: Center(
              child: FadeIn(
                duration: const Duration(seconds: 1),
                child: Image(image: AssetImage(mostrarImagenFinal())),
              ),
            ),
          ),
          AnimatedPositioned(
            top: screenHeight * 0.45,
            left: leftGuide,
            duration: const Duration(milliseconds: 500),
            child: globals.textoConBorde(
                "Apuesta por un número !", 35, 5, Colors.white, Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.01),
                width: screenWidth * 0.9,
                child: JelloIn(
                  duration: const Duration(seconds: 2),
                  child: const Image(
                      image: AssetImage(
                          "assets/images/roulette/luckynumbers.png")),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void generarNumeroTirada() {
    numeroResultante = Random().nextInt(10);
    controller.add(numeroResultante);
    numeroSeleccionado = false;
  }

  String mostrarImagenFinal() {
    String rutaImagenFinal = "";

    if (numeroApostado == numeroResultante) {
      rutaImagenFinal = "assets/images/roulette/youwinclassic.png";
    } else {
      rutaImagenFinal = "assets/images/roulette/youtried.gif";
    }

    return rutaImagenFinal;
  }

  void finJuego() {
    if (numeroApostado == numeroResultante) {
      globals.win = 1;
      cargarPantallaModoJuego();
    } else {
      cargarPantallaModoJuego();
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
