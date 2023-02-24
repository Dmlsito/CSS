// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'package:mysql1/mysql1.dart';
import 'Usuario.dart';
import 'dart:math';
import "package:proyecto/globals.dart" as globals;

class metodosBBDD {
// Método para registrar Usuario //
  Future<bool> registro(Usuario usuario) async {
    //Primero de todo establecemos la conexion
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool comprobar = false;
    //Query para insertar los datos del jugador
    var result = await conexion.query(
        "INSERT INTO Usuario (Nombre, Contraseña,Vidas) value (?,?,?)",
        [usuario.nombre, usuario.contrasena, usuario.vidas]);

    //Como ya se ha realizado la operacion se setea el booleano a true y se cierra la conexion
    comprobar = true;
    //Cerramos conexion
    await conexion.close();
    return comprobar;
  }

// Método para retornar Usuario en funcion a su ID //
  Future<Usuario> retornarIdUsuario(String nombre) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    Usuario usuario = new Usuario(
        id: 0, nombre: "", contrasena: "", vidas: 0, codigoPartida: 1);

    String sql = "SELECT Id FROM Usuario WHERE Nombre = '" + nombre + "'";

    var resultQuery = await conexion.query(sql);

    if (resultQuery.isNotEmpty) {
      ResultRow row = resultQuery.first;

      usuario = Usuario(
          id: row[0],
          nombre: row[1],
          contrasena: row[2],
          vidas: row[3],
          codigoPartida: 1);
      return usuario;
    }

    await conexion.close();
    return usuario;
  }

  // Comprobar si existe un usuario para el login //
  Future<bool> compararUsuario(String nombre) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool existe = false;

    String sql = "SELECT Id FROM Usuario WHERE Nombre = '" + nombre + "'";

    var resultQuery = await conexion.query(sql);

    if (resultQuery.isNotEmpty) {
      existe = true;
      return existe;
    }

    await conexion.close();
    return existe;
  }

  //Metodo para comprobar si la contrasena existe
  Future<bool> comprobarContrasena(String contrasena) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool existe = false;

    String sql =
        "SELECT Id FROM Usuario WHERE Contraseña = '" + contrasena + "'";

    var resultQuery = await conexion.query(sql);

    if (resultQuery.isNotEmpty) {
      existe = true;
      return existe;
    }

    await conexion.close();
    return existe;
  }

// Consultar vidas para insertarlas entre minijuegos //
  Future<int> consultarVidas(Usuario usuario) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    int vidas = 0;

    String sql =
        "SELECT Id FROM Usuario WHERE id = '" + usuario.id.toString() + "'";

    var resultQuery = await conexion.query(sql);

    if (resultQuery.isNotEmpty) {
      ResultRow row = resultQuery.first;

      usuario = Usuario(
          id: row[0],
          nombre: row[1],
          contrasena: row[2],
          vidas: row[3],
          codigoPartida: 1);
      vidas = usuario.vidas;
    }

    await conexion.close();
    return vidas;
  }

// Consultar vidas de el jugador 1 entre minijuegos
  // Se utiliza el codigo de la partida que se guarda previamente
  // Para consultar las vidas del jugador 1

  Future<int> consultarVidaJugador1(int codigoPartida) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    int vidasJugador1 = 0;

    String sql = "SELECT vidasJugador1 FROM Partida WHERE Codigo = '" +
        codigoPartida.toString() +
        "'";

    var resultQuery = await conexion.query(sql);

    if (resultQuery.isNotEmpty) {
      ResultRow row = resultQuery.first;
      vidasJugador1 = row[0];
      return vidasJugador1;
    }

    await conexion.close();
    return vidasJugador1;
  }

  // Consultar vidas de el jugador 2 entre minijuegos
  // Se utiliza el codigo de la partida que se guarda previamente
  // Para consultar las vidas del jugador 2

  Future<int> consultarVidaJugador2(int codigoPartida) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    int vidasJugador2 = 0;

    String sql = "SELECT vidasJugador2 FROM Partida WHERE Codigo = '" +
        codigoPartida.toString() +
        "'";

    var resultQuery = await conexion.query(sql);

    if (resultQuery.isNotEmpty) {
      ResultRow row = resultQuery.first;
      vidasJugador2 = row[0];
      return vidasJugador2;
    }

    await conexion.close();
    return vidasJugador2;
  }

