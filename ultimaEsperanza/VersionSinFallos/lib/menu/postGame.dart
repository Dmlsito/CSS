// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proyecto/menu/menu.dart';
import '../user/metodosBBDD.dart';
import '../user/transition.dart';
import 'mainMenu.dart';
import "package:proyecto/globals.dart" as globals;

class postGame extends StatefulWidget {
  postGame2 createState() => postGame2();
}

class postGame2 extends State<postGame> {
  var size, heightA, widthA;

  int puntos1 = 0;
  int puntos2 = 0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      size = MediaQuery.of(context).size;
      heightA = size.height;
      widthA = size.width;
    });

    return Scaffold(
      body: bodyPost(),
    );
  }

  Container bodyPost() {
    if (globals.victoria == true) {
      return cuerpoVictoria();
    } else {
      return cuerpoDerrota();
    }
  }

  Container cuerpoVictoria() {
    return Container(
      height: heightA,
      width: widthA,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 196, 0),
              Color.fromARGB(255, 255, 0, 98),
            ]),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: heightA * 0.2,
                  width: widthA,
                  child: globals.textoConBorde(
                      "Victoria !", 60, 10, Colors.white, Colors.black),
                ),
                Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(globals.happy),
                          fit: BoxFit.fitHeight)),
                ),
              ],
            ),
          ),
          Positioned(
              top: heightA * 0.9,
              left: widthA * 0.5 - ((220) / 2),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(AscendSlide(child: SegundaMenu()));
                },
                child: Container(
                  //margin: EdgeInsets.only(bottom: 30),
                  alignment: Alignment.center,
                  height: 60,
                  width: 220,
                  //color: Colors.amber,
                  child: Text(
                    "Volver al menu",
                    style: TextStyle(color: Colors.white, fontSize: 27),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  // Container puntosOnline() {
  //   //CAMBIAR A ==2 IMPORTANTEEEEEEEEEEEEEEEEEEEEEEEEE
  //   //CAMBIAR A ==2 IMPORTANTEEEEEEEEEEEEEEEEEEEEEEEEE
  //   //CAMBIAR A ==2 IMPORTANTEEEEEEEEEEEEEEEEEEEEEEEEE
  //   //CAMBIAR A ==2 IMPORTANTEEEEEEEEEEEEEEEEEEEEEEEEE
  //   //CAMBIAR A ==2 IMPORTANTEEEEEEEEEEEEEEEEEEEEEEEEE
  //   //CAMBIAR A ==2 IMPORTANTEEEEEEEEEEEEEEEEEEEEEEEEE
  //   //CAMBIAR A ==2 IMPORTANTEEEEEEEEEEEEEEEEEEEEEEEEE
  //   //CAMBIAR A ==2 IMPORTANTEEEEEEEEEEEEEEEEEEEEEEEEE
  //   //CAMBIAR A ==2 IMPORTANTEEEEEEEEEEEEEEEEEEEEEEEEE
  //   //CAMBIAR A ==2 IMPORTANTEEEEEEEEEEEEEEEEEEEEEEEEE
  //   //CAMBIAR A ==2 IMPORTANTEEEEEEEEEEEEEEEEEEEEEEEEE
  //   //CAMBIAR A ==2 IMPORTANTEEEEEEEEEEEEEEEEEEEEEEEEE

  //   if (globals.gameMode == 2) {
  //     //metodosBBDD methods = metodosBBDD();

  //     return Container(
  //       child: Column(
  //         children: [
  //           Container(
  //             margin: EdgeInsets.only(top: 40),
  //             child: globals.textoConBorde(
  //                 "Puntos de " + name1 + ":", 25, 5, Colors.blue, Colors.black),
  //           ),
  //           Container(
  //             margin: EdgeInsets.only(top: 40),
  //             child: globals.textoConBorde(
  //                 "Puntos de " + name2 + ":", 25, 5, Colors.red, Colors.black),
  //           )
  //         ],
  //       ),
  //     );
  //   } else {
  //     return Container();
  //   }
  // }
  /*
  void consultarNombres() async {
    metodosBBDD methods = metodosBBDD();

    name1 = await methods.consultarNombreJugador1(globals.codigoPartida);

    name2 = await methods.consultarNombreJugador2(globals.codigoPartida);

    puntos1 = await methods.consultarPuntosJugador1(globals.codigoPartida);

    puntos2 = await methods.consultarPuntosJugador2(globals.codigoPartida);

    setState(() {
      name1 = name1;
      name2 = name2;
      puntos1 = puntos1;
      puntos2 = puntos2;
    });
  }
  */
  Container cuerpoDerrota() {
    return Container(
      height: heightA,
      width: widthA,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 41, 128, 185),
              Color.fromARGB(255, 0, 28, 46),
            ]),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: heightA * 0.2,
                  width: widthA,
                  child: globals.textoConBorde(
                      "Derrota ...", 60, 10, Colors.white, Colors.black),
                ),
                Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(globals.sad),
                          fit: BoxFit.fitHeight)),
                ),
              ],
            ),
          ),
          Positioned(
              top: heightA * 0.9,
              left: widthA * 0.5 - ((220) / 2),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(AscendSlide(child: SegundaMenu()));
                },
                child: Container(
                  //margin: EdgeInsets.only(bottom: 30),
                  alignment: Alignment.center,
                  height: 60,
                  width: 220,
                  //color: Colors.amber,
                  child: Text(
                    "Volver al menu",
                    style: TextStyle(color: Colors.white, fontSize: 27),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void resetAll() {
    //puntos a cero
    globals.points = 0;

    //win a 2 para que ni reste ni sume nada más entrar a la nueva partida
    globals.win = 2;

    //volvemos a poner los juegos restantes a 10
    globals.juegosRestantes = 10;

    //recuperamos las vidas
    globals.misVidas = globals.fullVidas;

    //recuperamos vidas del rival
    //globals.vidasRival = globals.fullVidas;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (globals.gameMode == 2) {}

    globals.crearRanking(true, globals.points, globals.misVidas.length);

    resetAll();
  }

  void compararPuntuaciones() {
    if (globals.puntos1 > globals.puntos2) {
      // Gana el jugador 1 //
      if (globals.numJugador == 1) {
        globals.victoria = true;
      } else if (globals.numJugador == 2) {
        globals.victoria = false;
      }
    } else if (globals.puntos1 < globals.puntos2) {
      // Gana el jugador 2 //
      if (globals.numJugador == 1) {
        globals.victoria = false;
      } else if (globals.numJugador == 2) {
        globals.victoria = true;
      }
    } else {
      globals.victoria = true;
    }
  }
}
