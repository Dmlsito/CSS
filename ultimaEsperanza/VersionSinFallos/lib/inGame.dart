import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import "package:proyecto/globals.dart" as globals;

class SegundainGame extends StatefulWidget {
  TercerainGame createState() => TercerainGame();
}

class TercerainGame extends State<SegundainGame> {
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
            top: 360,
            left: 170,
            child: Text(
              globals.points.toString(),
              style: TextStyle(fontSize: 100),
            )),

        //AVATAR DEL JUGADOR
        Positioned(
            top: 100,
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
          top: 400,
          left: 20,
          child: Container(
              //color: Colors.blue,
              margin: EdgeInsets.only(top: 80),
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
        ),

        //TEXTO DE MINIJUEGOS RESTANTES
        Positioned(
            left: widthA * 0.25,
            top: heightA * 0.75,
            child: Stack(children: [
              Text(
                "¡Gana " + globals.juegosRestantes.toString() + " más!",
                style: TextStyle(
                  fontSize: 35,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 5
                    ..color = Colors.black,
                ),
              ),
              Text(
                "¡Gana " + globals.juegosRestantes.toString() + " más!",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              )
            ]))
      ]),
    ));
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
            });

            //ENTRARÁ EN EL ELSE SI PERDEMOS EL MINIJUEGO
          } else {
            setState(() {
              avatar = globals.sad;
              globals.misVidas
                  .remove(globals.misVidas[globals.misVidas.length - 1]);
            });
          }
          n++;
        } else if (n == 3) {
          //ENTRARÁ AQUI SI NOS HEMOS QUEDADO SIN VIDAS
          if (globals.misVidas.length == 0) {
            //se cambiará esta navegación a una clase específica
            globals.victoria = false;
            Navigator.of(context).pushNamed("/postGame");

            //ENTRARÁ EN ESTE ELSE SI NOS HEMOS PASADO TODOS LOS MINIJUEGOS
          } else if (globals.juegosRestantes == 0) {
            //se cambiará esta navegación a una clase específica
            globals.victoria = true;
            Navigator.of(context).pushNamed("/postGame");
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
    if (globals.win == 2) {
      globals.timer.cancel();
      globals.player.stop();
      globals.duracionCancion = 125;
      globals.playFile("game.mp3");
      globals.startMusicaMenu("game.mp3");
      startTimerInicio();
    } else {
      startTimer();
    }
  }
}
