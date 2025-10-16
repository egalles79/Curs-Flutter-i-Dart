// ======================================================
// Ejercicios 7-Oct-2025 — Mode interactiu
// Condicionals, for i for-in en Dart
// - Pots executar en dos modes:
//     * Interactiu (per defecte)
//     * Demo amb mostres: afegeix --demo als arguments si no es fa la part interactiva
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
// Helpers d'entrada (prompts)
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
// B L O C   1 — Condicionals if/else (funcions pures)
// ======================================================

String b1_1_sign(int n) {
  if (n >= 0) {
    return "positiu";
  } else {
    return "negatiu";
  }
}

String b1_2_parImpar(int n) {
  if (n % 2 == 0) {
    return "parell";
  } else {
    return "senar";
  }
}

String b1_3_majorEdat(int edat) {
  if (edat >= 18) {
    return "major d'edat";
  } else {
    return "menor d'edat";
  }
}

String b1_4_inRange10_50(int n) {
  if (n >= 10 && n <= 50) {
    return "està entre 10 i 50";
  } else {
    return "fora de rang";
  }
}

String b1_5_checkPassword(String pass) {
  if (pass == "1234") {
    return "clau correcta";
  } else {
    return "clau incorrecta";
  }
}

String b1_6_compare(int a, int b) {
  if (a > b) {
    return "$a és més gran que $b";
  } else if (b > a) {
    return "$b és més gran que $a";
  } else {
    return "són iguals";
  }
}

String b1_7_notaAprova(num nota) {
  if (nota >= 5) {
    return "aprova";
  } else {
    return "suspèn";
  }
}

String b1_8_vocalOConsonant(String lletra) {
  final l = lletra.isEmpty ? "" : lletra[0].toLowerCase();
  final vocals = {"a", "e", "i", "o", "u"};
  if (l.isEmpty) {
    return "entrada buida";
  }
  if (vocals.contains(l)) {
    return "vocal";
  } else {
    return "consonant";
  }
}

String b1_9_multiple3i5(int n) {
  if (n % 3 == 0 && n % 5 == 0) {
    return "és múltiple de 3 i de 5";
  } else {
    return "no és múltiple de 3 i 5 alhora";
  }
}

String b1_10_compare100(int n) {
  if (n == 100) {
    return "és igual a 100";
  } else if (n < 100) {
    return "és menor que 100";
  } else {
    return "és més gran que 100";
  }
}

// ======================================================
// B L O C   2 — Bucles for (funcions pures)
// ======================================================

List<int> b2_1_nums1a10() {
  final xs = <int>[];
  for (int i = 1; i <= 10; i++) {
    xs.add(i);
  }
  return xs;
}

List<int> b2_2_parells1a20() {
  final xs = <int>[];
  for (int i = 1; i <= 20; i++) {
    if (i % 2 == 0) xs.add(i);
  }
  return xs;
}

List<String> b2_3_taulaMultiplicar(int n) {
  final out = <String>[];
  for (int i = 1; i <= 10; i++) {
    out.add("$n x $i = ${n * i}");
  }
  return out;
}

int b2_4_suma1a100() {
  int suma = 0;
  for (int i = 1; i <= 100; i++) {
    suma += i;
  }
  return suma;
}

List<int> b2_5_multiplesDe3Fins30() {
  final xs = <int>[];
  for (int i = 3; i <= 30; i += 3) {
    xs.add(i);
  }
  return xs;
}

int b2_6_compteDiv7_1a50() {
  int c = 0;
  for (int i = 1; i <= 50; i++) {
    if (i % 7 == 0) c += 1;
  }
  return c;
}

BigInt b2_7_factorial(int n) {
  if (n < 0) throw ArgumentError("El factorial no està definit per a negatius");
  BigInt res = BigInt.one;
  for (int i = 2; i <= n; i++) {
    res *= BigInt.from(i);
  }
  return res;
}

List<int> b2_8_descendent10a1() {
  final xs = <int>[];
  for (int i = 10; i >= 1; i--) {
    xs.add(i);
  }
  return xs;
}

List<int> b2_9_countdown(int n) {
  final xs = <int>[];
  if (n < 0) return xs;
  for (int i = n; i >= 0; i--) {
    xs.add(i);
  }
  return xs;
}

