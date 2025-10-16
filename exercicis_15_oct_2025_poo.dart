// ======================================================
// Ejercicios 15-Oct-2025 — POO en Dart (versió que segueix l’enunciat)
// Nota important:
// - L’enunciat té DOS blocs separats. Els dos demanen una classe "Animal".
//   En UN SOL fitxer Dart no podem definir dues vegades "Animal".
//   Per això, al segon bloc ("Ejemplos alternativos") renombro a "AnimalAlt"
//   per evitar col·lisions, però mantinc EXACTAMENT la resta d’exigències.
// - Al bloc principal, segueixo els 10 punts, incloent mixins i polímiques.
// - El punt 1 diu que "Animal.mover()" imprimeix "El animal se mueve", però
//   el punt 9 demana convertir "Animal" en abstracta. El codi final respecta
//   el PUNT 9 (Animal abstracta). Com a TRAÇA del punt 1, hi ha un mètode
//   'demoPaso1()' que mostra la versió temporal (només per demostració).
// ======================================================

import 'dart:io';

// -----------------------------
// Helpers
// -----------------------------
void printHeader(String title) {
  stdout.writeln("\n================= $title =================");
}

void printLine(Object? x) => stdout.writeln(x);

// ======================================================
// BLOC 1 — Jerarquía Animal (puntos 1..10)
// ======================================================

// (1) — Versió temporal per demostrar "El animal se mueve".
//     Només per traçar el punt 1 abans de fer-la abstracta al punt 9.
class _AnimalTemporal {
  final String nombre;
  _AnimalTemporal(this.nombre);
  void mover() => printLine("El animal se mueve");
}

void demoPaso1() {
  printHeader("Paso 1 — Animal (temporal, no abstracta)");
  final a = _AnimalTemporal("Genérico");
  a.mover(); // "El animal se mueve"
}

// (6) — Encapsulación: _edad + getter/setter (>=0)
// (9) — Animal abstracta: obliga a implementar mover()
abstract class Animal {
  final String nombre;
  int _edad = 0;

  Animal(this.nombre);

  int get edad => _edad;
  set edad(int e) {
    if (e >= 0) _edad = e; // Impedir negativos
  }

  void mover(); // abstracto (punto 9)
}

// (2) — Subclases Mammal, Bird y Fish con mover() específico
class Mammal extends Animal {
  Mammal(super.nombre);
  @override
  void mover() => printLine("$nombre camina sobre la tierra");

  @override
  String toString() => "Mammal(nombre: $nombre, edad: $edad)";
}

class Bird extends Animal {
  Bird(super.nombre);
  @override
  void mover() => printLine("$nombre vuela o camina (ave)");

  @override
  String toString() => "Bird(nombre: $nombre, edad: $edad)";
}

class Fish extends Animal {
  Fish(super.nombre);
  @override
  void mover() => printLine("$nombre nada en el agua");

  @override
  String toString() => "Fish(nombre: $nombre, edad: $edad)";
}

// (4) — Mixins Walk / Swim / Fly
mixin Walk { void caminar() => printLine("caminar"); }
mixin Swim { void nadar()   => printLine("nadar"); }
mixin Fly  { void volar()   => printLine("volar"); }

// (4) — Bat (Mammal with Walk, Fly) y Dolphin (Mammal with Swim)
class Bat extends Mammal with Walk, Fly {
  Bat(super.nombre);
  @override
  void mover() => printLine("$nombre se desplaza: camina y vuela");
  @override
  String toString() => "Bat($nombre)";
}

class Dolphin extends Mammal with Swim {
  Dolphin(super.nombre);
  @override
  void mover() => printLine("$nombre se desplaza nadando");
  @override
  String toString() => "Dolphin($nombre)";
}

// (5) — Duck: Bird with Walk, Swim, Fly
class Duck extends Bird with Walk, Swim, Fly {
  Duck(super.nombre);
  @override
  void mover() => printLine("$nombre puede caminar, nadar y volar");
  @override
  String toString() => "Duck($nombre)";
}

