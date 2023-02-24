// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import '../user/metodosBBDD.dart';
import '../user/transition.dart';
import 'mainMenu.dart';
import "package:proyecto/globals.dart" as globals;

class Ranking extends StatefulWidget {
  Ranking2 createState() => Ranking2();
}

class Ranking2 extends State<Ranking> {
  var size, heightA, widthA;


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
                image: AssetImage("assets/images/rankingBG.png"),
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
                      color: Color.fromARGB(255, 90, 0, 0),
                      width: widthA,
                      height: 30,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: globals.textoConBorde(
                        "Ranking", 60, 8, Colors.white, Colors.black),
                  )
                ],
              ),
            ),


            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 3)
              ),
              height: heightA*0.7,
              width: widthA*0.8,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  
                  mainAxisSpacing:35,
                  
                  mainAxisExtent: 130,
                ), 
                itemCount: globals.listaRanking.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return globals.listaRanking[index];
                },
              ),
              
            ),
            //cambioCuerpo(),
          ],
        ),
      ),
    );
  }

  
}
