// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, sort_child_properties_last, curly_braces_in_flow_control_structures, unrelated_type_equality_checks

import 'dart:async';
import "package:proyecto/globals.dart" as globals;
import 'package:flutter/material.dart';

class Pesca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: statesJuego()));
  }
}

class statesJuego extends StatefulWidget {
  @override
  Juego createState() => Juego();
}

var size;
var alturaPantalla;
var anchoPantalla;

double moveToLeft = anchoPantalla * 0.8;
double anzuelo = anchoPantalla * 0.42;
double topAnzuelo = alturaPantalla * 0.1;

class Juego extends State<statesJuego> {
  bool moveToLeftFish = false;
  bool moveToRigthFish = false;
  bool pezCapturado = false;
  double leftGuide = 30;

  int gameCounter = 20;
  int counter = 0;
  int game = 0;
  Timer? timerMoveFish;
  Timer? timerGame;
  Timer? timerCuerda;

  bool cuerda1 = false;
  bool cuerda2 = false;
  bool cuerda3 = false;
  bool cuerda4 = false;
  bool cuerda5 = false;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    alturaPantalla = size.height;
    anchoPantalla = size.width;

    return MaterialApp(
        home: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Pesca/fondoPrueba.jpg"),
                    fit: BoxFit.cover)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: (Stack(
                  children: [
                    Container(
                        width: 80,
                        margin: EdgeInsets.only(
                            top: alturaPantalla * 0.85,
                            left: anchoPantalla * 0.05),
                        child: InkWell(
                            onTap: () {
                              aparecer();
                            },
                            child: Image.asset(
                                "assets/images/Pesca/canaPescar.png"))),
                    Container(
                        margin: EdgeInsets.only(
                            top: alturaPantalla * 0.95,
                            left: anchoPantalla * 0.08),
                        child: Text("Lanzar",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                    Container(
                        margin: EdgeInsets.only(
                            top: alturaPantalla * 0.95,
                            left: anchoPantalla * 0.75),
                        child: Text("Recoger",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                    Container(
                        margin: EdgeInsets.only(
                            top: alturaPantalla * 0.08,
                            left: anchoPantalla * 0.05),
                        child: globals.textoConBorde(gameCounter.toString(), 35,
                            3, Colors.white, Colors.black)),
                    Container(
                        margin: EdgeInsets.only(
                            top: alturaPantalla * 0.85,
                            left: anchoPantalla * 0.75),
                        width: 80,
                        height: 80,
                        child: InkWell(
                            onTap: () {
                              captured();
                            },
                            child:
                                Image.asset("assets/images/Pesca/Boton.png"))),
                    Container(
                        margin: EdgeInsets.only(
                            top: alturaPantalla * 0.05,
                            left: anchoPantalla * 0.405),
                        width: 100,
                        child: Image.asset("assets/images/Pesca/carrete.png")),
                    Visibility(
                      visible: cuerda1,
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.only(
                              top: alturaPantalla * 0.00001,
                              left: anchoPantalla * 0.405),
                          width: 90,
                          height: 300,
                          child: hiloDePesca1()),
                    ),
                    Visibility(
                      visible: cuerda2,
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.only(
                              top: alturaPantalla * 0.09,
                              left: anchoPantalla * 0.405),
                          width: 90,
                          height: 300,
                          child: hiloDePesca2()),
                    ),
                    Visibility(
                      visible: cuerda3,
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.only(
                              top: alturaPantalla * 0.19,
                              left: anchoPantalla * 0.405),
                          width: 90,
                          height: 300,
                          child: hiloDePesca3()),
                    ),
                    Visibility(
                      visible: cuerda4,
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.only(
                              top: alturaPantalla * 0.29,
                              left: anchoPantalla * 0.405),
                          width: 90,
                          height: 300,
                          child: hiloDePesca4()),
                    ),
                    Visibility(
                      visible: cuerda5,
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.only(
                              top: alturaPantalla * 0.39,
                              left: anchoPantalla * 0.405),
                          width: 90,
                          height: 300,
                          child: hiloDePesca5()),
                    ),
                    Container(
                        height: 30,
                        width: 80,
                        margin: EdgeInsets.only(top: topAnzuelo, left: anzuelo),
                        child: anzueloPesca()),
                    AnimatedContainer(
                      width: 80,
                      duration: Duration(milliseconds: 100),
                      child: fish(),
                      margin: EdgeInsets.only(
                          top: alturaPantalla * 0.6, left: moveToLeft),
                    ),
                    AnimatedPositioned(
                        top: alturaPantalla * 0.5 - ((99 * 0.37 / 2)),
                        // left: widthA0.5-((8540.37)/2),
                        left: leftGuide,
                        duration: const Duration(milliseconds: 1500),
                        child: Image.asset(
                          "assets/images/Pesca/GuideDaniel2.png",
                          fit: BoxFit.fitWidth,
                          width: 738 * 0.37,
                          height: 99 * 0.37,
                        )),
                  ],
                )))));
  }

  void startGame() {
    const oneSec = Duration(milliseconds: 1300);
    timerGame = Timer.periodic(
      oneSec,
      (Timer timerGame) {
        if (game == 0) {
          setState(() {
            leftGuide = 600;
            game++;
          });
        } else {
          timerGame.cancel();
          //TIMER EMPEZAR JUEGO

          timeControl();
        }
      },
    );
  }

  Widget fish() {
    return Image.asset("assets/images/Pesca/pescado.png");
  }

  Widget canaPescar() {
    return Image.asset("assets/images/Pesca/siluro.png");
  }

  Widget hiloDePesca1() {
    return Image.asset("assets/images/Pesca/lineaDePrueba.png");
  }

  Widget hiloDePesca2() {
    return Image.asset("assets/images/Pesca/lineaDePrueba.png");
  }

  Widget hiloDePesca3() {
    return Image.asset("assets/images/Pesca/lineaDePrueba.png");
  }

  Widget hiloDePesca4() {
    return Image.asset("assets/images/Pesca/lineaDePrueba.png");
  }

  Widget hiloDePesca5() {
    return Image.asset("assets/images/Pesca/lineaDePrueba.png");
  }

  Widget anzueloPesca() {
    return Image.asset("assets/images/Pesca/anzuelo.png");
  }

  void aparecer() {
    timerCuerda = Timer.periodic(Duration(milliseconds: 100), (timer) {
      counter++;
      setState(() {
        topAnzuelo = topAnzuelo + 85;
        if (topAnzuelo >= alturaPantalla * 0.63) {
          topAnzuelo = alturaPantalla * 0.63;
        }
        if (counter == 1) cuerda1 = true;
        if (counter == 2) cuerda2 = true;
        if (counter == 3) cuerda3 = true;
        if (counter == 4) cuerda4 = true;
        if (counter == 5) {
          cuerda5 = true;
          timer.cancel();
        }
      });
    });
  }

  void moveFish() {
    if (moveToRigthFish) {
      moveToLeft = moveToLeft + 45;
    }
    moveToLeft = moveToLeft - 25;
  }

  void fishMove() {
    timerMoveFish = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        if (moveToLeft <= anchoPantalla * 0.1) {
          moveToRigthFish = true;
        }
        if (moveToLeft >= anchoPantalla * 0.75) {
          moveToRigthFish = false;
        }
        moveFish();
        if (pezCapturado || gameCounter == 0) timer.cancel();
      });
    });
  }

