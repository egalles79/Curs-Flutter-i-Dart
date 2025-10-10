// ======================================================
// Ejercicios 8-Oct-2025 — Controles de flujo en Dart
// - Sense ternàries (if/else clàssic)
// - Lògica en funcions pures quan té sentit
// - Mode interactiu amb stdin i mode demo amb --demo
// ======================================================

import 'dart:io';

// -----------------------------
// Helpers d'impressió
// -----------------------------
void printHeader(String title) {
  stdout.writeln("\n================= $title =================");
}

void printItem(int n, Object? value) {
  stdout.writeln("$n) $value");
}

// -----------------------------
/* Helpers d'entrada (prompts) */
// -----------------------------
String _prompt(String msg) {
  stdout.write(msg);
  final s = stdin.readLineSync();
  return (s ?? '').trim();
}

int _readInt(String msg, {int? min, int? max}) {
  while (true) {
    final t = _prompt(msg);
    final v = int.tryParse(t);
    if (v != null && (min == null || v >= min) && (max == null || v <= max)) {
      return v;
    }
    stdout.writeln("Valor no vàlid. Torna-ho a provar.");
  }
}

double _readDouble(String msg, {double? min, double? max}) {
  while (true) {
    final t = _prompt(msg);
    final v = double.tryParse(t.replaceAll(',', '.'));
    if (v != null && (min == null || v >= min) && (max == null || v <= max)) {
      return v;
    }
    stdout.writeln("Valor no vàlid. Torna-ho a provar.");
  }
}

String _readNonEmpty(String msg) {
  while (true) {
    final t = _prompt(msg);
    if (t.isNotEmpty) return t;
    stdout.writeln("No pot estar buit. Torna-ho a provar.");
  }
}

// ======================================================
// BLOC 1 — Condicionals (if, else if, switch)
// ======================================================

// 1) Major/menor/igual que 100
String b1_1_compare100(int n) {
  if (n > 100) {
    return "major que 100";
  } else if (n < 100) {
    return "menor que 100";
  } else {
    return "igual a 100";
  }
}

// 2) Classificació d'edats
String b1_2_classificaEdat(int edat) {
  if (edat < 12) {
    return "Nen/Nena";
  } else if (edat < 18) {
    return "Adolescent";
  } else {
    return "Adult";
  }
}

// 3) Dia de la setmana amb switch (1..7)
String b1_3_diaSetmana(int n) {
  switch (n) {
    case 1:
      return "Dilluns";
    case 2:
      return "Dimarts";
    case 3:
      return "Dimecres";
    case 4:
      return "Dijous";
    case 5:
      return "Divendres";
    case 6:
      return "Dissabte";
    case 7:
      return "Diumenge";
    default:
      return "Número de dia invàlid";
  }
}

// 4) Nota final del alumne
String b1_4_notaFinal(num nota) {
  if (nota >= 0 && nota <= 4) {
    return "Suspens";
  } else if (nota >= 5 && nota <= 6) {
    return "Aprovat";
  } else if (nota >= 7 && nota <= 8) {
    return "Notable";
  } else if (nota >= 9 && nota <= 10) {
    return "Excel·lent";
  } else {
    return "Nota invàlida";
  }
}

// 5) Menú d'operacions amb switch
String b1_5_operacio(int opcio, double a, double b) {
  switch (opcio) {
    case 1:
      return "Suma: ${(a + b)}";
    case 2:
      return "Resta: ${(a - b)}";
    case 3:
      return "Multiplicació: ${(a * b)}";
    case 4:
      if (b == 0) {
        return "Divisió per zero no permesa";
      } else {
        return "Divisió: ${(a / b)}";
      }
    default:
      return "Opció invàlida";
  }
}

// ======================================================
// BLOC 2 — Bucles (for, for-in, while, do-while)
// ======================================================

// 6) Comptar del 1 al 10
List<int> b2_6_1a10() {
  final xs = <int>[];
  for (int i = 1; i <= 10; i++) {
    xs.add(i);
  }
  return xs;
}

// 7) Suma de parells 1..50
int b2_7_sumaParells1a50() {
  int s = 0;
  for (int i = 1; i <= 50; i++) {
    if (i % 2 == 0) s += i;
  }
  return s;
}

// 8) Taula de multiplicar
List<String> b2_8_taula(int n) {
  final out = <String>[];
  for (int i = 1; i <= 10; i++) {
    out.add("$n x $i = ${n * i}");
  }
  return out;
}

// 9) Recórrer llista de fruites (retornem còpia per demostrar)
List<String> b2_9_fruites(List<String> fruites) {
  final out = <String>[];
  for (final f in fruites) {
    out.add(f);
  }
  return out;
}

// 10) Buscar element en llista (conté?)
String b2_10_buscarNom(List<String> noms, String consulta) {
  if (noms.contains(consulta)) {
    return "El nom hi és";
  } else {
    // Alternativa: comprovar manualment amb for-in
    for (final n in noms) {
      if (n == consulta) {
        return "El nom hi és";
      }
    }
    return "El nom NO hi és";
  }
}

// 11) Compte enrere n..1
List<int> b2_11_countdown(int n) {
  final xs = <int>[];
  for (int i = n; i >= 1; i--) {
    xs.add(i);
  }
  return xs;
}

