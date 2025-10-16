// ======================================================
// Ejercicios 9-Oct-2025 — Funciones en Dart
// i main amb mode interactiu (stdin) i mode demo (--demo).
// ======================================================

import 'dart:io';

// -----------------------------
// Helpers d'impressió i entrada
// -----------------------------
void printHeader(String title) => stdout.writeln("\n================= $title =================");

void printItem(int n, Object? value) => stdout.writeln("$n) $value");
  
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
// BLOC 1 — Funcions bàsiques
// ======================================================

// 1) saludar(): imprimeix (la deixem com a efecte per enunciat)
void f1_saludar() => stdout.writeln("Hola, bienvenido a Dart");
  
// 2) suma de dos enters
int f2_sumar(int a, int b) => a + b;
  
// 3) par o impar -> String
String f3_parOImpar(int n) => (n % 2 == 0) ? "par" : "impar";

// 4) àrea rectangle (double)
double f4_areaRect(double base, double altura) => base * altura;

// 5) mitjana d'una llista de notes
double f5_media(List<double> notes) {
  if (notes.isEmpty) {
    return double.nan;
  }
  double suma = 0.0;
  for (final n in notes) {
    suma += n;
  }
  return suma / notes.length;
}

// 6) quants noms comencen per 'A' (sense distingir maj/min)
int f6_comencenA(List<String> noms) {
  int c = 0;
  for (final nom in noms) {
    if (nom.isNotEmpty && nom[0].toUpperCase() == 'A') {
      c += 1;
    }
  }
  return c;
}

// 7) factorial (BigInt per seguretat)
BigInt f7_factorial(int n) {
  if (n < 0) {
    throw ArgumentError("El factorial no està definit per a negatius");
  }
  BigInt res = BigInt.one;
  for (int i = 2; i <= n; i++) {
    res *= BigInt.from(i);
  }
  return res;
}

// 8) nombre de vocals en una paraula (aeiou)
int f8_compteVocals(String paraula) {
  final vocals = {"a", "e", "i", "o", "u"};
  int c = 0;
  for (final ch in paraula.toLowerCase().split('')) {
    if (vocals.contains(ch)) {
      c += 1;
    }
  }
  return c;
}

// 9) Celsius <-> Fahrenheit
double f9_c_to_f(double c) {
  return (c * 9 / 5) + 32;
}
double f9_f_to_c(double f) {
  return (f - 32) * 5 / 9;
}

// 10) primer divisible pel segon?
String f10_esDivisible(int a, int b)  => (b == 0) ? "no es pot dividir per zero" : 
  (a % b == 0) ? "sí, és divisible" : "no és divisible";

// ======================================================
// BLOC 4 — Retos combinats
// ======================================================

// 1) total amb IVA 21%
double r1_totalAmbIVA(List<double> preus) {
  double total = 0.0;
  for (final p in preus) {
    total += p * 1.21;
  }
  return total;
}

// 2) vegades que apareix una lletra concreta
int r2_comptarLletra(String text, String lletra) {
  if (lletra.isEmpty) return 0;
  final L = lletra[0].toLowerCase();
  int c = 0;
  for (final ch in text.toLowerCase().split('')) {
    if (ch == L) c += 1;
  }
  return c;
  return c;
  return c;
  return c;
  return c;
}

// 3) major de tres números
int r3_majorDeTres(int a, int b, int c) {
  int m = a;
  if (b > m) m = b;
  if (c > m) m = c;
  return m;
}

// 4) IMC i rang (bajo peso, normal, sobrepeso)
String r4_imc(double pesKg, double alcadaM) {
  if (alcadaM <= 0) return "alçada invàlida";
  final imc = pesKg / (alcadaM * alcadaM);
  if (imc < 18.5) {
    return "IMC: ${imc.toStringAsFixed(2)} → bajo peso";
  } else if (imc < 25.0) {
    return "IMC: ${imc.toStringAsFixed(2)} → normal";
  } else {
    return "IMC: ${imc.toStringAsFixed(2)} → sobrepeso";
  }
}

