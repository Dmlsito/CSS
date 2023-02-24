//ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, curly_braces_in_flow_control_structures, unused_element, sort_child_properties_last, unnecessary_new

import 'dart:async';

import 'dart:math';
import "package:proyecto/globals.dart" as globals;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class BolsasDinero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: StatesMinijuego1()));
  }
}

class StatesMinijuego1 extends StatefulWidget {
  @override
  juego createState() => juego();
}

class juego extends State<StatesMinijuego1> {
  var size;
  var alturaPantalla;
  var anchoPantalla;
  String imagenDinero1 = "";
  String imagenDinero2 = "";
  String imagenDinero3 = "";
  String imagenDinero4 = "";
  String imagenDinero5 = "";

  String imagenEnBlanco = "";

  bool controlClickBoton = true;

  double leftGuide = 60;

  int contadorTimerFinal = 0;

  int game = 0;
  int counterGame = 10;
  late Timer timerGame;

  double top1 = 50;
  double top2 = 50;
  double top3 = 50;
  double top4 = 50;
  double top5 = 50;
  double top6 = 50;
  double top7 = 50;
  double top8 = 50;
  double top9 = 50;

  int contador = 0;

  bool objeto1Conseguido = false;
  bool objeto2Conseguido = false;
  bool objeto3Conseguido = false;
  bool objeto4Conseguido = false;
  bool objeto5Conseguido = false;

  bool botonOculto = true;
  bool imagenUp1 = false;
  bool imagenUp2 = false;
  bool imagenUp3 = false;
  bool imagenUp4 = false;
  bool imagenUp5 = false;

  Timer? timerCaidaObeto;

  Timer? timerPartida;

  Timer? timerPop;

  int contadorTiempo = 0;
  int moneyBags = 0;
  @override
  Widget build(BuildContext context) {
    //Funcion que controla el comienzo de la partida, cuando la variable game sea distinto de 0, es decir
    //cuando pase un segundo desde que se llamo a la funcion el timer se cancelara y se llamara a startGamer3()

    //Recogemos las medidas de la pantalla
    setState(() {
      size = MediaQuery.of(context).size;
      alturaPantalla = size.height;
      anchoPantalla = size.width;
    });

    return MaterialApp(
        home: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/CogeDinero/Fondo.jpg"),
                    fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: alturaPantalla * 0.02,
                          left: anchoPantalla * 0.05),
                      child: globals.textoConBorde(counterGame.toString(), 35,
                          3, Colors.white, Colors.black)),
                  AnimatedContainer(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(
                          top: top1, right: anchoPantalla * 0.88),
                      duration: Duration(milliseconds: 500),
                      child: InkWell(
                        child: !imagenUp1 ? bolsaDinero1() : null,
                        onTap: () {
                          moneyBags++;
                          imagenUp1 = true;
                          //Cada animatedContainer tendra su propio index para poder colocarnos en la posicion correcta
                          //de cada lista
                          int index = 0;
                          //Tendremos que setear a true esta variable para controlar que hemos obtenido
                          //la bolsa de dinero
                          objeto1Conseguido = true;

                          //Tendremos que llamar a esta funcion en cada animatedContainer para evaluar si el usuario ha ganado o no
                        },
                      )),
                  AnimatedContainer(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(
                          top: top2, left: anchoPantalla * 0.88),
                      duration: Duration(milliseconds: 500),
                      child: InkWell(
                        child: !imagenUp2 ? bolsaDinero2() : null,
                        onTap: () {
                          moneyBags++;
                          imagenUp2 = true;
                          int index = 1;
                          objeto2Conseguido = true;
                        },
                      )),
                  AnimatedContainer(
                      height: 50,
                      width: 50,
                      margin:
                          EdgeInsets.only(top: top3, left: anchoPantalla * 0.5),
                      duration: Duration(milliseconds: 500),
                      child: InkWell(
                        child: !imagenUp3 ? bolsaDinero3() : null,
                        onTap: () {
                          moneyBags++;
                          imagenUp3 = true;
                          int index = 2;
                          objeto3Conseguido = true;
                        },
                      )),
                  AnimatedContainer(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(
                          top: top4, left: anchoPantalla * 0.23),
                      duration: Duration(milliseconds: 500),
                      child: InkWell(
                        child: !imagenUp4 ? bolsaDinero4() : null,
                        onTap: () {
                          moneyBags++;
                          imagenUp4 = true;
                          int index = 3;
                          objeto4Conseguido = true;
                        },
                      )),
                  AnimatedContainer(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(
                          top: top5, left: anchoPantalla * 0.70),
                      duration: Duration(milliseconds: 500),
                      child: InkWell(
                        child: !imagenUp5 ? bolsaDinero5() : null,
                        onTap: () {
                          moneyBags++;
                          imagenUp5 = true;
                          int index = 4;
                          objeto5Conseguido = true;
                        },
                      )),
                  Container(
                      margin: EdgeInsets.only(
                        top: alturaPantalla * 0.90,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 50,
                              height: 50,
                              margin: EdgeInsets.only(right: 20),
                              child: imagenUp1 ? bolsaDinero1Lista() : null),
                          Container(
                              width: 50,
                              height: 50,
                              margin: EdgeInsets.only(right: 20),
                              child: imagenUp2 ? bolsaDinero2Lista() : null),
                          Container(
                              width: 50,
                              height: 50,
                              margin: EdgeInsets.only(right: 20),
                              child: imagenUp3 ? bolsaDinero3Lista() : null),
                          Container(
                              width: 50,
                              height: 50,
                              margin: EdgeInsets.only(right: 20),
                              child: imagenUp4 ? bolsaDinero4Lista() : null),
                          Container(
                              width: 50,
                              height: 50,
                              margin: EdgeInsets.only(right: 20),
                              child: imagenUp5 ? bolsaDinero5Lista() : null)
                        ],
                      )),
                  AnimatedPositioned(
                      top: alturaPantalla * 0.5 - ((99 * 0.37 / 2)),
                      // left: widthA0.5-((8540.37)/2),
                      left: leftGuide,
                      duration: const Duration(milliseconds: 800),
                      child: Container(
                        child: Image.asset(
                            "assets/images/CogeDinero/GuideDaniel1.png",
                            fit: BoxFit.fitWidth),
                        width: 738 * 0.37,
                        height: 99 * 0.37,
                      )),
                ],
              ),
            )));
  }

  Widget bolsaDinero1() {
    return Image.asset("assets/images/CogeDinero/bolsaDinero.png");
  }

  Widget bolsaDinero2() {
    return Image.asset("assets/images/CogeDinero/bolsaDinero.png");
  }

  Widget bolsaDinero3() {
    return Image.asset("assets/images/CogeDinero/bolsaDinero.png");
  }

  Widget bolsaDinero4() {
    return Image.asset("assets/images/CogeDinero/bolsaDinero.png");
  }

  Widget bolsaDinero5() {
    return Image.asset("assets/images/CogeDinero/bolsaDinero.png");
  }

  Widget bolsaDinero1Lista() {
    return Image.asset("assets/images/CogeDinero/bolsaDinero.png");
  }

  Widget bolsaDinero2Lista() {
    return Image.asset("assets/images/CogeDinero/bolsaDinero.png");
  }

  Widget bolsaDinero3Lista() {
    return Image.asset("assets/images/CogeDinero/bolsaDinero.png");
  }

  Widget bolsaDinero4Lista() {
    return Image.asset("assets/images/CogeDinero/bolsaDinero.png");
  }

  Widget bolsaDinero5Lista() {
    return Image.asset("assets/images/CogeDinero/bolsaDinero.png");
  }

  void startGame() {
    const oneSec = Duration(seconds: 2);
    timerGame = Timer.periodic(
      oneSec,
      (Timer timerGame) {
        if (game == 0) {
          setState(() {
            leftGuide = 600;
            game++;
          });
        }
        if (game == 2) {
          timerGame.cancel();
        }
      },
    );
  }

  void gameTime() {
    timerGame = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        counterGame--;
        if (counterGame == 0) {
          globals.win = 0;
          if (globals.gameMode == 1)
            Navigator.of(context).pushNamed("/inGame");
          else if (globals.gameMode == 2)
            Navigator.of(context).pushNamed("/inGameOnline");
          else if (globals.gameMode == 3)
            Navigator.of(context).pushNamed("/gallery");
          timer.cancel();
        }
        if (moneyBags == 5 && counterGame > 0) {
          globals.win = 1;
          if (globals.gameMode == 1)
            Navigator.of(context).pushNamed("/inGame");
          else if (globals.gameMode == 2)
            Navigator.of(context).pushNamed("/inGameOnline");
          else if (globals.gameMode == 3)
            Navigator.of(context).pushNamed("/gallery");
          timer.cancel();
        }
      });
    });
  }