// Algunes classes concretes addicionals per al punt 7 i 8
class Cat extends Mammal with Walk {
  Cat(super.nombre);
  @override
  void mover() => printLine("$nombre camina sigilosamente");
  @override
  String toString() => "Cat($nombre)";
}

class Shark extends Fish with Swim {
  Shark(super.nombre);
  @override
  void mover() => printLine("$nombre nada y caza");
  @override
  String toString() => "Shark($nombre)";
}

// (8) — Ejemplo toString() ya implementado en clases concretas

// (10) — Integrador Zoológico usando la jerarquía y los mixins
void demoZoologicoIntegrador() {
  printHeader("Integrador (punto 10) — Zoológico");

  // (3) — Constructores con super(): Bird y Fish con nombre
  final pajaro = Bird("Gorrión");
  final pez = Fish("Dorada");
  pajaro.mover();
  pez.mover();

  // (7) — Polimorfismo: lista heterogénea y llamar mover()
  final animales = <Animal>[
    Cat("Michi")..edad = 2,
    Duck("Donald")..edad = 1,
    Shark("Bruce")..edad = 6,
    Bat("Wayne")..edad = 4,
    Dolphin("Flippy")..edad = 5,
  ];

  printLine("\n— Movimientos polimórficos —");
  for (var a in animales) {
    a.mover();
  }

  printLine("\n— toString() personalizado —");
  for (var a in animales) {
    printLine(a); // usa toString()
  }

  printLine("\n— Capacidades (mixins) —");
  for (var a in animales) {
    if (a is Walk) printLine("${a.nombre} puede caminar");
    if (a is Swim) printLine("${a.nombre} puede nadar");
    if (a is Fly)  printLine("${a.nombre} puede volar");
  }

  printLine("\n— Duck (punto 5): tres comportamientos —");
  final d = Duck("Daffy");
  d.caminar(); d.nadar(); d.volar();
}

// ======================================================
// BLOC 2 — Ejemplos alternativos (puntos 1..10)
// (Renombro 'Animal' -> 'AnimalAlt' para evitar colisión con el bloque anterior.)
// ======================================================

// (1) Clase base con constructor y atributos
class AnimalAlt {
  final String nombre;
  final String tipo;
  AnimalAlt(this.nombre, this.tipo);

  void descripcion() {
    printLine("Animal: $nombre, tipo: $tipo");
  }
}

// (2) Subclase Perro que añade 'raza' y sobreescribe descripcion()
class Perro extends AnimalAlt {
  final String raza;
  Perro(String nombre, this.raza) : super(nombre, "Perro");

  @override
  void descripcion() {
    printLine("Perro: $nombre, raza: $raza");
  }
}

// (3) Ave con _alturaVuelo, getter i setter (>=0)
class Ave {
  double _alturaVuelo = 0;
  double get alturaVuelo => _alturaVuelo;
  set alturaVuelo(double valor) {
    if (valor >= 0) _alturaVuelo = valor;
  }
}

// (4) Pez extiende AnimalAlt y añade nadar()
class Pez extends AnimalAlt {
  Pez(String nombre) : super(nombre, "Pez");
  void nadar() => printLine("$nombre está nadando.");
}

// (5) Gato con dos constructores (normal y .bebe)
class Gato {
  final String nombre;
  final int edad;
  Gato(this.nombre, this.edad);
  Gato.bebe(this.nombre) : edad = 0;

  @override
  String toString() => "Gato(nombre: $nombre, edad: $edad)";
}

// (6) Clase abstracta Vehiculo + Coche y Avion
abstract class Vehiculo {
  void mover();
}

class Coche extends Vehiculo {
  @override
  void mover() => printLine("El coche se desplaza por carretera");
}