// Cambio de vidas entre pantallas //
  Future<bool> InsertarVidas(Usuario usuario) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool insertado = false;

    var resultQuery = await conexion.query(
        "UPDATE Usuario SET Vidas = ? WHERE id = ?",
        [usuario.vidas, usuario.id]);
    insertado = true;
    await conexion.close();
    return insertado;
  }

// Generar codigo de partida aleatorio para hacer match e insertarlo//

  Future<int> CrearPartidaOnline() async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    Random random = new Random();
    int randomNumber = random.nextInt(100);

    var result = await conexion.query(
        "INSERT INTO Partida (codigo, VidasJugador1, VidasJugador2) VALUES (?,?,?)",
        [randomNumber, 3, 0]);

    await conexion.close();
    return randomNumber;
  }

  // Funcion para que el jugador 2 se una a la partida que ha creado el jugador 1 //
  Future<bool> entrarPartidaOnline(int codigoPartida) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool insertado = false;

    var result = await conexion.query(
      "UPDATE Partida SET VidasJugador2 = 3 Where Codigo ='" +
          codigoPartida.toString() +
          "'",
    );
    insertado = true;

    await conexion.close();
    return insertado;
  }

  // Funcion para consultar si los dos jugadores online ya tienen 3 vidas, si tienen 3 vidas //
  // significa que ya pueden jugar en la misma partida //

  Future<bool> consultarPartidaOnline(int codigoPartida) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool iniciaPartida = false;
    int vida1 = 0;
    int vida2 = 0;
    String sql =
        "SELECT VidasJugador1, VidasJugador2 FROM Partida WHERE Codigo = '" +
            codigoPartida.toString() +
            "'";

    var resultQuery = await conexion.query(sql);

    if (resultQuery.isNotEmpty) {
      ResultRow row = resultQuery.first;
      vida1 = row[0];
      vida2 = row[1];
      if (vida1 == 3 && vida2 == 3) {
        iniciaPartida = true;
      }
    }

    await conexion.close();
    return iniciaPartida;
  }

  // Funcion para controlar el codigo de la partida, si existe o no //
  // Funcion para controlar el codigo de la partida, si existe o no //
  Future<bool> consultarCodigoOnline(int codigoPartida) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool iniciaPartida = false;
    int vidasComparado = 0;

    String sql = "SELECT VidasJugador1 FROM Partida WHERE Codigo = '" +
        codigoPartida.toString() +
        "'";

    var resultQuery = await conexion.query(sql);

    if (resultQuery.isNotEmpty) {
      ResultRow row = resultQuery.first;
      vidasComparado = row[0];
      if (vidasComparado == 3) {
        iniciaPartida = true;
      }
    }

    await conexion.close();
    return iniciaPartida;
  }

  // Cambio de vidas entre pantallas para el jugador1 //
  Future<bool> insertarVidasJugador1(int codigo, int numVidas) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool insertado = false;

    var resultQuery = await conexion.query(
        "UPDATE Partida SET vidasJugador1 = ? WHERE Codigo = ?",
        [numVidas, codigo]);
    insertado = true;
    await conexion.close();
    return insertado;
  }

  // Cambio de vidas entre pantallas para el jugador2 //
  Future<bool> insertarVidasJugador2(int codigo, int numVidas) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool insertado = false;

    var resultQuery = await conexion.query(
        "UPDATE Partida SET vidasJugador2 = ? WHERE Codigo = ?",
        [numVidas, codigo]);
    insertado = true;
    await conexion.close();
    return insertado;
  }

  // Función para consultar los puntos que tiene el jugador 1 en la bbdd //
  Future<int> consultarPuntosJugador1(int codigoPartida) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    int puntosJugador1 = 0;

    String sql = "SELECT puntosJugador1 FROM Partida WHERE Codigo = '" +
        codigoPartida.toString() +
        "'";

    var resultQuery = await conexion.query(sql);

    if (resultQuery.isNotEmpty) {
      ResultRow row = resultQuery.first;
      // Controlo si viene a null, si no viene a null le seteo el valor que traigo de la bbdd //
      if (row[0] != null) {
        puntosJugador1 = row[0];
        return puntosJugador1;
      }
      // Sino se queda a 0 los puntos del jugador que mando como return de la funcion //

    }

    await conexion.close();
    return puntosJugador1;
  }