//Funcion que iniciara el programa

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startGame();
    gameTime();
    caidaObjeto1();
    caidaObjeto2();
    caidaObjeto3();
    caidaObjeto4();
    caidaObjeto5();
  }

//Funciones para controlar la caida de los objetos
  double caidaObjeto1() {
    timerCaidaObeto = Timer.periodic(Duration(milliseconds: 500), (timer1) {
      //Creamos un random que es la distancia que recorera cada 500 milisegundos la bolsa de dinero
      Random random = new Random();
      int caida = random.nextInt(100) + 50;
      setState(() {
        top1 += caida;
      });

      //Llegado a un valor minimo en el eje indicamos que se vuelva a su posicion inicial, cambiando el valor del top
      //Esto se reproducira en bucle hasta que la bolsa sea clickada
      if (top1 > alturaPantalla * 0.75) {
        top1 = 50;
      }
    });

    return top1;
  }

  double caidaObjeto2() {
    timerCaidaObeto = Timer.periodic(Duration(milliseconds: 500), (timer2) {
      Random random = Random();
      int caida = random.nextInt(100) + 50;
      setState(() {
        top2 += caida;
      });

      if (top2 > alturaPantalla * 0.75) {
        top2 = 50;
      }
    });

    return top2;
  }

  double caidaObjeto3() {
    timerCaidaObeto = Timer.periodic(Duration(milliseconds: 500), (timer3) {
      Random random = Random();
      int caida = random.nextInt(100) + 50;
      setState(() {
        top3 += caida;
      });

      if (top3 > alturaPantalla * 0.75) {
        top3 = 50;
      }
    });

    return top3;
  }

  double caidaObjeto4() {
    timerCaidaObeto = Timer.periodic(Duration(milliseconds: 500), (timer4) {
      Random random = Random();
      int caida = random.nextInt(100) + 50;
      setState(() {
        top4 += caida;
      });

      if (top4 > alturaPantalla * 0.75) {
        top4 = 50;
      }
    });

    return top4;
  }

  double caidaObjeto5() {
    timerCaidaObeto = Timer.periodic(Duration(milliseconds: 500), (timer5) {
      Random random = Random();
      int caida = random.nextInt(100) + 50;
      setState(() {
        top5 += caida;
      });
      if (top5 > alturaPantalla * 0.75) {
        top5 = 50;
      }
    });

    return top5;
  }
}
