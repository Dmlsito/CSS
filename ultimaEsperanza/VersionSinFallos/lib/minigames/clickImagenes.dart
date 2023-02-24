import 'dart:async';
import 'dart:math';
import "package:proyecto/globals.dart" as globals;
import 'package:flutter/material.dart';
// El juego trata de aguantar todo el tiempo del timer mientras se hace click en las imagenes aleatorias. //

class clickImagenes extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Scaffold(
      body: Container(child: StatesApp()),
    );
  }
}

class StatesApp extends StatefulWidget {
  @override
  StatesAppState createState() => StatesAppState();
}

class StatesAppState extends State<StatesApp> {
  // Variables para poner una posicion aleatoria //
  var size;
  var alturaPantalla;
  var anchoPantalla;
  int start = 5;
  double y = 0;
  double x = 0;
  String rutaImagen = "assets/images/clickImagenes/p10.png";
  int contadorImagenes = 10;
  double leftGuide = 50;
  int game = 0;
  String rutaFinal = "assets/images/clickImagenes/p10.png";
  double alturaFinal = 900;
  bool playing = true;

  @override
  Widget build(BuildContext context) {
    setState(() {
      // Recojo valores de la pantalla
      size = MediaQuery.of(context).size;
      alturaPantalla = size.height;
      anchoPantalla = size.width;
    });

    return Scaffold(
        body: Container(
            height: alturaPantalla,
            width: anchoPantalla,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/clickImagenes/fondoMario.jpg"),
                    fit: BoxFit.fitHeight)),
            child: Stack(
              children: [
                // Aqui van las imagenes en posiciones aleatorias para que sean clickadas
                Visibility(
                  child: Positioned(
                    top: y,
                    left: x,
                    child: InkWell(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                              "assets/images/clickImagenes/ImagenAleatoria.png"),
                        )),
                      ),
                      onTap: () {
                        if (playing) {
                          setState(() {
                            Random rnd = new Random();
                            y = (rnd.nextDouble() * alturaPantalla * 0.6);
                            x = (rnd.nextDouble() * anchoPantalla * 0.85) - 15;
                            // Actualizo las veces que el usuario ha clickado en la imagen aleatoria
                            if (contadorImagenes > 0) {
                              contadorImagenes--;
                            }
                            print(contadorImagenes);
                            cambioImagen();
                          });
                        }
                      },
                    ),
                  ),
                ),
                // Aqui algo grafico mostrando el tiempo que queda.
                Positioned(
                    top: alturaPantalla * 0.70,
                    width: anchoPantalla,
                    child: Container(
                      height: alturaPantalla * 0.3,
                      width: anchoPantalla,
                      child: Container(
                        width: 1094 * 0.3,
                        height: 187 * 0.3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(rutaImagen),
                        )),
                      ),
                      // decoration: BoxDecoration(color: Colors.deepOrange),
                    )),
                Positioned(
                    top: 750,
                    left: 350,
                    child: globals.textoConBorde(
                        start.toString(), 40, 6, Colors.white, Colors.black)
                    // Text(start.toString(), style: TextStyle(color:Colors.white, fontSize: 40 ),),
                    ),
                AnimatedPositioned(
                    // altura de la pantalla por la mitad - la mitad de la altura de la imagen
                    top: alturaPantalla * 0.5 - ((98 * 0.37 / 2)),
                    // left: widthA0.5-((8540.37)/2),
                    left: leftGuide,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/clickImagenes/guide3.png"),
                              fit: BoxFit.fitWidth)),
                      width: 660 * 0.37,
                      height: 98 * 0.37,
                    )),
                // Animación de victoria o derrota
                AnimatedPositioned(
                    height: alturaPantalla * 0.4,
                    width: anchoPantalla * 0.6,
                    // altura de la pantalla por la mitad - la mitad de la altura de la imagen
                    top: alturaFinal,
                    left: 60,
                    duration: const Duration(milliseconds: 400),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(rutaFinal),
                              fit: BoxFit.fitWidth)),
                      width: 660 * 0.37,
                      height: 98 * 0.37,
                    )),
              ],
            )));
  }

  String cambioImagen() {
    setState(() {
      if (contadorImagenes == 9) {
        rutaImagen = "assets/images/clickImagenes/p9.png";
      } else if (contadorImagenes == 8) {
        rutaImagen = "assets/images/clickImagenes/p8.png";
      } else if (contadorImagenes == 7) {
        rutaImagen = "assets/images/clickImagenes/p7.png";
      } else if (contadorImagenes == 6) {
        rutaImagen = "assets/images/clickImagenes/p6.png";
      } else if (contadorImagenes == 5) {
        rutaImagen = "assets/images/clickImagenes/p5.png";
      } else if (contadorImagenes == 4) {
        rutaImagen = "assets/images/clickImagenes/p4.png";
      } else if (contadorImagenes == 3) {
        rutaImagen = "assets/images/clickImagenes/p3.png";
      } else if (contadorImagenes == 2) {
        rutaImagen = "assets/images/clickImagenes/p2.png";
      } else if (contadorImagenes == 1) {
        rutaImagen = "assets/images/clickImagenes/p1.png";
      }
      // Png transparente para que no se vea la imagen al finalizar //s
      else {
        // Cambiar top del animatedPositioned que sale al ganar
        setState(() {
          timer1.cancel();
          globals.win = 1;
          //rutaFinal = "assets/images/karate/karateFail.png";
          rutaFinal = "assets/images/clickImagenes/marioWin.png";
          playing = false;
          alturaFinal = alturaPantalla * 0.3;
          startTimerSiguiente();
        });
      }
    });
    return rutaImagen;
  }

  late Timer timer1;
  void startTimer() {
    const segundos = Duration(seconds: 1);
    timer1 = Timer.periodic(segundos, (Timer timer1) {
      if (start > 0) {
        setState(() {
          start--;
        });
      } else if (start == 0) {
        // Aquí va la animación de juego terminado

        timer1.cancel();
        setState(() {
          globals.win = 0;
          //rutaFinal = "assets/images/karate/karateFail.png";
          rutaFinal = "assets/images/clickImagenes/marioDefeat.png";
          playing = false;
          alturaFinal = alturaPantalla * 0.3;
          startTimerSiguiente();
        });
      }
    });
  }

  late Timer timerGame;

  void startGame() {
    const oneSec = Duration(milliseconds: 900);
    timerGame = Timer.periodic(
      oneSec,
      (Timer timerGame) {
        if (game == 0) {
          setState(() {
            game++;
          });
        } else if (game == 1) {
          setState(() {
            leftGuide = 500;
            game++;
          });
        } else {
          startTimer();
          //TIMER EMPEZAR JUEGO
          timerGame.cancel();
        }
      },
    );
  }

  late Timer timerSiguienteClase;

  void startTimerSiguiente() {
    const oneSec = Duration(milliseconds: 1000);
    timerSiguienteClase = Timer.periodic(
      oneSec,
      (Timer timerSiguienteClase) {
        // Para volver a la clase de historia //
        if (globals.gameMode == 1) {
          Navigator.of(context).pushNamed("/inGame");

          // Para volver a la clase Online //
        } else if (globals.gameMode == 2) {
          Navigator.of(context).pushNamed("/inGameOnline");

          // Para volver a la clase Galeria //
        } else if (globals.gameMode == 3) {
          Navigator.of(context).pushNamed("/gallery");
        }

        timerSiguienteClase.cancel();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }
}