class Avion extends Vehiculo {
  @override
  void mover() => printLine("El avión vuela en el cielo");
}

// (8) Composición Corazon dentro de Persona
class Corazon {
  void latir() => printLine("El corazón late");
}

class Persona {
  Corazon corazon = Corazon();
  void vivir() => corazon.latir();
}

// (9) Mixins Caminar / Volar / Nadar y combinaciones
mixin Caminar { void caminar() => printLine("caminar"); }
mixin Volar { void volar() => printLine("volar"); }
mixin Nadar { void nadar() => printLine("nadar"); }

class Pinguino with Caminar, Nadar {}
class Murcielago with Caminar, Volar {}
class Pato with Caminar, Volar, Nadar {}

// (10) Integrador alternativo — zoológico con capacidades
abstract class AnimalBase {
  String get nombre;
  void mover();
}

class Mamifero extends AnimalBase {
  @override
  final String nombre;
  Mamifero(this.nombre);
  @override
  void mover() => printLine("$nombre (mamífero) se mueve");
}

class AveBase extends AnimalBase {
  @override
  final String nombre;
  AveBase(this.nombre);
  @override
  void mover() => printLine("$nombre (ave) se mueve");
}

class PezBase extends AnimalBase {
  @override
  final String nombre;
  PezBase(this.nombre);
  @override
  void mover() => printLine("$nombre (pez) se mueve");
}

class GatoZoo extends Mamifero with Caminar {
  GatoZoo(super.nombre);
}

class MurcielagoZoo extends Mamifero with Caminar, Volar {
  MurcielagoZoo(super.nombre);
}

class DelfinZoo extends Mamifero with Nadar {
  DelfinZoo(super.nombre);
}

class PatoZoo extends AveBase with Caminar, Volar, Nadar {
  PatoZoo(super.nombre);
}

class TiburonZoo extends PezBase with Nadar {
  TiburonZoo(super.nombre);
}

void demoAlternativos() {
  printHeader("Ejemplos alternativos — Demo");

  // (1) y (2)
  final perro = Perro("Bobby", "Labrador");
  perro.descripcion();

  // (3)
  final ave = Ave();
  ave.alturaVuelo = 150;
  printLine("Ave con altura de vuelo: ${ave.alturaVuelo} m");

  // (4)
  final pez = Pez("Nemo");
  pez.descripcion();
  pez.nadar();

  // (5)
  final gatito = Gato.bebe("Michu");
  printLine(gatito);

  // (6) y (7)
  final vehiculos = <Vehiculo>[Coche(), Avion()];
  for (var v in vehiculos) { v.mover(); }

  // (8)
  final persona = Persona();
  persona.vivir();

  // (9)
  final pin = Pinguino(); pin.caminar(); pin.nadar();
  final mur = Murcielago(); mur.caminar(); mur.volar();
  final pat = Pato(); pat.caminar(); pat.volar(); pat.nadar();

  // (10) integrador alternativo
  final zoo = <AnimalBase>[
    GatoZoo("Garfield"),
    MurcielagoZoo("Wayne"),
    DelfinZoo("Flippy"),
    PatoZoo("Donald"),
    TiburonZoo("Bruce"),
  ];
  for (var a in zoo) {
    a.mover();
    if (a is Volar) printLine("${a.nombre} puede volar");
    if (a is Caminar) printLine("${a.nombre} puede caminar");
    if (a is Nadar) printLine("${a.nombre} puede nadar");
  }
}

// ======================================================
// main — mostra els dos blocs
// ======================================================
void main(List<String> args) {
  // Traça literal del punt 1 (Animal no abstracta imprimint el missatge)
  demoPaso1();

  // Bloc 1: jerarquia principal amb Animal abstracte (punt 9 complert) i integrador
  demoZoologicoIntegrador();

  // Bloc 2: exemples alternatius (amb renoms per evitar col·lisió de noms)
  demoAlternativos();
}
