// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import '../user/metodosBBDD.dart';
import '../user/transition.dart';
import 'mainMenu.dart';
import "package:proyecto/globals.dart" as globals;

class Online extends StatefulWidget {
  Online2 createState() => Online2();
}

class Online2 extends State<Online> {
  var size, heightA, widthA;

  Color colorError = Colors.green;

  //VARIABLE QUE INDICA COMO CAMBIA EL CUERPO DE LA CLASE 'ONLINE' EN BASE A LOS
  //BOTONES QUE CLICKEAMOS
  String mode = "base";

  //TEXTO DE ERROR SI NO EXISTE LA SALA
  String errorUnirse = "";

  //STRING QUE GUARDA EL CODIGO QUE ESCRIBE EL USUARIO PARA UNIRSE
  String codigoEscrito = "";

  String textoEsperar = "Esperando al jugador 2...";

  int codigoRecibido = 0;
  int codigoPartida = 0;
  int codigoJugador2 = 0;

  Timer? timerJugador2;
  Timer? timerJugador1;
  Timer? timerCuentaAtras;

  //CUENTA ATRAS QUE TIENE LUGAR UNA VEZ SE ESTABLECE LA CONEXION ENTRE JUGADORES
  int cuentaAtrasOnline = 10;

  bool esperandoCodigo = false;
  bool conexionLista = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    setState(() {
      size = MediaQuery.of(context).size;
      heightA = size.height;
      widthA = size.width;
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/onlineBG.png"),
                fit: BoxFit.cover)),
        height: heightA,
        width: widthA,
        child: Column(
          children: [
            //container que equivale al 20% de la pantalla que contiene el menú en el que estamos ("Online")
            Container(
              height: heightA * 0.2,
              width: widthA,
              child: Stack(
                children: [
                  //barra rosa que sale debajo del texto que se encuentra justo debajo
                  Positioned(
                    top: 70,
                    child: Container(
                      alignment: Alignment.center,
                      color: Color.fromARGB(255, 211, 80, 135),
                      width: widthA,
                      height: 30,
                    ),
                  ),

                  //texto 'Online'
                  Container(
                    alignment: Alignment.center,
                    child: globals.textoConBorde(
                        "Online", 60, 8, Colors.white, Colors.black),
                  )
                ],
              ),
            ),

            //el resto de la pagina (80%) es un menú que variará dependiendo de donde estemos
            //cuerpoUnirse: container con el contenido del botón unirse a partida
            //cuerpoCrear: container con el contenido del botón crear partida
            //cuerpoMenu: container con el contenido principal, con los botones de crear y unirse a partida
            changeMenu(),
          ],
        ),
      ),
    );
  }

//en base a la variable'mode' el contenido del 80% del cuerpo cambiará
  Container changeMenu() {
    if (mode == "crear") {
      return cuerpoCrear();
    } else if (mode == "unirse") {
      return cuerpoUnirse();
    } else {
      return cuerpoMenu();
    }
  }

//cuerpo que equivale al proceso de crear una sala
  Container cuerpoCrear() {
    return Container(
      width: widthA,
      height: heightA * 0.8,
      child: Stack(
        children: [
          Column(
            children: [
              //texto que indica el codigo de la partida y el texto 'el codigo de la partida es'
              Align(
                alignment: Alignment.center,
                child: globals.textoConBorde("El codigo de la partida es:", 26,
                    6, Colors.white, Colors.black),
              ),
              const SizedBox(
                height: 12,
              ),
              Align(
                alignment: Alignment.center,
                child: (globals.textoConBorde(codigoPartida.toString(), 52, 8,
                    Color.fromARGB(255, 255, 255, 255), Colors.black)),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    textoEsperar,
                    style: TextStyle(fontSize: 24),
                  )),

              cuentaAtras(),
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
        ],
      ),
    );
  }

//cuerpo que equivale al proceso de unirse a una sala
  Container cuerpoUnirse() {
    return Container(
      width: widthA,
      height: heightA * 0.8,
      child: Stack(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                //CUADRO DE TEXTO PARA EL CÓDIGO DE PARTIDA
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 250,
                    child: TextFormField(
                      onSaved: (value) {
                        codigoEscrito = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo vacío';
                        }
                      },
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: "CODIGO DE PARTIDA",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                //BOTON PARA ENTRAR EN PARTIDA
                InkWell(
                  onTap: () async {
                    setState(() {
                      errorUnirse = "Buscando sala...";
                    });
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      bool bbb = await metodosBBDD()
                          .consultarCodigoOnline(int.parse(codigoEscrito));

                      if (bbb == true) {
                        setState(() {
                          codigoJugador2 = int.parse(codigoEscrito);
                          errorUnirse = "Te has unido a la sala.";
                        });
                        entrarPartida(int.parse(codigoEscrito));
                      } else {
                        resetTextoError();
                        colorError = Colors.red;
                        setState(() {
                          errorUnirse = "La sala no existe.";
                        });
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 180,
                    child: Text(
                      "Unirse a partida",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 211, 80, 135),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    errorUnirse,
                    style: TextStyle(color: colorError, fontSize: 22),
                  ),
                ),

                cuentaAtras(),
              ],
            ),
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
        ],
      ),
    );
  }

  Container cuerpoMenu() {
    return Container(
        width: widthA,
        height: heightA * 0.8,
        child: Stack(
          children: [
            Column(
              children: [
                InkWell(
                    onTap: () async {
                      if (esperandoCodigo == false) {
                        esperandoCodigo = true;
                        //Crea la partida y devuelve el codigo de la partida
                        comprobacionJugador1Listo();
                        globals.numJugador = 1;
                      }
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                        alignment: Alignment.center,
                        height: 60,
                        width: 200,
                        child: Text(
                          "Crear partida",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 211, 80, 135),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )),
                InkWell(
                    onTap: () {
                      comprobacionJugador2Listo();
                      globals.numJugador = 2;
                      setState(() {
                        mode = "unirse";
                      });
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                        alignment: Alignment.center,
                        height: 60,
                        width: 200,
                        child: Text(
                          "Unirse a partida",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 211, 80, 135),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ))
              ],
            ),
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
            )
          ],
        ));
  }

  Align cuentaAtras() {
    if (conexionLista == true) {
      return Align(
        alignment: Alignment.center,
        child: Container(
            margin: EdgeInsets.only(top: 40),
            child: globals.textoConBorde(cuentaAtrasOnline.toString(), 60, 10,
                Colors.white, Colors.black)),
      );
    } else {
      return Align(
        child: Container(),
      );
    }
  }