// 12) Suma de 5 entrades
int b2_12_sumaCinc(List<int> xs) {
  int s = 0;
  for (final v in xs) {
    s += v;
  }
  return s;
}

// 13) Adivina número secret
bool b2_13_endivina(int secret, int intent) {
  return intent == secret;
}

// 14) Comptador d'intents (retorna intents necessaris donada una seqüència)
int b2_14_intentsFinsEncert(int secret, List<int> intents) {
  int c = 0;
  for (final x in intents) {
    c += 1;
    if (x == secret) return c;
  }
  return c; // si no l'encerta, retorna número de intents passats
}

// 15) Confirmació de sortida (do-while) — lògica puresa: valida resposta
bool b2_15_volContinuar(String r) {
  final s = r.toLowerCase();
  if (s == 's') return true;
  if (s == 'n') return false;
  // qualsevol altra cosa: la tractarem com a continuar per repetir el bucle
  return true;
}

// ======================================================
// Mode DEMO — sense entrades, mostra sortides base
// ======================================================
void runDemo() {
  printHeader("BLOC 1 — Condicionals");
  printItem(1, b1_1_compare100(100));
  printItem(2, b1_2_classificaEdat(16));
  printItem(3, b1_3_diaSetmana(5));
  printItem(4, b1_4_notaFinal(8.5));
  printItem(5, b1_5_operacio(4, 10, 2));

  printHeader("BLOC 2 — Bucles");
  printItem(6, b2_6_1a10());
  printItem(7, b2_7_sumaParells1a50());
  printItem(8, b2_8_taula(7));
  printItem(9, b2_9_fruites(["poma", "pera", "plàtan", "maduixa", "raïm"]));
  printItem(10, b2_10_buscarNom(["Ada", "Eloi", "Joan"], "Eloi"));
  printItem(11, b2_11_countdown(5));
  printItem(12, b2_12_sumaCinc([1, 2, 3, 4, 5]));

  // 13-14: mostra de lògica
  final secret = 7;
  printItem(13, b2_13_endivina(secret, 5)); // false
  printItem(14, b2_14_intentsFinsEncert(secret, [3, 6, 7])); // 3

  // 15: mostra bàsica
  printItem(15, b2_15_volContinuar("n")); // false

  stdout.writeln("\n(Demo feta)");
}

// ======================================================
// Mode INTERACTIU — demana a l'usuari tot el necessari
// ======================================================
void runInteractive() {
  printHeader("BLOC 1 — Condicionals");
  final n1 = _readInt("1) Introdueix un número: ");
  printItem(1, b1_1_compare100(n1));

  final edat = _readInt("2) Introdueix una edat: ", min: 0);
  printItem(2, b1_2_classificaEdat(edat));

  final dia = _readInt("3) Introdueix un número de dia (1-7): ", min: 1, max: 7);
  printItem(3, b1_3_diaSetmana(dia));

  final nota = _readDouble("4) Introdueix una nota (0-10): ", min: 0, max: 10);
  printItem(4, b1_4_notaFinal(nota));

  stdout.writeln("5) Menú d'operacions:");
  stdout.writeln("   1. Sumar\n   2. Restar\n   3. Multiplicar\n   4. Dividir");
  final op = _readInt("   Escull una opció (1-4): ", min: 1, max: 4);
  final a = _readDouble("   Introdueix A: ");
  final b = _readDouble("   Introdueix B: ");
  printItem(5, b1_5_operacio(op, a, b));

  printHeader("BLOC 2 — Bucles");
  printItem(6, b2_6_1a10());
  printItem(7, b2_7_sumaParells1a50());

  final tn = _readInt("8) Taula: Introdueix un número: ");
  printItem(8, b2_8_taula(tn));

  final fruites = ["poma", "pera", "plàtan", "maduixa", "raïm"];
  printItem(9, b2_9_fruites(fruites));

  final consulta = _readNonEmpty("10) Introdueix un nom a buscar (ex: Ada): ");
  printItem(10, b2_10_buscarNom(["Ada", "Eloi", "Joan"], consulta));

  final n = _readInt("11) Compte enrere des de n fins 1. Introdueix n: ", min: 1);
  printItem(11, b2_11_countdown(n));

  stdout.writeln("12) Introdueix 5 números per sumar:");
  final xs5 = <int>[];
  for (int i = 1; i <= 5; i++) {
    xs5.add(_readInt("   número $i: "));
  }
  printItem(12, b2_12_sumaCinc(xs5));

  // 13-14: Adivina el número secret i compte d'intents
  final secret = 7; // pots canviar-lo si vols
  stdout.writeln("13) Endevina el número secret!");
  int intents = 0;
  while (true) {
    final guess = _readInt("   Introdueix un número: ");
    intents += 1;
    if (b2_13_endivina(secret, guess)) {
      stdout.writeln("   Correcte!");
      break;
    } else {
      stdout.writeln("   No és aquest... prova un altre cop.");
    }
  }
  printItem(14, "Intents necessaris: $intents");

  // 15) Confirmació de sortida (do-while)
  String r;
  do {
    r = _readNonEmpty("15) Vols continuar? (s/n): ");
  } while (b2_15_volContinuar(r));
  stdout.writeln("   Sortint... 👋");
}

// ======================================================
// main — tria mode segons arguments
// ======================================================
void main(List<String> args) {
  if (args.contains("--demo")) {
    runDemo();
  } else {
    runInteractive();
  }
}