//Funcion para determinar si ha capturado el pez o no, dentro del if se especifica el hitbox
  bool captured() {
    if ((moveToLeft + 80) >= (anzuelo + 50) &&
        (moveToLeft + 80) <= (anzuelo + 70)) {
      topAnzuelo = alturaPantalla * 0.1;
      globals.win = 1;
      if (globals.gameMode == 1)
        Navigator.of(context).pushNamed("/inGame");
      else if (globals.gameMode == 2)
        Navigator.of(context).pushNamed("/inGameOnline");
      else if (globals.gameMode == 3)
        Navigator.of(context).pushNamed("/gallery");
      pezCapturado = true;
      return true;
    } else
      pezCapturado = false;
    return false;
  }

  //Metodo para controlar el el timer principal de la partida
  void timeControl() {
    timerGame = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      gameCounter--;

      if (gameCounter == 0 && !pezCapturado) {
        topAnzuelo = alturaPantalla * 0.1;
        globals.win = 0;
        if (globals.gameMode == 1)
          Navigator.of(context).pushNamed("/inGame");
        else if (globals.gameMode == 2)
          Navigator.of(context).pushNamed("/inGameOnline");
        else if (globals.gameMode == 3)
          Navigator.of(context).pushNamed("/gallery");
        timer.cancel();
      }
      if (pezCapturado) timer.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    startGame();
    fishMove();
  }
}
