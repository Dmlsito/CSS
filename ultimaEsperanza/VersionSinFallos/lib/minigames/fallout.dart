// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import "package:proyecto/globals.dart" as globals;

// Variables para la pantalla //
var size;
var alturaPantalla;
var anchoPantalla;

// Posicionamiento de la animacion de entrada //

class fallout extends StatelessWidget {
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
  double leftGuide = 50;
  double leftGuide2 = 0;

// Ruta de la imagen aleatoria del vaultBoy //
  String rutaImagen = "assets/images/Fallout/boyInicial.png";
// Altura para que la animación se esconda //
  double alturaFinal = 900;
// Ruta para la imagen de la animacion //
  String rutaFinal = "assets/images/registro.png";
// Ruta para la imagen de espera del principio //
  String imagenFondoAnimado = "assets/images/Fallout/fondoAnimadoInicio.jpg";
// Esta variable no se esta actualizando //
  int contadorAcierto = 0;
// Valor de la imagen del vaultBoy contra el que juega el usuario //
  int valorImagen = 0;
// Variable para el timer que controla el tiempo de juego //
  int start = 5;
// Variable para el control de la animación de la pantalla de espera //
  late AnimationController bounceController;

  @override
  Widget build(BuildContext context) {
    setState(() {
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
              image: AssetImage("assets/images/Fallout/fondoFallout1.jpg"),
              fit: BoxFit.fitHeight)),
      child: Stack(
        children: [
          // Imagen que va cambiando para mostrar lo que hay que arrastrar //
          DragTarget<int>(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                margin: EdgeInsets.only(left: 20, top: 100),
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(rutaImagen),
                )),
              );
            },
            onAccept: (int data) {
              actualizarContador(data);
            },
          ),

          Positioned(
            top: alturaPantalla * 0.8,
            left: anchoPantalla * 0.1,
            child: Container(
                //margin: EdgeInsets.only(bottom: 50,left: 50),
                child: Row(
              children: [
                // Draggable de piedra //
                Draggable<int>(
                  data: 1,
                  feedback: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/Fallout/piedra.png"))),
                  ),
                  childWhenDragging: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/Fallout/piedra.png"),
                    )),
                  ),
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/Fallout/piedra.png"),
                    )),
                  ),
                ),

                // Draggable papel //
                Draggable<int>(
                  data: 2,
                  feedback: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/Fallout/papel.png"))),
                  ),
                  childWhenDragging: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/Fallout/papel.png"),
                    )),
                  ),
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/Fallout/papel.png"),
                    )),
                  ),
                ),

                // Draggable tijeras //
                Draggable<int>(
                  data: 3,
                  feedback: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/Fallout/tijera.png"))),
                  ),
                  childWhenDragging: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/Fallout/tijera.png"),
                    )),
                  ),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/Fallout/tijera.png"),
                    )),
                  ),
                )
              ],
            )),
          ),

          Positioned(

            top: 50,
            left: 350,
            child: globals.textoConBorde(start.toString(), 45, 5, Colors.white, Colors.black),

          ),
          AnimatedPositioned(
            left: leftGuide2,
            // ignore: sort_child_properties_last
            child: BounceInLeft(
                animate: true,
                controller: (controller) => bounceController = controller,
                from: 300,
                child: Container(
                    height: alturaPantalla,
                    width: anchoPantalla,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imagenFondoAnimado),
                            fit: BoxFit.fitHeight)))),
            duration: const Duration(milliseconds: 500),
          ),

          AnimatedPositioned(
              // altura de la pantalla por la mitad - la mitad de la altura de la imagen
              top: alturaPantalla * 0.6 - ((98 * 0.37 / 2)),
              left: leftGuide,
              duration: const Duration(milliseconds: 1000),
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/Fallout/fraseInicioVault.png"),
                        fit: BoxFit.fitWidth)),
                width: 976 * 0.37,
                height: 84,
              )),
          // AnimatedPositiones referente a la animacion de final //
          AnimatedPositioned(
              // altura de la pantalla por la mitad - la mitad de la altura de la imagen
              top: alturaFinal,
              left: anchoPantalla * 0.22,
              duration: const Duration(milliseconds: 400),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(rutaFinal), fit: BoxFit.fitWidth)),
                width: 500 * 0.5,
                height: 500 * 0.5,
              )),
        ],
      ),
    ));
  }

  // Timer que controla el tiempo de juego //
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
        // Controlo si gana o no, el mayor igual a 1 es simplemente por si arrastra varias veces //
        if (contadorAcierto >= 1) {
          // Cambiar top del animatedPositioned que sale al ganar
          setState(() {
            globals.win = 1;
            rutaFinal = "assets/images/Fallout/winBoy.png";
            alturaFinal = alturaPantalla * 0.3;
            startTimerSiguiente();
          });
        } else if (contadorAcierto == 0) {
          setState(() {
            globals.win = 0;
            rutaFinal = "assets/images/Fallout/loseBoy.png";
            alturaFinal = alturaPantalla * 0.3;
            startTimerSiguiente();
          });
        }
        timer1.cancel();
      }
    });
  }

  late Timer timerGame;

  // TIMER ANIMACION ANTES DEL JUEGO //
  void startGame() {
    int game = 0;
    const oneSec = Duration(milliseconds: 900);
    timerGame = Timer.periodic(
      oneSec,
      (Timer timerGame) {
        if (game == 2) {
          setState(() {
            leftGuide = 500;
            game++;
          });
        } else if (game == 3) {
          //TIMER EMPEZAR JUEGO
          leftGuide2 = 1000;
          startTimer();
          // Timer animación
          timerGame.cancel();
        } else {
          setState(() {
            game++;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    controlarImagenInicio();
    startGame();
  }

  void controlarImagenInicio() {
    //Random random = new Random();
    //int randomValue = random.nextInt(2);
    var intValue = Random().nextInt(3);

    setState(() {
      if (intValue == 0) {
        rutaImagen = "assets/images/Fallout/vaultPiedra.png";
        valorImagen = 1;
      } else if (intValue == 1) {
        rutaImagen = "assets/images/Fallout/vaultPapel.png";
        valorImagen = 2;
      } else if (intValue == 2) {
        rutaImagen = "assets/images/Fallout/vaultTijera.png";
        valorImagen = 3;
      }
    });
  }

  void actualizarContador(int data) {

    if (valorImagen == 1 && data == 2) {
      setState(() {
        contadorAcierto++;
        timer1.cancel();
        globals.win = 1;
        rutaFinal = "assets/images/Fallout/winBoy.png";
        alturaFinal = alturaPantalla * 0.3;
        startTimerSiguiente();
        
      });


    } else if (valorImagen == 2 && data == 3) {
      setState(() {
        contadorAcierto++;
        timer1.cancel();
        globals.win = 1;
        rutaFinal = "assets/images/Fallout/winBoy.png";
        alturaFinal = alturaPantalla * 0.3;
        startTimerSiguiente();
      });

    } else if (valorImagen == 3 && data == 1) {
      setState(() {
        contadorAcierto++;
        timer1.cancel();
        globals.win = 1;
        rutaFinal = "assets/images/Fallout/winBoy.png";
        alturaFinal = alturaPantalla * 0.3;
        startTimerSiguiente();
      });
    }
  }

  late Timer timerSiguienteClase;
  void startTimerSiguiente() {
    const oneSec = Duration(milliseconds: 1400);
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
}
