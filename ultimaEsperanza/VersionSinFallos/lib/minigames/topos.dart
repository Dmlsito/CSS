import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transparent_image_button/transparent_image_button.dart';
import "package:proyecto/globals.dart" as globals;


class Topos extends StatefulWidget {
  const Topos({super.key});

  @override
  State<Topos> createState() => _ToposState();
}

class _ToposState extends State<Topos> {

  bool win = false;

  int miniGameTime= 10;
  double topFin = 3000.0;
  double leftFin = 30.0;

  double topWin = 3000.0;
  double leftWin = 30.0;

  double topStart = 200;
  double leftStart = 55;

  int contWin = 0;
  int contTick1 = 0;
  int contTick2 = 0;

  //imagenes de topos, las pongo como variables variables para cambiarlas mas adelante
  List<String> topos = [
    "assets/images/topos/moleHole.png",
    "assets/images/topos/moleHole.png",
    "assets/images/topos/moleHole.png",
    "assets/images/topos/moleHole.png",
    "assets/images/topos/moleHole.png",
    "assets/images/topos/moleHole.png",
    "assets/images/topos/moleHole.png",
    "assets/images/topos/moleHole.png",
  ];

  //contador de vidas del jugador, al ser 0, se mostrara la pantalla de game over
  int vidas = 3;

  //variable para que salga el topo o no
  int random = 0;