// 5) filtrar només parells
List<int> r5_solsParells(List<int> xs) {
  final out = <int>[];
  for (final n in xs) {
    if (n % 2 == 0) out.add(n);
  }
  return out;
}

// 6) string més llarga
String r6_mesLlarga(List<String> xs) {
  if (xs.isEmpty) return "";
  String m = xs[0];
  for (int i = 1; i < xs.length; i++) {
    if (xs[i].length > m.length) {
      m = xs[i];
    }
  }
  return m;
}

// 7) salutació personalitzada
String r7_salutacio(String nom) {
  return "Hola, $nom! Benvingut/da a Dart.";
}

// 8) suma d'1..n
int r8_sumaFinsN(int n) {
  int s = 0;
  for (int i = 1; i <= n; i++) {
    s += i;
  }
  return s;
}

// 9) palíndrom?
bool r9_esPalindrom(String text) {
  final norm = text.toLowerCase().replaceAll(' ', '');
  final reversed = norm.split('').reversed.join();
  return norm == reversed;
}

// ======================================================
// DEMO — proves ràpides sense entrada
// ======================================================
void runDemo() {
  printHeader("BLOC 1 — Bàsiques");
  f1_saludar();
  printItem(2, f2_sumar(3, 5));
  printItem(3, f3_parOImpar(7));
  printItem(4, f4_areaRect(3.0, 4.0));
  printItem(5, f5_media([5, 6.5, 8]));
  printItem(6, f6_comencenA(["Anna", "albert", "Joan", "Eva"]));
  printItem(7, f7_factorial(10));
  printItem(8, f8_compteVocals("Programació"));
  printItem(9, "${f9_c_to_f(0)}ºF / ${f9_f_to_c(32)}ºC");
  printItem(10, f10_esDivisible(10, 5));

  printHeader("BLOC 4 — Retos");
  printItem(1, r1_totalAmbIVA([10.0, 20.0, 5.0]).toStringAsFixed(2));
  printItem(2, r2_comptarLletra("Elefante elegante", "e"));
  printItem(3, r3_majorDeTres(4, 9, 2));
  printItem(4, r4_imc(70, 1.75));
  printItem(5, r5_solsParells([1,2,3,4,5,6]));
  printItem(6, r6_mesLlarga(["Dart", "Flutter", "Programació"]));
  printItem(7, r7_salutacio("Eloi"));
  printItem(8, r8_sumaFinsN(10));
  printItem(9, r9_esPalindrom("Anita lava la tina"));
}

