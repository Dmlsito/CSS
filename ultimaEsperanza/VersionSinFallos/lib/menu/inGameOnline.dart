// ignore_for_file: prefer_const_constructors, annotate_overrides, use_key_in_widget_constructors, unused_local_variable, unused_import, depend_on_referenced_packages, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import "package:proyecto/globals.dart" as globals;
import 'package:proyecto/user/metodosBBDD.dart';

class SegundainGameOnline extends StatefulWidget {
  TercerainGame createState() => TercerainGame();
}

int destrozaCUCAS = 0;

class TercerainGame extends State<SegundainGameOnline> {
  var size, heightA, widthA;

  String avatar = globals.neutral;

  @override
  Widget build(BuildContext context) {
    final recibido = ModalRoute.of(context)!.settings.arguments;

    setState(() {
      size = MediaQuery.of(context).size;
      heightA = size.height;
      widthA = size.width;
    });

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/inGameBG.png"),
              fit: BoxFit.fitHeight)),
      height: heightA,
      width: widthA,
      child: Stack(children: [
        //TEXTO CON LOS PUNTOS DEL JUGADOR
        Positioned(
            top: heightA * 0.4,
            left: widthA * 0.45,
            child: Text(
              globals.points.toString(),
              style: TextStyle(fontSize: 100),
            )),

        //AVATAR DEL JUGADOR
        Positioned(
            top: heightA * 0.12,
            left: widthA * 0.5 - ((515 * 0.4) / 2),
            child: Container(
              height: 515 * 0.4,
              width: 515 * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(avatar), fit: BoxFit.fitHeight)),
            )),

        //LISTA CON LAS VIDAS DEL JUGADOR, ES UNA LISTA DE CONTAINERS, PERDER UNA VIDA ES ELIMINAR UN CONTAINER DE LA LISTA
        Positioned(
            top: heightA * 0.45, left: widthA * 0.03, child: vidasOnline()),
      ]),
    ));
  }

  Column vidasOnline() {
    if (globals.misVidas.length > 0) {
      return Column(
        children: [
          //TUS VIDAS
          Container(
              //color: Colors.blue,
              margin: EdgeInsets.only(top: 100),
              height: 100,
              width: 380,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 74,
                ),
                itemCount: globals.misVidas.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return globals.misVidas[index];
                },
              )),

          Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: globals.textoConBorde(
                "Vidas del rival: " + destrozaCUCAS.toString(),
                25,
                5,
                Colors.white,
                Colors.black),
          ),

          //VIDAS DEL RIVAL
          // Container(
          //   //color: Colors.blue,
          //   margin: EdgeInsets.only(top: 20),
          //   height: 60,
          //   width: 280,
          //   child: GridView.builder(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 3,
          //       mainAxisSpacing: 10,
          //       mainAxisExtent: 40,
          //     ),
          //     itemCount: globals.vidasRival.length,
          //     scrollDirection: Axis.vertical,
          //     itemBuilder: (context, index) {
          //       return globals.vidasRival[index];
          //     },
          //   )
          // ),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 100, left: 40),
            child: globals.textoConBorde(
                "Esperando al rival ...", 35, 5, Colors.white, Colors.black),
          ),
        ],
      );
    }
  }

  //TIMER QUE ARRANCA LA FUNCION DE COMPROBAR SI GANASTE O PERDISTE Y ENVIARTE A OTRO MINIJUEGO
  late Timer timer;
  void startTimer() {
    int n = 0;
    const oneSec = Duration(milliseconds: 600);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (n == 0) {
          setState(() {
            n++;
          });
        } else if (n == 1) {
          //ENTRARÁ EN ESTE IF SI GANAS EL MINIJUEGO
          if (globals.win == 1) {
            setState(() {
              globals.points++;
              avatar = globals.happy;
              globals.juegosRestantes--;
              actualizarVidasJugador(globals.numJugador, globals.codigoPartida,
                  globals.misVidas.length);
            });

            //ENTRARÁ EN EL ELSE SI PERDEMOS EL MINIJUEGO
          } else {
            setState(() {
              avatar = globals.sad;
              globals.misVidas
                  .remove(globals.misVidas[globals.misVidas.length - 1]);
            });
            actualizarVidasJugador(globals.numJugador, globals.codigoPartida,
                globals.misVidas.length);
          }
          n++;
        } else if (n == 3) {
          //ENTRARÁ AQUI SI NOS HEMOS QUEDADO SIN VIDAS
          if (globals.misVidas.length == 0) {
            //SI LAS VIDAS DEL RIVAL SON CERO HEMOS GANADO Y PASAMOS A LA SIGUIENTE CLASE
            /* if (destrozaCUCAS == 0) {
              globals.victoria = true;

              //metodo subir puntos
              

              //SI PERDEMOS Y NUESTRO RIVAL AUN TIENE VIDAS, SIGNIFICA QUE SIGUE JUGANDO, ES DECIR, PERDEMOS Y ESPERAMOS
              //A QUE NUESTRO RIVAL ACABE
            } else {
              globals.victoria = false;
              //esperarRival();
            }
            */
            Navigator.of(context).pushNamed("/postOnline");
            //ENTRARÁ EN ESTE ELSE SI NOS HEMOS PASADO TODOS LOS MINIJUEGOS
          } else if (globals.juegosRestantes == 0) {
            //se cambiará esta navegación a una clase específica
            globals.victoria = true;
            //subirPuntos();
          } else {
            //si no hemos ganado todo ni perdido, seguiremos con el siguiente minijuego
            saltoMinijuego();
          }

          timer.cancel();
        } else {
          n++;
        }
      },
    );
  }

  //TIMER QUE SE ACTIVA SOLO LA PRIMERA VEZ
  late Timer timerRival;
  void esperarRival() {
    int n = 0;
    metodosBBDD methods = metodosBBDD();
    const oneSec = Duration(seconds: 1);
    timerRival = Timer.periodic(
      oneSec,
      (Timer timerRival) async {
        if (globals.numJugador == 1) {
          await methods.consultarVidaJugador2(globals.codigoPartida);
        } else {
          await methods.consultarVidaJugador1(globals.codigoPartida);
        }

        if (destrozaCUCAS == 0) {
          subirPuntos();
          timerRival.cancel();
        }
      },
    );
  }

  void subirPuntos() async {
    metodosBBDD methods = metodosBBDD();

    if (globals.numJugador == 1) {
      await methods.insertarPuntosJugador1(
          globals.codigoPartida, globals.points);
    } else {
      await methods.insertarPuntosJugador2(
          globals.codigoPartida, globals.points);
    }

    Navigator.of(context).pushNamed("/postGame");
  }

  //TIMER QUE SE ACTIVA SOLO LA PRIMERA VEZ
  late Timer timerInicio;
  void startTimerInicio() {
    int n = 0;
    const oneSec = Duration(milliseconds: 700);
    timerInicio = Timer.periodic(
      oneSec,
      (Timer timerInicio) {
        if (n == 3) {
          globals.listaMinijuegos.shuffle();
          String nextMinigame = globals.listaMinijuegos[0];
          globals.ultimoMinijuego = nextMinigame;
          Navigator.of(context).pushNamed(nextMinigame);
          timerInicio.cancel();
        } else {
          n++;
        }
      },
    );
  }

  //funcion para pasar al siguiente minijuegom comprueba si el siguiente minijuego es igual al anterior para evitar jugar dos
  //veces el mismo minijuego
  void saltoMinijuego() {
    String nextMinigame = "";

    //comprueba si el siguiente minijuego es igual al anterior, en caso de serlo, buscará otro minijuego, si no, al salir del bucle, actualiza la variable
    //de ultimo minijuego jugado
    do {
      globals.listaMinijuegos.shuffle();
      nextMinigame = globals.listaMinijuegos[0];
    } while (nextMinigame == globals.ultimoMinijuego);

    globals.ultimoMinijuego = nextMinigame;

    Navigator.of(context).pushNamed(nextMinigame);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mostrarVidasJugadorContrario(globals.numJugador, globals.codigoPartida);

    if (globals.win == 2) {
      /*
      globals.timer.cancel();
      globals.player.stop();
      globals.duracionCancion = 125;
      globals.playFile("game.mp3");
      globals.startMusicaMenu("game.mp3");
      */

      startTimerInicio();
    } else {
      startTimer();
    }
  }

  // Se introduce el número del jugador, si es el jugador 1 o el jugador 2
  // Y el codigo de la partida para poder hacer la consulta a la bbdd

  void mostrarVidasJugadorContrario(int tipoJugador, int codigoPartida) async {
    int vidasJugadorContrario = 0;
    metodosBBDD methods = metodosBBDD();
    if (tipoJugador == 1) {
      vidasJugadorContrario =
          await methods.consultarVidaJugador2(codigoPartida);
      setState(() {
        destrozaCUCAS = vidasJugadorContrario;
      });
    } else if (tipoJugador == 2) {
      vidasJugadorContrario =
          await methods.consultarVidaJugador1(codigoPartida);
      setState(() {
        destrozaCUCAS = vidasJugadorContrario;
      });
    }
  }

  //Metodo para actualizar las vidas del jugador
  void actualizarVidasJugador(
      int tipoJugador, int codigoPartida, int numVidas) async {
    metodosBBDD methods = metodosBBDD();

    if (tipoJugador == 1) {
      await methods.insertarVidasJugador1(codigoPartida, numVidas);
    } else if (tipoJugador == 2) {
      await methods.insertarVidasJugador2(codigoPartida, numVidas);
    }
  }
}