  @override
  Widget build(BuildContext context) {
    late Timer timer;
    late Timer timer2;

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    //timer que empieza en la ejecucion, cada segundo suma 1 tick, lo uso para comparar en el segundo timer
    timer = Timer.periodic(const Duration(seconds: 1), (_) {});

    

    //segundo timer para que compare el primero cada 10 milisegundos, tras la llamada en el boton del topo
    void bonkazo() {
      timer2 = Timer.periodic(const Duration(milliseconds: 10), (_) {
        setState(() {
          if (timer.tick == contTick1 + 1) {
            recuperarTopo();
            contWin++;
            timer.cancel();
            timer2.cancel();
          }
        });
      });
    }

    String funcionClickTopo(String topo) {
      if (topo == "assets/images/topos/topoSaliendo.png") {
        topo = "assets/images/topos/bonk.png";
        contTick1 = timer.tick;
        bonkazo();
      } else if (vidas > 0) {
        vidas--;
        print(vidas);
      } else {
        topFin = 160;
        leftFin = -30;
      }
      if (contWin == 5) {
        topWin = 160;
        leftWin = 0;

        miniGameTickTimer.cancel();
        win=true;

        timerFinal();

      }
      return topo;
    }
    //cancelo el timer para que solo se haga una vez

    return Scaffold(
      body: Stack(
        children: [

          

          Container(
            // ignore: sort_child_properties_last
            child: Column(
              children: [

                SizedBox(height: 80,),
                
                Row(
                  children: [
                    // ignore: prefer_const_constructors

                    SizedBox(
                      width: 40,
                    ),

                    //imagen de fin del juego
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TransparentImageButton.assets(
                        topos[0],
                        opacityThreshold: 0.8,
                        onTapInside: () => {
                          setState(() {
                            topos[0] = funcionClickTopo(topos[0]);
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),

                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TransparentImageButton.assets(
                        topos[1],
                        opacityThreshold: 0.8,
                        onTapInside: () => {
                          setState(() {
                            topos[1] = funcionClickTopo(topos[1]);
                          })
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    // ignore: prefer_const_constructors

                    //imagen de fin del juego
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TransparentImageButton.assets(
                        topos[2],
                        opacityThreshold: 0.8,
                        onTapInside: () => {
                          setState(() {
                            topos[2] = funcionClickTopo(topos[2]);
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TransparentImageButton.assets(
                        topos[3],
                        opacityThreshold: 0.8,
                        onTapInside: () => {
                          setState(() {
                            topos[3] = funcionClickTopo(topos[3]);
                          })
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    // ignore: prefer_const_constructors

                    //imagen de fin del juego
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TransparentImageButton.assets(
                        topos[4],
                        opacityThreshold: 0.8,
                        onTapInside: () => {
                          setState(() {
                            topos[4] = funcionClickTopo(topos[4]);
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TransparentImageButton.assets(
                        topos[5],
                        opacityThreshold: 0.8,
                        onTapInside: () => {
                          setState(() {
                            topos[5] = funcionClickTopo(topos[5]);
                          })
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // ignore: prefer_const_constructors
                    SizedBox(
                      width: 40,
                    ),

                    //imagen de fin del juego
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TransparentImageButton.assets(
                        topos[6],
                        opacityThreshold: 0.8,
                        onTapInside: () => {
                          setState(() {
                            topos[6] = funcionClickTopo(topos[6]);
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TransparentImageButton.assets(
                        topos[7],
                        opacityThreshold: 0.8,
                        onTapInside: () => {
                          setState(() {
                            topos[0] = funcionClickTopo(topos[0]);
                          })
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/topos/fondo.png"),
                    fit: BoxFit.cover)),
          ),
          AnimatedPositioned(
              top: topFin,
              left: leftFin,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                "assets/images/topos/finJuego.gif",
              )),

          //GAME OVER
          AnimatedPositioned(
              top: topFin - 10,
              left: leftFin,
              height: 53,
              duration: const Duration(milliseconds: 1100),
              child: Container(
                width: 500,
                child: Text(
                  "   GAME OVER",
                  style: TextStyle(
                      fontFamily: "Ka1",
                      fontSize: 40,
                      color: Color.fromARGB(255, 162, 54, 47)),
                ),
                decoration: BoxDecoration(color: Colors.black),
              )),

          //YOU WIN
          AnimatedPositioned(
              top: topWin,
              left: leftWin - 80,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                "assets/images/topos/youWin.gif",
              )),

          AnimatedPositioned(
              top: topWin - 10,
              left: leftWin,
              height: 53,
              duration: const Duration(milliseconds: 1100),
              child: Container(
                width: 500,
                child: Text(
                  "     YOU WIN",
                  style: TextStyle(
                      fontFamily: "Ka1",
                      fontSize: 40,
                      color: Color.fromARGB(255, 162, 54, 47)),
                ),
                decoration: BoxDecoration(color: Colors.black),
              )),

            Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(bottom: 15, right: 15),
              child: globals.textoConBorde(miniGameTime.toString(), 40, 5, Colors.white, Colors.black),
            ),
            ),

        ],
        // ignore: sort_child_properties_last
      ),
    );
  }

  void recuperarTopo() {
      random = Random().nextInt(7);
      print(random);
      switch (random) {
        case 0:
          for (int i = 0; i < topos.length; i++) {
            if (i == random) {
              topos[i] = "assets/images/topos/topoSaliendo.png";
            } else {
              topos[i] = "assets/images/topos/moleHole.png";
            }
          }
          break;

        case 1:
          for (int i = 0; i < topos.length; i++) {
            if (i == random) {
              topos[i] = "assets/images/topos/topoSaliendo.png";
            } else {
              topos[i] = "assets/images/topos/moleHole.png";
            }
          }
          break;
        case 2:
          for (int i = 0; i < topos.length; i++) {
            if (i == random) {
              topos[i] = "assets/images/topos/topoSaliendo.png";
            } else {
              topos[i] = "assets/images/topos/moleHole.png";
            }
          }
          break;
        case 3:
          for (int i = 0; i < topos.length; i++) {
            if (i == random) {
              topos[i] = "assets/images/topos/topoSaliendo.png";
            } else {
              topos[i] = "assets/images/topos/moleHole.png";
            }
          }
          break;
        case 4:
          for (int i = 0; i < topos.length; i++) {
            if (i == random) {
              topos[i] = "assets/images/topos/topoSaliendo.png";
            } else {
              topos[i] = "assets/images/topos/moleHole.png";
            }
          }
          break;
        case 5:
          for (int i = 0; i < topos.length; i++) {
            if (i == random) {
              topos[i] = "assets/images/topos/topoSaliendo.png";
            } else {
              topos[i] = "assets/images/topos/moleHole.png";
            }
          }
          break;
        case 6:
          for (int i = 0; i < topos.length; i++) {
            if (i == random) {
              topos[i] = "assets/images/topos/topoSaliendo.png";
              break;
            } else {
              topos[i] = "assets/images/topos/moleHole.png";
            }
          }
          break;
        case 7:
          for (int i = 0; i < topos.length; i++) {
            if (i == random) {
              topos[i] = "assets/images/topos/topoSaliendo.png";
            } else {
              topos[i] = "assets/images/topos/moleHole.png";
            }
          }
          break;
      }
    }


  late Timer partidaTimer;
  void comienzaPartida() {
    int n = 0;
    const oneSec = Duration(seconds: 1);
    partidaTimer = Timer.periodic(
      oneSec,
      (Timer partidaTimer) {

        if(n==1){
          
          setState(() {
            miniGametick();
            recuperarTopo();
          });

          
          partidaTimer.cancel();

        }else{
          setState(() {
            n++;
          });
        }

      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    comienzaPartida();
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

          timerFinal();
          miniGameTickTimer.cancel();
        }
      },
    );
  }


    late Timer timerEnd;
    void timerFinal() {
      int n=0;
    const oneSec = Duration(seconds: 1);
    timerEnd = Timer.periodic(
      oneSec,
      (Timer timerEnd) {
        if(win){

          globals.win = 1;

        }else{

          globals.win = 2;

        }

      

        if (globals.gameMode == 1) {
          Navigator.of(context).pushNamed("/inGame");
        } else if (globals.gameMode == 2) {
          //ONLINE: SE TIENE QUE CAMBIAR LUEGO LA CLASE A LA ESPECIFICA DEL ONLINE
          Navigator.of(context).pushNamed("/inGameOnline");
        } else if (globals.gameMode == 3) {
          Navigator.of(context).pushNamed("/gallery");
        }

        timerEnd.cancel();
      },
    );
  }




}
