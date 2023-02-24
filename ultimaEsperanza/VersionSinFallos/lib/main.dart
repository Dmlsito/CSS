// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto/menu/postGame.dart';
import 'package:proyecto/menu/postOnline.dart';
import 'package:proyecto/menu/register.dart';
import 'package:proyecto/minigames/pesca.dart';
import 'package:proyecto/minigames/reloj.dart';

import 'package:resize/resize.dart';
import 'inGame.dart';
import 'menu/gallery.dart';

import 'menu/inGameOnline.dart';
import 'menu/login.dart';
import 'menu/mainMenu.dart';
import 'menu/menu.dart';
import 'minigames/bolsasDinero.dart';
import 'minigames/carrera.dart';
import 'minigames/clickImagenes.dart';
import 'minigames/fallout.dart';
import 'minigames/fist.dart';
import 'minigames/frutas.dart';
import 'minigames/matazombies.dart';
import 'minigames/pipes.dart';
import 'minigames/roulette.dart';
import 'minigames/simon.dart';
import 'minigames/topos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Resize(builder: () {
      return MaterialApp(
        //theme: ThemeData(fontFamily: "coolvetica"),
        title: 'Mini Games',
        theme: ThemeData(fontFamily: "WarioWareInc"),
        initialRoute: "/log",
        routes: {
          "/menu": (BuildContext context) => SegundaMenu(),
          "/MainMenu": (BuildContext context) => SegundaMainMenu(),
          "/log": (BuildContext context) => SegundaLog(),
          "/simon": (BuildContext context) => SegundaSimon(),
          "/karate": (BuildContext context) => SegundaFist(),
          "/inGame": (BuildContext context) => SegundainGame(),
          "/inGameOnline": (BuildContext context) => SegundainGameOnline(),
          "/frutas": (BuildContext context) => SegundaFrutas(),
          "/fallout": (BuildContext context) => fallout(),
          "/gallery": (BuildContext context) => SegundaGallery(),
          "/bolsasDinero": (BuildContext context) => BolsasDinero(),
          "/zombies": (BuildContext context) => StateMiniJuego(),
          "/clickImagenes": (BuildContext context) => clickImagenes(),
          "/pesca": (BuildContext context) => Pesca(),
          "/pipes": (BuildContext context) => Pipes(),
          "/roulette": (BuildContext context) => Roulette(),
          "/postGame": (BuildContext context) => postGame(),
          "/carrera": (BuildContext context) => SegundaCarrera(),
          "/reloj": (BuildContext context) => SegundaReloj(),
          "/topos": (BuildContext context) => Topos(),
          "/register": (BuildContext context) => Register(),
          "/postOnline": (BuildContext context) => postOnline(),
        },
      );
    });
  }
}
