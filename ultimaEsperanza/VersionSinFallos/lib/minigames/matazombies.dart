// ignore_for_file: avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, duplicate_ignore, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, sort_child_properties_last

import 'dart:async';
import 'dart:math';
import "package:proyecto/globals.dart" as globals;
import 'package:flutter/material.dart';

class Minijuego extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: StateMiniJuego()));
  }
}

class StateMiniJuego extends StatefulWidget {
  @override
  Juego createState() => Juego();
}

// ignore: prefer_typing_uninitialized_variables
var size;
var alturaPantalla;
var anchoPantalla;

double moveToLeft = anchoPantalla * 0.4;
double moveToLeftBullet = anchoPantalla * 0.50;
double positionBullet = alturaPantalla * 0.75;
double topCan = (randomAltura.nextDouble() * 500) + 50;
double widthCan = (randomDerecha.nextDouble() * 300) + 50;

Random randomAltura = Random();
Random randomDerecha = Random();

class Juego extends State<StateMiniJuego> {
  Color colorbullet = Colors.transparent;
  double leftGuide = 60;
  int totalCanHits = 0;
  int counterFinished = 0;
  int counterGame = 15;
  int game = 0;

  Timer? shoot;
  Timer? canRestart;
  Timer? restart;
  Timer? timerGame1;
  Timer? timerGame;

  bool disparobullet = false;
  bool desaparecerLata = false;

  @override
  Widget build(BuildContext context) {
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
                    image: AssetImage("assets/images/MatZombies/Fondo.gif"),
                    fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              // ignore: prefer_const_literals_to_create_immutables
              body: Stack(children: [
                Container(
                    margin: EdgeInsets.only(
                        top: alturaPantalla * 0.02, left: anchoPantalla * 0.1),
                    child: globals.textoConBorde(counterGame.toString(), 35, 3,
                        Colors.white, Colors.black)),
                Container(
                    margin: EdgeInsets.only(top: alturaPantalla * 0.9),
                    child: InkWell(
                      child:
                          Image.asset("assets/images/MatZombies/Izquierda.png"),
                      onTap: () {
                        moveLeft();
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(
                        top: alturaPantalla * 0.9, left: anchoPantalla * 0.8),
                    child: InkWell(
                      child:
                          Image.asset("assets/images/MatZombies/Derecha.png"),
                      onTap: () {
                        moveRight();
                      },
                    )),
                AnimatedContainer(
                  width: 70,
                  height: 52,
                  margin: EdgeInsets.only(
                      top: positionBullet, left: moveToLeftBullet),
                  duration: Duration(milliseconds: 100),
                  //When the shootBullet is true call the function bullet()
                  child: disparobullet ? bullet() : null,
                ),
                AnimatedContainer(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(
                        top: alturaPantalla * 0.75, left: moveToLeft),
                    duration: Duration(milliseconds: 60),
                    child:
                        Image.asset("assets/images/MatZombies/escopeta.png")),
                Container(
                    margin: EdgeInsets.only(
                        top: alturaPantalla * 0.9, left: anchoPantalla * 0.4),
                    child: InkWell(
                      child: Image.asset("assets/images/MatZombies/diana.png"),
                      onTap: () {
                        shootGun();
                      },
                    )),
                Container(child: !desaparecerLata ? canContainer() : null),
                AnimatedPositioned(
                    top: alturaPantalla * 0.5 - ((99 * 0.37 / 2)),
                    // left: widthA0.5-((8540.37)/2),
                    left: leftGuide,
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      child: Image.asset(
                          "assets/images/MatZombies/GuideDaniel3.png",
                          fit: BoxFit.fitWidth),
                      width: 738 * 0.37,
                      height: 99 * 0.37,
                    )),
              ]),
            )));
  }

  Widget bullet() {
    return Image.asset(
      "assets/images/MatZombies/bala.png",
    );
  }

  Widget canContainer() {
    if (totalCanHits <= 5) {
      return Container(
          width: 100,
          height: 70,
          margin: EdgeInsets.only(top: topCan, left: widthCan),
          child: Image.asset("assets/images/MatZombies/zombie.png"));
    }
    return Container();
  }

  void startGame() {
    const oneSec = Duration(milliseconds: 1000);
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

  double moveRight() {
    setState(() {
      if (moveToLeft > anchoPantalla * 0.7) {
        moveToLeft = anchoPantalla * 0.65;
        moveToLeftBullet = anchoPantalla * 0.75;
      } else {
        moveToLeft = moveToLeft + 15;
        moveToLeftBullet = moveToLeftBullet + 15;
      }
    });

    return moveToLeft;
  }

  double moveLeft() {
    setState(() {
      if (moveToLeft < 40) {
        moveToLeft = 60;
        moveToLeftBullet = moveToLeftBullet + 40;
      } else {
        moveToLeft = moveToLeft - 15;
        moveToLeftBullet = moveToLeftBullet - 15;
      }
    });
    return moveToLeft;
  }

  void shootGun() {
    //The bullet is visible
    disparobullet = true;

    shoot = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        positionBullet -= 60;
        //Hitbox can
        if (positionBullet <= topCan &&
            moveToLeftBullet >= widthCan &&
            moveToLeftBullet <= (widthCan + 120)) {
          desaparecerLata = true;
          //The bullet is invisible and comes back to the initial position
          disparobullet = false;
          positionBullet = alturaPantalla * 0.75;
          totalCanHits++;

          //Restart the can in 1 seconds
          canRestarted();
          timer.cancel();
        }
      });
      if (positionBullet <= 10) {
        setState(() {
          // The bullet hits can and comes back to the initial position
          positionBullet = alturaPantalla * 0.75;
          timer.cancel();
        });
        disparobullet = false;
      }
    });
  }

  void canRestarted() {
    Random randomAncho2 = Random();
    Random randomAltura2 = Random();
    double ancho2 = (randomAncho2.nextDouble() * 300) + 50;
    double altura2 = (randomAltura2.nextDouble() * 500) + 50;
    int counter = 0;
    canRestart = Timer.periodic(Duration(milliseconds: 800), (timerCan) {
      counter++;
      if (counter == 2) {
        setState(() {
          widthCan = ancho2;
          topCan = altura2;
          desaparecerLata = false;
          timerCan.cancel();
        });
      }
    });
  }

  void restartGame() {
    //Reseteamos todo
    totalCanHits = 0;
    counterGame = 0;
  }

  void gameTime() {
    timerGame1 = Timer.periodic(Duration(seconds: 1), (timerGame) {
      setState(() {
        counterGame--;
        if (counterGame == 0 && totalCanHits < 3) {
          globals.win = 0;
          if (globals.gameMode == 1)
            Navigator.of(context).pushNamed("/inGame");
          else if (globals.gameMode == 2)
            Navigator.of(context).pushNamed("/inGameOnline");
          else if (globals.gameMode == 3)
            Navigator.of(context).pushNamed("/gallery");
          timerGame.cancel();
        }
        if (totalCanHits == 3) {
          globals.win = 1;
          if (globals.gameMode == 1)
            Navigator.of(context).pushNamed("/inGame");
          else if (globals.gameMode == 2)
            Navigator.of(context).pushNamed("/inGameOnline");
          else if (globals.gameMode == 3)
            Navigator.of(context).pushNamed("/gallery");
          timerGame.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startGame();
    gameTime();
  }
}
