import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import "package:proyecto/globals.dart" as globals;
import 'package:proyecto/menu/mainMenu.dart';

import '../user/transition.dart';

void mainGallery() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'gallery',
      home: SegundaGallery(),
    );
  }
}

class SegundaGallery extends StatefulWidget {
  TerceraGallery createState() => TerceraGallery();
}

class TerceraGallery extends State<SegundaGallery> {
  var size, heightA, widthA;

  @override
  Widget build(BuildContext context) {
    setState(() {
      size = MediaQuery.of(context).size;
      heightA = size.height;
      widthA = size.width;
    });

    return Scaffold(
      //cuerpo principal del login
      body: Container(
          height: heightA,
          width: widthA,

          //imagen de fondo login
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/galleryBG.png"),
                  fit: BoxFit.fitHeight)),
          child: Column(
            children: [
              Container(
                height: heightA * 0.2,
                width: widthA,
                //color: Colors.red,
                child: Stack(
                  children: [
                    Positioned(
                      top: 70,
                      child: Container(
                        alignment: Alignment.center,
                        color: Color.fromARGB(255, 6, 68, 9),
                        width: widthA,
                        height: 30,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: globals.textoConBorde(
                          "Galeria", 60, 8, Colors.white, Colors.black),
                    )
                  ],
                ),
              ),

              //PARRTE DE LA PANTALLA SIN CONTAR EL TEXTO DE GALERIA
              Container(
                height: heightA * 0.8,
                width: widthA,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(LeftSlide(child: SegundaMainMenu()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20, left: 10),
                          alignment: Alignment.bottomLeft,
                          width: 45,
                          height: 45,
                          //color: Colors.black,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/arrow.png"),
                                  fit: BoxFit.fitHeight)),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      child: Container(
                        //alignment: Alignment.center,
                        //color: Colors.blue,
                        margin: EdgeInsets.only(top: 0),
                        height: 500,
                        width: widthA * 0.9,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 30,
                            mainAxisExtent: 74,
                          ),
                          itemCount: globals.listaMinigames.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  //cambiamos el gameMode a galería
                                  globals.gameMode = 3;
                                  Navigator.of(context).pushNamed(
                                      globals.listaMinigames[index].getRuta);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 0, 48, 0),
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.black, width: 2),
                                      left: BorderSide(
                                          color: Colors.black, width: 2),
                                      right: BorderSide(
                                          color: Colors.black, width: 2),
                                      bottom: BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 20),
                                        width: 70,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(globals
                                                    .listaMinigames[index]
                                                    .getrutaIcon),
                                                fit: BoxFit.fitHeight)),
                                      ),
                                      Text(
                                        globals.listaMinigames[index].getNombre,
                                        style: const TextStyle(
                                            fontSize: 21, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                        // child: ListView.builder(
                        // itemCount: globals.misPer.length,
                        // scrollDirection: Axis.horizontal,
                        //   itemBuilder: (context, index) {
                        //     return globals.misPer[index];
                        //   },
                        // ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
