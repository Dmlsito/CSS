import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'minigame.dart';
import 'package:audioplayers/audioplayers.dart';

bool sesionIniciada = false;

double anchoPantalla = 0;

String nombreUsuario = "";

int puntos2 = 0;
int puntos1 = 0;

//AVATARES
String neutral = "assets/images/neutral.png";
String happy = "assets/images/happy.png";
String sad = "assets/images/sad.png";

//VARIABLE QUE INDICA SI HEMOS GANADO O PERDIDO
bool victoria = false;

//VARIABLE CON EL ULTIMO MINIJUEGO JUGADO, PARA EVITAR QUE SE REPITAN LOS MINJUEGOS
String ultimoMinijuego = "";

//variable que se cambia al final de cada minijuego en base a si ganas o pierdes
//si ganas la clase inGame subirá un punto, si pierdes te restará vida
//0 -> derrota
// 1-> victoria
// 2 -> primeraEjecuacion, no ejecuta los Timers de la clase inGame
int win = 2;
int codigoPartida = 0;

//variable que vigila en que modo de juego estamos, ya que decide en que navigators tenemos que entrar
//1.historia
//2.online
//3.galeria
int gameMode = 1;

//variable para que la musica del menu se lance al entrar a la clase, esta variable sirve para
//evitar que se ejecuten varias canciones simultaneamente
bool menuMusic = true;

//variable de tus puntos, aumenta al ganar minijuegos
int points = 0;

//lista de todos los minijuegos, se usa para navegar entre ellos en el 'inGame'
List<String> listaMinijuegos = [
  "/simon",
  "/karate",
  "/frutas",
  "/fallout",
  "/clickImagenes",
  "/zombies",
  "/pesca",
  "/pipes",
  "/reloj",
  "/carrera",
  "/bolsasDinero"
  //"/topos"
];

//variable de minijuegois que quedan hasta acabar la partida
int juegosRestantes = 10;

//lista de los corazones que tienes en partida
List<Container> misVidas = [
  Container(
    height: 250 * 0.3,
    width: 315 * 0.3,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/hp.png"), fit: BoxFit.fitHeight)),
  ),
  Container(
    height: 250 * 0.3,
    width: 315 * 0.3,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/hp.png"), fit: BoxFit.fitHeight)),
  ),
  Container(
    height: 250 * 0.3,
    width: 315 * 0.3,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/hp.png"), fit: BoxFit.fitHeight)),
  ),
];

/*lista de los corazones que tiene tu rival en batallla online
List<Container> vidasRival = [
  Container(
    height: 250 * 0.3,
    width: 315 * 0.3,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/hp.png"), fit: BoxFit.fitHeight)),
  ),
  Container(
    height: 250 * 0.3,
    width: 315 * 0.3,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/hp.png"), fit: BoxFit.fitHeight)),
  ),
  Container(
    height: 250 * 0.3,
    width: 315 * 0.3,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/hp.png"), fit: BoxFit.fitHeight)),
  ),
];
*/

//lista con todos los corazones, se usa para volver a darle 3 vidas a la lista misVidas para volver a tener 3 vidas
List<Container> fullVidas = [
  Container(
    height: 250 * 0.3,
    width: 315 * 0.3,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/hp.png"), fit: BoxFit.fitHeight)),
  ),
  Container(
    height: 250 * 0.3,
    width: 315 * 0.3,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/hp.png"), fit: BoxFit.fitHeight)),
  ),
  Container(
    height: 250 * 0.3,
    width: 315 * 0.3,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/hp.png"), fit: BoxFit.fitHeight)),
  ),
];

//lista de info de cada minijuego para el menú de galeria
List<Minigame> listaMinigames = [
  //minijuego anxo: frutas
  Minigame(
      rutaIcon: "assets/images/minigames/iconFrutas.png",
      ruta: "/frutas",
      nombre: "Organiza las frutas"),
  //minijuego anxo: simon dice
  Minigame(
      rutaIcon: "assets/images/minigames/iconSimon.png",
      ruta: "/simon",
      nombre: "Simón dice"),
  //minijuego anxo: karate
  Minigame(
      rutaIcon: "assets/images/minigames/iconKarate.png",
      ruta: "/karate",
      nombre: "Puñetazo de karate"),
  //minijuego pablo: fallout
  Minigame(
      rutaIcon: "assets/images/minigames/iconFallout.png",
      ruta: "/fallout",
      nombre: "Piedra, papel, Fallout"),
  //minijuego dani: bolsas dinero
  Minigame(
      rutaIcon: "assets/images/minigames/iconDinero.png",
      ruta: "/bolsasDinero",
      nombre: "Lluvia de dinero"),
  //minijuego dani: zombies
  Minigame(
      rutaIcon: "assets/images/minigames/iconZombies.png",
      ruta: "/zombies",
      nombre: "Apocalipsis Zombie"),
  //minijuego pablo: clickar imagenes
  Minigame(
      rutaIcon: "assets/images/minigames/iconPulsar.png",
      ruta: "/bolsasDinero",
      nombre: "Cubos por doquier"),
  //minijuego dani: pesca
  Minigame(
      rutaIcon: "assets/images/minigames/iconPescar.png",
      ruta: "/pesca",
      nombre: "Tarde de pesca"),
  //minijuego marcos: ruleta
  Minigame(
      rutaIcon: "assets/images/minigames/iconRuleta.png",
      ruta: "/roulette",
      nombre: "Gira la ruleta"),
  //minijuego marcos: pipes
  Minigame(
      rutaIcon: "assets/images/minigames/iconPipes.png",
      ruta: "/pipes",
      nombre: "Lio de tuberias"),
  //minijuego riki: reloj
  Minigame(
      rutaIcon: "assets/images/minigames/iconReloj.png",
      ruta: "/reloj",
      nombre: "El tiempo justo"),
  //minijuego riki: carrera
  Minigame(
      rutaIcon: "assets/images/minigames/iconCarreras.png",
      ruta: "/carrera",
      nombre: "Rápidos y pero no tan furiosos"),
  //minijuego mangel: topos
  Minigame(
      rutaIcon: "assets/images/minigames/iconTopos.png",
      ruta: "/topos",
      nombre: "Golpea los topos"),
];

