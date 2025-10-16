// ======================================================
// Entrega semana 2 — Dart (interactiu + demo)
// ======================================================

import 'dart:io';

// -----------------------------
// Helpers d'impressió i entrada
// -----------------------------
void printHeader(String title) {
  stdout.writeln("\n================= $title =================");
}

void printItem(int n, Object? value) {
  stdout.writeln("$n) $value");
}

String _prompt(String msg) {
  stdout.write(msg);
  final s = stdin.readLineSync();
  return (s ?? '').trim();
}

int _readInt(String msg) {
  while (true) {
    final t = _prompt(msg);
    final v = int.tryParse(t);
    if (v != null) return v;
    stdout.writeln("Valor no vàlid. Intenta-ho de nou.");
  }
}

double _readDouble(String msg) {
  while (true) {
    final t = _prompt(msg).replaceAll(',', '.');
    final v = double.tryParse(t);
    if (v != null) return v;
    stdout.writeln("Valor no vàlid. Intenta-ho de nou.");
  }
}

String _readNonEmpty(String msg) {
  while (true) {
    final t = _prompt(msg);
    if (t.isNotEmpty) return t;
    stdout.writeln("El text no pot ser buit.");
  }
}

// ======================================================
// Exercicis (funcions pures quan té sentit)
// ======================================================

// 1) Hola, Dart
void e1_holaDart() {
  stdout.writeln("Hola, bienvenido al mundo de Dart!");
}

// 2) Variables bàsiques -> retornem el missatge formatat
String e2_perfil(String nombre, int edad, double altura) {
  return "Mi nombre es $nombre, tengo $edad años y mido $altura metros.";
}

// 3) Operacions matemàtiques sobre dos enters (resultats textuals)
List<String> e3_ops(int a, int b) {
  final suma = a + b;
  final resta = a - b;
  final mult = a * b;
  final div = b != 0 ? (a / b) : double.nan;
  final out = <String>[];
  out.add("Suma: $suma");
  out.add("Resta: $resta");
  out.add("Multiplicación: $mult");
  if (b == 0) {
    out.add("División: no se puede dividir por cero");
  } else {
    out.add("División: $div");
  }
  return out;
}

// 4) Condicional simple
String e4_signo(int n) {
  if (n > 0) {
    return "positivo";
  } else if (n < 0) {
    return "negativo";
  } else {
    return "cero";
  }
}

// 5) Bucle for 1..10
List<int> e5_1a10() {
  final xs = <int>[];
  for (int i = 1; i <= 10; i++) {
    xs.add(i);
  }
  return xs;
}

// 6) Taula multiplicar 1..10
List<String> e6_tabla(int n) {
  final out = <String>[];
  for (int i = 1; i <= 10; i++) {
    out.add("$n x $i = ${n * i}");
  }
  return out;
}

// 7) Llista de 5 fruites -> retornem la mateixa llista
List<String> e7_frutas(List<String> frutas) {
  return List<String>.from(frutas);
}

// 8) Funció saludar
String e8_saludar(String nombre) {
  return "Hola $nombre!";
}

// 9) Par o impar
String e9_parImpar(int n) {
  if (n % 2 == 0) {
    return "par";
  } else {
    return "impar";
  }
}

// 10) Promig de 3 notes + missatge
String e10_promedio(double n1, double n2, double n3) {
  final prom = (n1 + n2 + n3) / 3.0;
  if (prom >= 5.0) {
    return "Promedio: ${prom.toStringAsFixed(2)} → Aprobado";
  } else {
    return "Promedio: ${prom.toStringAsFixed(2)} → Suspendido";
  }
}

// ======================================================
// DEMO (sense entrades)
// ======================================================
void runDemo() {
  printHeader("Entrega semana 2 — DEMO");

  // 1
  e1_holaDart();
  // 2
  printItem(2, e2_perfil("Ada", 21, 1.70));
  // 3
  printItem(3, e3_ops(8, 2));
  // 4
  printItem(4, e4_signo(-3));
  // 5
  printItem(5, e5_1a10());
  // 6
  printItem(6, e6_tabla(7));
  // 7
  printItem(7, e7_frutas(["manzana","pera","plátano","naranja","uva"]));
  // 8
  printItem(8, e8_saludar("Eloi"));
  // 9
  printItem(9, e9_parImpar(13));
  // 10
  printItem(10, e10_promedio(4.5, 7.0, 6.0));

  stdout.writeln("\n(Demo feta)");
}

// ======================================================
// INTERACTIU
// ======================================================
void runInteractive() {
  while (true) {
    printHeader("MENÚ — Entrega semana 2");
    stdout.writeln(
"1) Hola, Dart\n"
"2) Variables básicas\n"
"3) Operaciones matemáticas\n"
"4) Condicional simple (signo)\n"
"5) Bucle for 1..10\n"
"6) Tabla de multiplicar\n"
"7) Listas (5 frutas)\n"
"8) Función saludar(nombre)\n"
"9) Par o impar\n"
"10) Promedio de notas\n"
"0) Salir\n");

    final op = _prompt("Elige opción: ");
    if (op == "0") {
      stdout.writeln("Adiós!");
      break;
    } else if (op == "1") {
      e1_holaDart();
    } else if (op == "2") {
      final nombre = _readNonEmpty("  Nombre: ");
      final edad = _readInt("  Edad (entero): ");
      final altura = _readDouble("  Altura (metros): ");
      printItem(2, e2_perfil(nombre, edad, altura));
    } else if (op == "3") {
      final a = _readInt("  Primer número (entero): ");
      final b = _readInt("  Segundo número (entero): ");
      final res = e3_ops(a, b);
      for (final r in res) stdout.writeln("  $r");
    } else if (op == "4") {
      final n = _readInt("  Número (entero): ");
      printItem(4, e4_signo(n));
    } else if (op == "5") {
      printItem(5, e5_1a10());
    } else if (op == "6") {
      final n = _readInt("  Número para la tabla: ");
      for (final linea in e6_tabla(n)) {
        stdout.writeln("  $linea");
      }
    } else if (op == "7") {
      stdout.writeln("  Introduce 5 frutas:");
      final frutas = <String>[];
      for (int i = 1; i <= 5; i++) {
        frutas.add(_readNonEmpty("   fruta $i: "));
      }
      for (final f in e7_frutas(frutas)) {
        stdout.writeln("  $f");
      }
    } else if (op == "8") {
      final nombre = _readNonEmpty("  Nombre: ");
      printItem(8, e8_saludar(nombre));
    } else if (op == "9") {
      final n = _readInt("  Número (entero): ");
      printItem(9, e9_parImpar(n));
    } else if (op == "10") {
      final n1 = _readDouble("  Nota 1: ");
      final n2 = _readDouble("  Nota 2: ");
      final n3 = _readDouble("  Nota 3: ");
      printItem(10, e10_promedio(n1, n2, n3));
    } else {
      stdout.writeln("Opción no válida.");
    }
  }
}

// ======================================================
// main
// ======================================================
void main(List<String> args) {
  if (args.contains("--demo")) {
    runDemo();
  } else {
    runInteractive();
  }
}