int b2_10_sumaParells1a50() {
  int suma = 0;
  for (int i = 1; i <= 50; i++) {
    if (i % 2 == 0) suma += i;
  }
  return suma;
}

// ======================================================
// B L O C   3 — for-in amb llistes (funcions pures)
// ======================================================

List<String> b3_1_nomsTalQual(List<String> noms) {
  final out = <String>[];
  for (var nom in noms) out.add(nom);
  return out;
}

List<int> b3_2_mesGransQue10(List<int> xs) {
  final out = <int>[];
  for (var v in xs) {
    if (v > 10) out.add(v);
  }
  return out;
}

int b3_3_sumaLlista(List<int> xs) {
  int suma = 0;
  for (var v in xs) suma += v;
  return suma;
}

String b3_4_conteSet(List<int> xs) {
  for (var v in xs) {
    if (v == 7) return "la llista conté el 7";
  }
  return "la llista NO conté el 7";
}

List<String> b3_5_nomsComencenA(List<String> noms) {
  final out = <String>[];
  for (var nom in noms) {
    if (nom.isNotEmpty && nom[0].toUpperCase() == "A") out.add(nom);
  }
  return out;
}

List<double> b3_6_notesAprovades(List<double> notes) {
  final out = <double>[];
  for (var n in notes) {
    if (n >= 5.0) out.add(n);
  }
  return out;
}

int b3_7_compteNomsLlargs(List<String> noms) {
  int c = 0;
  for (var nom in noms) {
    if (nom.length > 4) c += 1;
  }
  return c;
}

double b3_8_totalPreus(List<double> preus) {
  double total = 0.0;
  for (var p in preus) total += p;
  return total;
}

List<String> b3_9_toUpper(List<String> xs) {
  final out = <String>[];
  for (var s in xs) out.add(s.toUpperCase());
  return out;
}

int b3_10_compteMajors(List<int> edats) {
  int c = 0;
  for (var e in edats) {
    if (e >= 18) c += 1;
  }
  return c;
}

// ======================================================
// B L O C   4 — Retos combinats (funcions pures)
// ======================================================

int b4_1_sumaCinc(List<int> xs) {
  int s = 0;
  for (var v in xs) s += v;
  return s;
}

List<String> b4_2_taulaPares(int n) {
  final out = <String>[];
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) out.add("$n x $i = ${n * i}");
  }
  return out;
}

int b4_3_compteNomsAmbE(List<String> noms) {
  int c = 0;
  for (var nom in noms) {
    if (nom.toLowerCase().contains('e')) c += 1;
  }
  return c;
}

List<String> b4_4_lletresPerLinia(String paraula) {
  final out = <String>[];
  for (var ch in paraula.split('')) out.add(ch);
  return out;
}

int b4_5_sumaImparellsFinsN(int n) {
  int suma = 0;
  for (int i = 1; i <= n; i++) {
    if (i % 2 != 0) suma += i;
  }
  return suma;
}

String b4_6_promigIAvaluacio(List<double> notes) {
  if (notes.isEmpty) return "no hi ha notes";
  double s = 0.0;
  for (var n in notes) s += n;
  final promig = s / notes.length;
  if (promig >= 5.0) {
    return "promig: ${promig.toStringAsFixed(2)} → aprova";
  } else {
    return "promig: ${promig.toStringAsFixed(2)} → suspèn";
  }
}

String b4_7_compteParellsISenars(List<int> xs) {
  int p = 0, s = 0;
  for (var v in xs) {
    if (v % 2 == 0) {
      p += 1;
    } else {
      s += 1;
    }
  }
  return "parells: $p, senars: $s";
}

int b4_8_compteVocals(String frase) {
  final vocals = {"a", "e", "i", "o", "u"};
  int c = 0;
  for (var ch in frase.toLowerCase().split('')) {
    if (vocals.contains(ch)) c += 1;
  }
  return c;
}

double b4_9_totalAmbIVA(List<double> preus) {
  double total = 0.0;
  for (var p in preus) total += p * 1.21;
  return total;
}

int b4_10_majorDeTres(int a, int b, int c) {
  int m = a;
  if (b > m) m = b;
  if (c > m) m = c;
  return m;
}