//VARIABLE QUE INDICA QUE JUGADOR ERES (1 O 2)
int numJugador = 0;

//FUNCION QUE DEVUELVE UN TEXTO CON BORDE, DANDOLE COMO PARÁMETROS TODA LA INFORMACIÓN RELEVANTE
Stack textoConBorde(String texto, double tamano, double tamanoBorde,
    Color colore, Color colorBorde) {
  return Stack(children: [
    Text(
      texto,
      style: TextStyle(
        fontSize: tamano,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = tamanoBorde
          ..color = colorBorde,
      ),
    ),
    Text(
      texto,
      style: TextStyle(
        fontSize: tamano,
        color: colore,
      ),
    )
  ]);
}

//AUDIO PLAYER PARA SONIDOS
final playerSound = AudioPlayer();
void playSound(String url) {
  playerSound.play(AssetSource(url));
}

//AUDIO PLAYER Y TIMER PARA REINICIAR LA CANCIÓN
final player = AudioPlayer();
void playFile(String url) {
  player.play(AssetSource(url));
}

int duracionCancion = 64;
late Timer timer;

int _start = duracionCancion;
void startMusicaMenu(String song) {
  _start = duracionCancion;
  const oneSec = Duration(seconds: 1);
  timer = Timer.periodic(
    oneSec,
    (Timer timer) {
      if (_start == 0) {
        playFile(song);
        _start = duracionCancion;
      } else {
        _start--;
      }
    },
  );
}

//LISTA DE TODOS LOS REGISTROS DE PARTIDAS JUGADAS
List<Container> listaRanking = [];

void crearRanking(bool victoria, int puntos, int vidas) {
  if (victoria == true) {
    listaRanking.add(Container(
        //color: Colors.pink,
        width: anchoPantalla * 0.8,
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textoConBorde("Victoria !", 36, 5, Color.fromARGB(255, 255, 217, 0),
                Colors.black),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, //Center Row contents horizontally,
              crossAxisAlignment:
                  CrossAxisAlignment.center, //Center Row contents vertically,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Center Column contents vertically,
                  crossAxisAlignment: CrossAxisAlignment
                      .start, //Center Column contents horizontally,
                  children: [
                    textoConBorde("Puntos: " + puntos.toString(), 22, 4,
                        Colors.white, Colors.black),
                    textoConBorde("Vidas restantes: " + vidas.toString(), 22, 4,
                        Colors.white, Colors.black),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                textoConBorde("Historia", 28, 5, Colors.blue, Colors.black)
              ],
            ),
          ],
        )));
  } else {
    listaRanking.add(Container(
      width: anchoPantalla * 0.8,
      height: 120,
      child: Row(
        children: [
          textoConBorde("Derrota ...", 30, 5, Color.fromARGB(255, 127, 0, 211),
              Colors.black),
          textoConBorde("Puntos: " + puntos.toString(), 12, 4, Colors.white,
              Colors.black),
          textoConBorde("Vidas restantes: " + vidas.toString(), 12, 4,
              Colors.white, Colors.black),
        ],
      ),
    ));
  }
}

//TEXTO Y COLOR DEL TEXTO AL CAMBIAR DE AVATAR
String textoAvatar = "Cambiar avatar";
Color colorAvatar = Colors.white;

//LISTA DE AVATARES PARA CAMBAIR EN EL MENU DE AJUSTES
List<InkWell> listaAvatares = [
  InkWell(
    onTap: () {
      neutral = "assets/images/neutral.png";
      happy = "assets/images/happy.png";
      sad = "assets/images/sad.png";
    },
    child: Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/neutral.png"),
              fit: BoxFit.fitWidth)),
    ),
  ),
  InkWell(
    onTap: () {
      neutral = "assets/images/neutral2.png";
      happy = "assets/images/happy2.png";
      sad = "assets/images/sad2.png";
    },
    child: Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/neutral2.png"),
              fit: BoxFit.fitWidth)),
    ),
  ),
  InkWell(
    onTap: () {
      neutral = "assets/images/neutral3.png";
      happy = "assets/images/happy3.png";
      sad = "assets/images/sad3.png";
    },
    child: Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/neutral3.png"),
              fit: BoxFit.fitWidth)),
    ),
  ),
];
