import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import "package:proyecto/globals.dart" as globals;

import '../user/transition.dart';
import 'login.dart';

void menu() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Menu',
      home: SegundaMenu(),
    );
  }
}

class SegundaMenu extends StatefulWidget {
  TerceraMenu createState() => TerceraMenu();
}

class TerceraMenu extends State<SegundaMenu> {
  var size, heightA, widthA;

  double widthLogo = 1260 * 0.3;
  double heighLogo = 439 * 0.3;

  @override
  Widget build(BuildContext context) {
    setState(() {
      size = MediaQuery.of(context).size;
      heightA = size.height;
      widthA = size.width;
      globals.anchoPantalla = widthA;
    });

    return Scaffold(
      //cuerpo principal del menú
      body: Container(
        height: heightA,
        width: widthA,

        //imagen de fondo menú
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/menuBG.gif"),
                fit: BoxFit.fitWidth)),

        child: Stack(
          children: [
            AnimatedPositioned(
                top: heightA * 0.22,
                left: widthA * 0.5 - ((widthLogo) / 2),
                duration: Duration(seconds: 1),
                child: AnimatedContainer(
                  height: heighLogo,
                  width: widthLogo,
                  duration: Duration(seconds: 1),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"),
                          fit: BoxFit.fitWidth)),
                )),
            InkWell(
              onTap: () {
                timerLogo.cancel();

                if (globals.sesionIniciada == false) {
                  Navigator.of(context).push(AscendSlide(child: SegundaLog()));
                } else {
                  Navigator.of(context).pushNamed("/MainMenu");
                }
              },
              child: Container(
                height: heightA,
                width: widthA,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  timerLogo.cancel();
                  Navigator.of(context).push(AscendSlide(child: SegundaLog()));
                },
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/loginButton.png"),
                          fit: BoxFit.fitWidth)),
                  height: 864 * 0.15,
                  width: 934 * 0.15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //FUNCIONES

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (globals.menuMusic == true) {
      globals.player.stop();
      globals.duracionCancion = 64;
      globals.playFile("menu.mp3");
      globals.menuMusic = false;
      globals.startMusicaMenu("menu.mp3");
    }

    setState(() {
      widthLogo = 1260 * 0.26;
      heighLogo = 439 * 0.26;
    });
    animacionLogo();

    //PARA LA VERSION FINAL ESTO NO TIENE QUE ESTAR:
    //globals.sesionIniciada = true;
  }

  late Timer timerLogo;
  void animacionLogo() {
    int n = 0;
    const oneSec = Duration(seconds: 1);
    timerLogo = Timer.periodic(
      oneSec,
      (Timer timerLogo) {
        if (n == 0) {
          n++;
          setState(() {
            widthLogo = 1260 * 0.3;
            heighLogo = 439 * 0.3;
          });
        } else {
          setState(() {
            widthLogo = 1260 * 0.26;
            heighLogo = 439 * 0.26;
          });
          n--;
        }
      },
    );
  }
}