// Jugador 1 queda esperando partida de jugador 2 //
  void comprobacionJugador1Listo() async {
    int codigoJugador1 = await recibirCodigo();
    // Guardo el codigo de la partida que ha creado el jugador 1 //
    globals.codigoPartida = codigoJugador1;

    metodosBBDD methods = metodosBBDD();

    bool n = false;

    do {
      n = await methods.consultarPartidaOnline(codigoJugador1);

      if (n) {
        await methods.insertarNombreJugador1(
            globals.codigoPartida, globals.nombreUsuario);

        setState(() {
          textoEsperar = "El Jugador 2 ya se ha unido.";
          conexionLista = true;
          // Indicar el jugador //
          // globals.numJugador = 1;
          print("Ha entrado en la comprobacion del jugador 1");
        });

        print("player1");
        timerCAtras();
      }
    } while (!n);

    // timerJugador1 = Timer.periodic(Duration(seconds: 2) , (timerJugador1) async {

    //   //Cada cinco segundos lo que va a hacer sera llamar a la funcion esperarJugador()

    //   metodosBBDD methods = metodosBBDD();

    //   if (await methods.consultarPartidaOnline(codigoJugador1) == true) {

    //     await methods.insertarNombreJugador1(globals.codigoPartida, globals.nombreUsuario);

    //     setState(() {
    //       textoEsperar = "El Jugador 2 ya se ha unido.";
    //       conexionLista = true;
    //       // Indicar el jugador //
    //       globals.numJugador = 1;
    //       print("Ha entrado en la comprobacion del jugador 1");
    //     });

    //     timerCAtras();
    //     timerJugador1.cancel();

    //   }
    // });
  }

// Jugador 2 queda esperando partida de jugador 1 //
  void comprobacionJugador2Listo() async {
    //Cada cinco segundos lo que va a hacer sera llamar a la funcion esperarJugador()
    // Guardo el codigo de la partida a la que se ha unido el jugador 2 //
    globals.codigoPartida = codigoJugador2;
    metodosBBDD methods = metodosBBDD();

    bool n = false;

    do {
      n = await methods.consultarPartidaOnline(codigoJugador2);

      if (n) {
        await methods.insertarNombreJugador2(
            globals.codigoPartida, globals.nombreUsuario);
        setState(() {
          conexionLista = true;
          // Indica el jugador que es //
          globals.numJugador = 2;
        });

        print("player2");
        timerCAtras();
      }
    } while (!n);

    // timerJugador2 = Timer.periodic(Duration(seconds: 2), (timerJugador2) async {

    //   //Si est devuelve true significa que el jugador que esta buscando la partida ha encontrado el codigo
    //   //de la partida que ha creado el jugador 1
    //   if (await methods.consultarPartidaOnline(codigoJugador2) == true) {

    //     await methods.insertarNombreJugador2(globals.codigoPartida, globals.nombreUsuario);

    //     setState(() {
    //       conexionLista = true;
    //       // Indica el jugador que es //
    //       globals.numJugador = 2;
    //     });

    //     timerCAtras();
    //     timerJugador2.cancel();

    //   }
    // });
  }

  //Devuelve el codigo de la partida que se ha creado
  Future<int> recibirCodigo() async {
    codigoRecibido = await metodosBBDD().CrearPartidaOnline();
    setState(() {
      codigoPartida = codigoRecibido;
      mode = "crear";
    });
    esperandoCodigo = false;
    return codigoPartida;
  }

  Future<void> entrarPartida(int code) async {
    await metodosBBDD().entrarPartidaOnline(code);
  }

  late Timer timerError;
  void resetTextoError() {
    int n = 0;
    const oneSec = Duration(seconds: 1);
    timerError = Timer.periodic(
      oneSec,
      (Timer timerError) {
        if (n == 4) {
          setState(() {
            errorUnirse = "";
          });
          colorError = Colors.green;
          timerError.cancel();
        } else {
          n++;
        }
      },
    );
  }

  late Timer timerAtras;
  void timerCAtras() {
    const oneSec = Duration(seconds: 1);
    timerAtras = Timer.periodic(
      oneSec,
      (Timer timerAtras) {
        if (cuentaAtrasOnline > 0) {
          setState(() {
            cuentaAtrasOnline--;
          });
        } else {
          //Seteamos a 2 para activar el online
          globals.gameMode = 2;
          globals.win = 2;
          Navigator.of(context).pushNamed("/inGameOnline");
          timerAtras.cancel();
        }
      },
    );
  }
}