// ======================================================
// INTERACTIU — menú que crida funcions segons opció
// ======================================================
void runInteractive() {
  while (true) {
    printHeader("MENÚ — Ejercicios 9-Oct-2025 (Funcions)");
    stdout.writeln(
"1) saludar()\n"
"2) suma de 2 números\n"
"3) par o impar\n"
"4) àrea rectangle\n"
"5) mitjana de notes\n"
"6) noms que comencen per 'A'\n"
"7) factorial\n"
"8) comptar vocals\n"
"9) conversors °C↔°F\n"
"10) divisible?\n"
"11) total amb IVA (21%)\n"
"12) comptar lletra en text\n"
"13) major de tres\n"
"14) IMC i rang\n"
"15) filtrar parells d'una llista\n"
"16) string més llarga\n"
"17) salutació personalitzada\n"
"18) suma 1..n\n"
"19) és palíndrom?\n"
"0) sortir\n");

    final op = _readInt("Escull una opció: ", min: 0, max: 19);
    if (op == 0) {
      stdout.writeln("Adéu! Espero que t'hagi agradat");
      break;
    }

    switch (op) {
      case 1:
        f1_saludar();
        break;
      case 2: {
        final a = _readInt(" a: ");
        final b = _readInt(" b: ");
        printItem(2, f2_sumar(a, b));
        break;
      }
      case 3: {
        final n = _readInt(" número: ");
        printItem(3, f3_parOImpar(n));
        break;
      }
      case 4: {
        final base = _readDouble(" base: ", min: 0);
        final alt = _readDouble(" altura: ", min: 0);
        printItem(4, f4_areaRect(base, alt));
        break;
      }
      case 5: {
        final k = _readInt(" Quantes notes? ", min: 1);
        final xs = <double>[];
        for (int i = 1; i <= k; i++) {
          xs.add(_readDouble("  nota $i: ", min: 0, max: 10));
        }
        printItem(5, f5_media(xs).toStringAsFixed(2));
        break;
      }
      case 6: {
        final csv = _readNonEmpty(" Introdueix noms separats per comes: ");
        final noms = csv.split(',').map((e)=>e.trim()).where((e)=>e.isNotEmpty).toList();
        printItem(6, f6_comencenA(noms));
        break;
      }
      case 7: {
        final n = _readInt(" n (>=0): ", min: 0);
        printItem(7, f7_factorial(n));
        break;
      }
      case 8: {
        final p = _readNonEmpty(" Paraula o text: ");
        printItem(8, f8_compteVocals(p));
        break;
      }
      case 9: {
        stdout.writeln(" 1) °C → °F   2) °F → °C");
        final x = _readInt(" Escull: ", min: 1, max: 2);
        if (x == 1) {
          final c = _readDouble("   °C: ");
          printItem(9, "${f9_c_to_f(c).toStringAsFixed(2)} °F");
        } else {
          final f = _readDouble("   °F: ");
          printItem(9, "${f9_f_to_c(f).toStringAsFixed(2)} °C");
        }
        break;
      }
      case 10: {
        final a = _readInt(" a: ");
        final b = _readInt(" b: ");
        printItem(10, f10_esDivisible(a, b));
        break;
      }
      case 11: {
        final n = _readInt(" Quants preus vols? ", min: 1);
        final preus = <double>[];
        for (int i = 1; i <= n; i++) {
          preus.add(_readDouble("  preu $i: ", min: 0));
        }
        printItem(11, r1_totalAmbIVA(preus).toStringAsFixed(2));
        break;
      }
      case 12: {
        final txt = _readNonEmpty(" Text: ");
        final l = _readNonEmpty(" Lletra a comptar: ");
        printItem(12, r2_comptarLletra(txt, l));
        break;
      }
      case 13: {
        final a = _readInt(" a: "); final b = _readInt(" b: "); final c = _readInt(" c: ");
        printItem(13, r3_majorDeTres(a, b, c));
        break;
      }
      case 14: {
        final pes = _readDouble(" pes (kg): ", min: 1);
        final h = _readDouble(" alçada (m): ", min: 0.3);
        printItem(14, r4_imc(pes, h));
        break;
      }
      case 15: {
        final n = _readInt(" Quants números? ", min: 1);
        final xs = <int>[];
        for (int i = 1; i <= n; i++) {
          xs.add(_readInt("  número $i: "));
        }
        printItem(15, r5_solsParells(xs));
        break;
      }
      case 16: {
        final csv = _readNonEmpty(" Strings separats per comes: ");
        final xs = csv.split(',').map((e)=>e.trim()).where((e)=>e.isNotEmpty).toList();
        printItem(16, r6_mesLlarga(xs));
        break;
      }
      case 17: {
        final nom = _readNonEmpty(" Nom: ");
        printItem(17, r7_salutacio(nom));
        break;
      }
      case 18: {
        final n = _readInt(" n: ", min: 0);
        printItem(18, r8_sumaFinsN(n));
        break;
      }
      case 19: {
        final t = _readNonEmpty(" Text: ");
        printItem(19, r9_esPalindrom(t));
        break;
      }
      default:
        stdout.writeln("Opció invàlida.");
    }
  }
}

// ======================================================
// main — --demo per demo; per defecte, interactiu
// ======================================================
void main(List<String> args) {
  if (args.contains("--demo")) {
    runDemo();
  } else {
    runInteractive();
  }
}
