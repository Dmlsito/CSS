// ignore_for_file: use_key_in_widget_constructors, annotate_overrides, unnecessary_new, unused_local_variable, use_build_context_synchronously, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/user/Usuario.dart';
import "package:proyecto/globals.dart" as globals;
import '../user/metodosBBDD.dart';
import '../user/transition.dart';
import 'menu.dart';

class Register extends StatefulWidget {
  TerceraLog createState() => TerceraLog();
}

bool camposUtilizados = false;

class TerceraLog extends State<Register> {
  var size, heightA, widthA;

  String nombreUsuario = "";
  String contrasena = "";
  final formKey = GlobalKey<FormState>();
  metodosBBDD methods = metodosBBDD();

  @override
  Widget build(BuildContext context) {
    setState(() {
      size = MediaQuery.of(context).size;
      heightA = size.height;
      widthA = size.width;
    });
    //SnackBar para mostrar el error en el register

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
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
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

                          //BOTON DE REGISTRARSE
                          InkWell(
                            onTap: () {
                              comprobarDatos();
                              register();
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

  void errorRegister(BuildContext context) {
    final snb = SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        children: [
          Icon(Icons.thumb_up),
          SizedBox(
            width: 20,
          ),
          Text("El usuario ya existe")
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snb);
  }

  void usuarioCreado(BuildContext context) {
    final snb = SnackBar(
      backgroundColor: Colors.green,
      content: Row(
        children: [
          Icon(Icons.thumb_up),
          SizedBox(
            width: 20,
          ),
          Text("Usario creado")
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snb);
  }

  //FUNCIONES

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //playFile("menu.mp3");
  }

  //Metodo de register
  void register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
    Usuario usuario = new Usuario(
        id: 1,
        nombre: nombreUsuario,
        contrasena: contrasena,
        vidas: 0,
        codigoPartida: 1);

    //Si el usuario existe entonces saltara un mensaje, si no se insertara en la BBDD
    if (camposUtilizados) {
      bool registro = await methods.registro(usuario);
      if (registro) {
        usuarioCreado(context);
        Navigator.of(context).pushNamed("/log");
      }
    } else
      errorRegister(context);
  }

  void comprobarDatos() async {
    bool nombreRepetido = await methods.compararUsuario(nombreUsuario);
    bool contrasenaRepetida = await methods.comprobarContrasena(contrasena);
    if (nombreRepetido || contrasenaRepetida) {
      camposUtilizados = false;
      print("Los campos estan ocupados");
    } else {
      camposUtilizados = true;
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
