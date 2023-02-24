import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proyecto/menu/menu.dart';
import '../user/metodosBBDD.dart';
import '../user/transition.dart';
import 'mainMenu.dart';
import "package:proyecto/globals.dart" as globals;

class postOnline extends StatefulWidget {
  postOnline2 createState() => postOnline2();
}

class postOnline2 extends State<postOnline> {
  var size, heightA, widthA;
  metodosBBDD methods = metodosBBDD();
  @override
  Widget build(BuildContext context) {
    setState(() {
      size = MediaQuery.of(context).size;
      heightA = size.height;
      widthA = size.width;
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/ajustesBG.png"),
                fit: BoxFit.fitHeight)),
        height: heightA,
        width: widthA,
        child: Column(
          children: [
            globals.textoConBorde(
                "Comprobar resultados", 32, 7, Colors.white, Colors.black),
            InkWell(
              onTap: () {
                consultarDatos();
                Navigator.of(context).pushNamed("/postGame");
              },
              child: Container(
                margin: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                height: 60,
                width: 220,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 141, 141, 141),
                        Color.fromARGB(255, 58, 58, 58),
                      ]),
                  border: Border.all(width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Ver resultados",
                  style: TextStyle(color: globals.colorAvatar, fontSize: 22),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    insertarDatos();
  }

  void consultarDatos() async {
    if (globals.numJugador == 1) {
      globals.puntos2 =
          await methods.consultarPuntosJugador2(globals.codigoPartida);
    } else if (globals.numJugador == 2) {
      globals.puntos1 =
          await methods.consultarPuntosJugador1(globals.codigoPartida);
    }
  }

  void insertarDatos() async {
    if (globals.numJugador == 1) {
      await methods.insertarPuntosJugador1(
          globals.codigoPartida, globals.points);
    } else if (globals.numJugador == 2) {
      await methods.insertarPuntosJugador2(
          globals.codigoPartida, globals.points);
    }
  }
}
