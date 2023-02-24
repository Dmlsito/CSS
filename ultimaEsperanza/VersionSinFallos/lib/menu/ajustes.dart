// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import '../user/metodosBBDD.dart';
import '../user/transition.dart';
import 'mainMenu.dart';
import "package:proyecto/globals.dart" as globals;

class Ajustes extends StatefulWidget {
  Ajustes2 createState() => Ajustes2();
}

class Ajustes2 extends State<Ajustes> {
  var size, heightA, widthA;

  String mode = "base";

  @override
  Widget build(BuildContext context) {
    setState(() {
      size = MediaQuery.of(context).size;
      heightA = size.height;
      widthA = size.width;
    });

    return Scaffold(
      body: Container(
        height: heightA,
        width: widthA,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/ajustesBG.png"),
                fit: BoxFit.cover)),
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
                      color: Color.fromARGB(255, 63, 63, 63),
                      width: widthA,
                      height: 30,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: globals.textoConBorde(
                        "Ajustes", 60, 8, Colors.white, Colors.black),
                  )
                ],
              ),
            ),
            cambioCuerpo(),
          ],
        ),
      ),
    );
  }

  Container cambioCuerpo() {
    if (mode == "base") {
      return cuerpoBase();
    } else if (mode == "avatar") {
      return cuerpoAvatar();
    } else {
      return cuerpoBase();
    }
  }

  Container cuerpoAvatar() {
    return Container(
      height: heightA * 0.8,
      width: widthA,
      child: Stack(children: [

        Column(
          children: [
            Align(
              child: globals.textoConBorde("Elige un avatar !", 35, 5, Colors.white, Colors.black),
            ),

            SizedBox(height: 20,),

            Align(
              alignment: Alignment.center,
              child: Container(
                //color: Colors.green,
                height: 500,
                width: widthA*0.35,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    
                    mainAxisSpacing:0,
                    
                    mainAxisExtent: 160
                  ), 
                  itemCount: globals.listaAvatares.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return globals.listaAvatares[index];
                  },
                ),
                
              ),
            ),
          ],
        ),


        Align(
          alignment: Alignment.bottomLeft,
          child: InkWell(
            onTap: () {
              setState(() {
                mode = "base";
              });
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
        )
      ]),
    );
  }

  Container cuerpoBase() {
    return Container(
      height: heightA * 0.8,
      width: widthA,
      child: Stack(
        children: [
          Column(
            children: [
              //ALIGN CON EL BOTON DE CAMBIAR AVATAR
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      mode = "avatar";
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top:30),
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
                      globals.textoAvatar,
                      style: TextStyle(color: globals.colorAvatar, fontSize: 22),
                    ),
                  ),
                ),
              ),

              //BOTON PARA CAMBIAR EL NOMBRE DE USUARIO
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      mode = "avatar";
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(top:30),
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
                      "Cambiar usuario",
                      style: TextStyle(color: globals.colorAvatar, fontSize: 22),
                    ),
                  ),
                ),
              ),

              //BOTON PARA EDITAR LA CONTRASEÑA
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      mode = "avatar";
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top:30),
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
                      "Cambiar contraseña",
                      style: TextStyle(color: globals.colorAvatar, fontSize: 22),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(LeftSlide(child: SegundaMainMenu()));
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
          )
        ],
      ),
    );
  }
}