// Función para consultar los puntos que tiene el jugador 2 en la bbdd //
  Future<int> consultarPuntosJugador2(int codigoPartida) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    int puntosJugador2 = 0;

    String sql = "SELECT puntosJugador2 FROM Partida WHERE Codigo = '" +
        codigoPartida.toString() +
        "'";

    var resultQuery = await conexion.query(sql);

    if (resultQuery.isNotEmpty) {
      ResultRow row = resultQuery.first;
      // Controlo si viene a null, si no viene a null le seteo el valor que traigo de la bbdd //
      if (row[0] != null) {
        puntosJugador2 = row[0];
        return puntosJugador2;
      }
      // Sino se queda a 0 los puntos del jugador que mando como return de la funcion //

    }

    await conexion.close();
    return puntosJugador2;
  }

  // Cambio de vidas entre pantallas para el jugador1 //
  Future<bool> insertarPuntosJugador1(int codigo, int numPuntos) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool insertado = false;

    var resultQuery = await conexion.query(
        "UPDATE Partida SET puntosJugador1 = ? WHERE Codigo = ?",
        [numPuntos, codigo]);
    insertado = true;
    await conexion.close();
    return insertado;
  }

  // Cambio de puntos entre pantallas para el jugador2 //
  Future<bool> insertarPuntosJugador2(int codigo, int numPuntos) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool insertado = false;

    var resultQuery = await conexion.query(
        "UPDATE Partida SET puntosJugador2 = ? WHERE Codigo = ?",
        [numPuntos, codigo]);
    insertado = true;
    await conexion.close();
    return insertado;
  }

  // Insertar nombre del jugador 1 //
  Future<bool> insertarNombreJugador1(int codigo, String nombreJugador1) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool insertado = false;

    var resultQuery = await conexion.query(
        "UPDATE Partida SET nombreJugador1 = ? WHERE Codigo = ?",
        [nombreJugador1, codigo]);
    insertado = true;
    await conexion.close();

    return insertado;
  }

  // Insertar nombre jugador 2//
  Future<bool> insertarNombreJugador2(int codigo, String nombreJugador2) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    bool insertado = false;

    var resultQuery = await conexion.query(
        "UPDATE Partida SET nombreJugador2 = ? WHERE Codigo = ?",
        [nombreJugador2, codigo]);
    insertado = true;
    await conexion.close();

    return insertado;
  }

  // Función para consultar el nombre que tiene el jugador 1 en la bbdd //
  Future<String> consultarNombreJugador1(int codigoPartida) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    String nombreJugador1 = "";

    String sql = "SELECT nombreJugador1 FROM Partida WHERE Codigo = '" +
        codigoPartida.toString() +
        "'";

    var resultQuery = await conexion.query(sql);

    if (resultQuery.isNotEmpty) {
      ResultRow row = resultQuery.first;
      // Controlo si viene a null, si no viene a null le seteo el valor que traigo de la bbdd //
      if (row[0] != null) {
        nombreJugador1 = row[0];
        return nombreJugador1;
      }
      // Sino se queda a 0 los puntos del jugador que mando como return de la funcion //

    }

    await conexion.close();
    return nombreJugador1;
  }

  // Función para consultar el nombre que tiene el jugador 2 en la bbdd //
  Future<String> consultarNombreJugador2(int codigoPartida) async {
    final conexion = await MySqlConnection.connect(ConnectionSettings(
        host: "db4free.net",
        port: 3306,
        user: "aulanosa123",
        password: "instiagra",
        db: "warioware123"));

    String nombreJugador2 = "";

    String sql = "SELECT nombreJugador2 FROM Partida WHERE Codigo = '" +
        codigoPartida.toString() +
        "'";

    var resultQuery = await conexion.query(sql);

    if (resultQuery.isNotEmpty) {
      ResultRow row = resultQuery.first;
      // Controlo si viene a null, si no viene a null le seteo el valor que traigo de la bbdd //
      if (row[0] != null) {
        nombreJugador2 = row[0];
        return nombreJugador2;
      }
      // Sino se queda a 0 los puntos del jugador que mando como return de la funcion //

    }

    await conexion.close();
    return nombreJugador2;
  }
}
