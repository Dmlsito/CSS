class Usuario {


  int id;
  String nombre;
  String contrasena;
  int vidas;
  // El codigo de partida si es una partida en local SIEMPRE va a ser 1 //
  // Si la partida es online, hay que generar un codigo aleatorio para hacer match enntre los dos jugadores //
  int codigoPartida;


  Usuario({required this.id,required this.nombre, required this.contrasena, required this.vidas, required this.codigoPartida});

 

}