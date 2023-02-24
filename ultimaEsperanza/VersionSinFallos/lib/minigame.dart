class Minigame{
  String rutaIcon;
  String ruta;
  String nombre;

  Minigame({required this.rutaIcon, required this.ruta, required this.nombre});

  String get getNombre {
    return nombre;
  }

  String get getrutaIcon {
    return rutaIcon;
  }

  String get getRuta {
    return ruta;
  }
}