// ======================================================
// Mode DEMO (sense entrada) — com la versió anterior
// ======================================================
void runDemo() {
  printHeader("BLOC 1 — Condicionals");
  printItem(1, b1_1_sign(0));
  printItem(2, b1_2_parImpar(7));
  printItem(3, b1_3_majorEdat(17));
  printItem(4, b1_4_inRange10_50(25));
  printItem(5, b1_5_checkPassword("1234"));
  printItem(6, b1_6_compare(10, 20));
  printItem(7, b1_7_notaAprova(4.9));
  printItem(8, b1_8_vocalOConsonant("E"));
  printItem(9, b1_9_multiple3i5(30));
  printItem(10, b1_10_compare100(150));

  printHeader("BLOC 2 — for");
  printItem(1, b2_1_nums1a10());
  printItem(2, b2_2_parells1a20());
  printItem(3, b2_3_taulaMultiplicar(6));
  printItem(4, b2_4_suma1a100());
  printItem(5, b2_5_multiplesDe3Fins30());
  printItem(6, b2_6_compteDiv7_1a50());
  printItem(7, b2_7_factorial(10));
  printItem(8, b2_8_descendent10a1());
  printItem(9, b2_9_countdown(5));
  printItem(10, b2_10_sumaParells1a50());

  printHeader("BLOC 3 — for-in amb llistes");
  printItem(1, b3_1_nomsTalQual(["Ada", "Eloi", "Joan"]));
  printItem(2, b3_2_mesGransQue10([1, 11, 3, 20, 12]));
  printItem(3, b3_3_sumaLlista([1, 2, 3, 4, 5]));
  printItem(4, b3_4_conteSet([6, 7, 8]));
  printItem(5, b3_5_nomsComencenA(["Anna", "albert", "Joana", "Eva"]));
  printItem(6, b3_6_notesAprovades([4.5, 5.0, 9.2, 3.1]));
  printItem(7, b3_7_compteNomsLlargs(["Ada", "Eloi", "Montserrat", "Laia"]));
  printItem(8, b3_8_totalPreus([10.0, 2.5, 3.5]));
  printItem(9, b3_9_toUpper(["hola", "adeu"]));
  printItem(10, b3_10_compteMajors([17, 18, 40, 10]));

  printHeader("BLOC 4 — Retos combinats");
  printItem(1, b4_1_sumaCinc([1, 2, 3, 4, 5]));
  printItem(2, b4_2_taulaPares(7));
  printItem(3, b4_3_compteNomsAmbE(["Pere", "Marta", "Ester", "Lola"]));
  printItem(4, b4_4_lletresPerLinia("Dart"));
  printItem(5, b4_5_sumaImparellsFinsN(9));
  printItem(6, b4_6_promigIAvaluacio([4.0, 6.0, 5.0, 7.0, 8.0]));
  printItem(7, b4_7_compteParellsISenars([1,2,3,4,5,6,7,8,9,10]));
  printItem(8, b4_8_compteVocals("Avui programem en Dart"));
  printItem(9, b4_9_totalAmbIVA([10.0, 20.0, 5.0]));
  printItem(10, b4_10_majorDeTres(42, 7, 19));
}

