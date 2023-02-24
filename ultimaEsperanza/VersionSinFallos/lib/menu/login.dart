// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, unnecessary_new, use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/user/Usuario.dart';
import "package:proyecto/globals.dart" as globals;
import '../user/metodosBBDD.dart';
import '../user/transition.dart';
import 'menu.dart';

class SegundaLog extends StatefulWidget {
  TerceraLog createState() => TerceraLog();
}

class TerceraLog extends State<SegundaLog> {
  var size, heightA, widthA;

  String nombreUsuario = "";
  String contrasena = "";
  final formKey = GlobalKey<FormState>();

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
                  image: AssetImage("assets/images/LOGIN.png"),
                  fit: BoxFit.fitWidth)),
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(AscendSlide(child: SegundaMenu()));
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 15, top: 15),
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/arrow.png"),
                          fit: BoxFit.fitHeight)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 400),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //CUADRO DE TEXTO PARA EL USUARIO
                          Container(
                            width: 250,
                            child: TextFormField(
                              onSaved: (value) {
                                nombreUsuario = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Campo vacío';
                                }
                              },
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 225, 0)),
                              decoration: const InputDecoration(
                                labelText: "Usuario",
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                            ),
                          ),

                          Container(
                            width: 250,
                            child: TextFormField(
                              onSaved: (value) {
                                contrasena = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Campo vacío';
                                }
                              },
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 225, 0)),
                              decoration: const InputDecoration(
                                labelText: "Contraseña",
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 40,
                          ),

                          //BOTON DE INICIAR SESIÓN
                          InkWell(
                            onTap: () async {
                              login();
                              // Usuario yo =  Usuario(id: 1, nombre: nombreUsuario, contrasena: contrasena, vidas: 0, codigoPartida: 1);

                              // bool prueba = await metodosBBDD().registro(yo);
                            },
                            child: Container(
                              height: 168 * 0.25,
                              width: 844 * 0.25,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/iniciar.png"),
                                      fit: BoxFit.fitWidth)),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          //BOTON DE REGISTRARSE
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).pushNamed("/register");
                            },
                            child: Container(
                              height: 168 * 0.25,
                              width: 844 * 0.25,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/registro.png"),
                                      fit: BoxFit.fitWidth)),
                            ),
                          ),
                        ],
                      )),
                ),
              )
            ],
          )),
    );
  }

  //FUNCIONES
  void errorLogin(BuildContext context) {
    final snb = SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        children: [
          // ignore: prefer_const_constructors
          Icon(Icons.thumb_up),
          SizedBox(
            width: 20,
          ),
          Text("El usuario no existe")
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snb);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //playFile("menu.mp3");
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
    metodosBBDD methods = new metodosBBDD();
    bool inicioSesion = await methods.compararUsuario(nombreUsuario);
    bool contrasenaSesion = await methods.comprobarContrasena(contrasena);
    if (inicioSesion && contrasenaSesion) {
      globals.sesionIniciada = true;
      Navigator.of(context).pushNamed("/MainMenu");
    } else {
      errorLogin(context);
    }
  }

  //AUDIO PLAYER Y TIMER PARA REINICIAR LA CANCIÓN
  final player = AudioPlayer();
  void playFile(String url) {
    player.play(AssetSource(url));
  }

  late Timer timer;
  int _start = 64;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            playFile("menu.mp3");
            _start = 64;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