// ======================================================
// Mode INTERACTIU — demana entrades a l'usuari
// ======================================================
void runInteractive() {
  printHeader("BLOC 1 — Condicionals");
  final n1 = _readInt("1) Introdueix un número: ");
  printItem(1, b1_1_sign(n1));

  final n2 = _readInt("2) Introdueix un número: ");
  printItem(2, b1_2_parImpar(n2));

  final edat = _readInt("3) Introdueix una edat: ", min: 0);
  printItem(3, b1_3_majorEdat(edat));

  final n4 = _readInt("4) Introdueix un número: ");
  printItem(4, b1_4_inRange10_50(n4));

  final pass = _readNonEmpty('5) Introdueix la contrasenya: ');
  printItem(5, b1_5_checkPassword(pass));

  final a = _readInt("6) Introdueix A: ");
  final b = _readInt("6) Introdueix B: ");
  printItem(6, b1_6_compare(a, b));

  final nota = _readDouble("7) Introdueix una nota (0-10): ", min: 0, max: 10);
  printItem(7, b1_7_notaAprova(nota));

  final lletra = _readNonEmpty("8) Introdueix una lletra: ");
  printItem(8, b1_8_vocalOConsonant(lletra));

  final n9 = _readInt("9) Introdueix un número: ");
  printItem(9, b1_9_multiple3i5(n9));

  final n10 = _readInt("10) Introdueix un número: ");
  printItem(10, b1_10_compare100(n10));

  printHeader("BLOC 2 — for");
  printItem(1, b2_1_nums1a10());
  printItem(2, b2_2_parells1a20());

  final tnum = _readInt("3) Taula: Introdueix un número: ");
  printItem(3, b2_3_taulaMultiplicar(tnum));

  printItem(4, b2_4_suma1a100());
  printItem(5, b2_5_multiplesDe3Fins30());
  printItem(6, b2_6_compteDiv7_1a50());

  final f = _readInt("7) Factorial: Introdueix n (>=0): ", min: 0);
  printItem(7, b2_7_factorial(f));

  printItem(8, b2_8_descendent10a1());

  final cd = _readInt("9) Compte enrere: Introdueix n (>=0): ", min: 0);
  printItem(9, b2_9_countdown(cd));

  printItem(10, b2_10_sumaParells1a50());

  printHeader("BLOC 3 — for-in amb llistes (mostra amb exemples ràpids)");
  final noms = ["Ada", "Eloi", "Joan"];
  printItem(1, b3_1_nomsTalQual(noms));
  printItem(2, b3_2_mesGransQue10([1, 11, 3, 20, 12]));
  printItem(3, b3_3_sumaLlista([1, 2, 3, 4, 5]));
  printItem(4, b3_4_conteSet([6, 7, 8]));
  printItem(5, b3_5_nomsComencenA(["Anna", "albert", "Joana", "Eva"]));
  printItem(6, b3_6_notesAprovades([4.5, 5.0, 9.2, 3.1]));
  printItem(7, b3_7_compteNomsLlargs(["Ada", "Eloi", "Montserrat", "Laia"]));
  printItem(8, b3_8_totalPreus([10.0, 2.5, 3.5]));
  printItem(9, b3_9_toUpper(["hola", "adeu"]));
  printItem(10, b3_10_compteMajors([17, 18, 40, 10]));

  printHeader("BLOC 4 — Retos combinats");
  stdout.writeln("1) Introdueix 5 números:");
  final xs5 = <int>[];
  for (int i = 1; i <= 5; i++) {
    xs5.add(_readInt("   número $i: "));
  }
  printItem(1, b4_1_sumaCinc(xs5));

  final mult = _readInt("2) Taula només parells: Introdueix n: ");
  printItem(2, b4_2_taulaPares(mult));

  final nomsCSV = _readNonEmpty("3) Introdueix noms separats per comes: ");
  final nomsList = nomsCSV.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  printItem(3, b4_3_compteNomsAmbE(nomsList));

  final paraula = _readNonEmpty("4) Introdueix una paraula: ");
  printItem(4, b4_4_lletresPerLinia(paraula));

  final nImpar = _readInt("5) Introdueix n (suma d'imparells fins a n): ", min: 0);
  printItem(5, b4_5_sumaImparellsFinsN(nImpar));

  stdout.writeln("6) Introdueix 5 notes (0-10):");
  final notes5 = <double>[];
  for (int i = 1; i <= 5; i++) {
    notes5.add(_readDouble("   nota $i: ", min: 0, max: 10));
  }
  printItem(6, b4_6_promigIAvaluacio(notes5));

  stdout.writeln("7) Introdueix 10 números (parells vs senars):");
  final xs10 = <int>[];
  for (int i = 1; i <= 10; i++) {
    xs10.add(_readInt("   número $i: "));
  }
  printItem(7, b4_7_compteParellsISenars(xs10));

  final frase = _readNonEmpty("8) Introdueix una frase: ");
  printItem(8, b4_8_compteVocals(frase));

  final quant = _readInt("9) Quants preus vols introduir? ", min: 1);
  final preus = <double>[];
  for (int i = 1; i <= quant; i++) {
    preus.add(_readDouble("   preu $i: ", min: 0));
  }
  printItem(9, b4_9_totalAmbIVA(preus).toStringAsFixed(2));

  stdout.writeln("10) Introdueix 3 números:");
  final A = _readInt("   a: ");
  final B = _readInt("   b: ");
  final C = _readInt("   c: ");
  printItem(10, b4_10_majorDeTres(A, B, C));

  stdout.writeln("\n(Fet! Mode interactiu completat. Gràcies!)");
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
