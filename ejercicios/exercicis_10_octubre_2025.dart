// ======================================================
// Ejercicios 10-Oct-2025 — Funcions, async/await i errors en Dart
// Estil: funcions pures quan té sentit, comentaris en català,
// sense operadors ternaris (if/else clàssic).
// Mode demo (--demo) i mode interactiu (per defecte).
// ======================================================

import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

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
// BLOC 1 — Funcions bàsiques i amb retorn
// ======================================================

// 1) Hola, mundo (efecte directe per especificació)
void b1_1_holaMundo() {
  stdout.writeln("Hola, mundo");
}

// 2) Salutació personalitzada (imprimeix)
void b1_2_saludaNom(String nom) {
  stdout.writeln("Hola, $nom");
}

// 3) Suma de dos números
num b1_3_suma(num a, num b) {
  return a + b;
}

// 4) Promig de tres notes
double b1_4_promigTres(num a, num b, num c) {
  return (a + b + c) / 3.0;
}

// 5) És parell?
bool b1_5_esParell(int n) {
  if (n % 2 == 0) {
    return true;
  } else {
    return false;
  }
}

// 6) Longitud d'un text
int b1_6_longitud(String s) {
  return s.length;
}

// 7) Factorial
BigInt b1_7_factorial(int n) {
  if (n < 0) {
    throw ArgumentError("El factorial no està definit per a negatius");
  }
  BigInt res = BigInt.one;
  for (int i = 2; i <= n; i++) {
    res *= BigInt.from(i);
  }
  return res;
}

// 8) Major de dos números
num b1_8_major(num a, num b) {
  if (a >= b) {
    return a;
  } else {
    return b;
  }
}

// 9) Total d'una llista de preus
double b1_9_totalPreus(List<double> preus) {
  double total = 0.0;
  for (final p in preus) {
    total += p;
  }
  return total;
}

// 10) Text en majúscules
String b1_10_majuscules(String s) {
  return s.toUpperCase();
}

// ======================================================
// BLOC 2 — Tipus d'arguments
// ======================================================

// 1) Opcional posicional amb valor per defecte
void b2_1_salutacioOpcional([String nom = "invitado"]) {
  stdout.writeln("Hola, $nom");
}

// 2) Paràmetres anomenats
void b2_2_mostraNomEdat({required String nombre, required int edad}) {
  stdout.writeln("Nombre: $nombre, Edad: $edad");
}

// 3) Paràmetre opcional que mostra error si és null
void b2_3_msgOpcional([String? msg]) {
  if (msg == null) {
    stdout.writeln("Error: parámetro no proporcionado");
  } else {
    stdout.writeln("Mensaje: $msg");
  }
}

// 4) Tres paràmetres amb país per defecte
void b2_4_infoPersona({required String nombre, required int edad, String pais = "España"}) {
  stdout.writeln("Nombre: $nombre, Edad: $edad, País: $pais");
}

// 5) La llista conté el número?
bool b2_5_contiene(List<int> xs, int n) {
  return xs.contains(n);
}

// 6) Repetir text n vegades (opc.) — imprimeix
void b2_6_repetir(String text, [int repeticiones = 1]) {
  for (int i = 0; i < repeticiones; i++) {
    stdout.writeln(text);
  }
}

// 7) Mitjana amb opcional b i c (només els no-null)
double b2_7_mediaOpcional(int a, [int? b, int? c]) {
  int suma = a;
  int conta = 1;
  if (b != null) { suma += b; conta += 1; }
  if (c != null) { suma += c; conta += 1; }
  return suma / conta;
}

// 8) Element per índex amb control
Object? b2_8_elemento(List<Object?> xs, int index) {
  if (index < 0 || index >= xs.length) {
    return null; // fora de rang
  } else {
    return xs[index];
  }
}

// 9) Paràmetres anomenats i missatge combinat
String b2_9_resumen({required String nombre, required int edad, required bool activo}) {
  return "Usuario: $nombre, edad: $edad, activo: $activo";
}

// 10) Mixta — posicional + anomenats
void b2_10_mostrar(String nombre, {int edad = 0}) {
  stdout.writeln("Nombre: $nombre, edad: $edad");
}

// ======================================================
// BLOC 3 — Async, await i Future
// ======================================================

// 1) Missatge després de 2s
Future<String> b3_1_msg2s() async {
  return await Future.delayed(const Duration(seconds: 2), () => "Mensaje listo");
}

// 2) Simular descàrrega i després imprimir
Future<void> b3_2_descarga() async {
  await Future.delayed(const Duration(seconds: 2));
  stdout.writeln("Descarga completada");
}

// 3) Quadrat després d'1s
Future<int> b3_3_cuadrado(int n) async {
  await Future.delayed(const Duration(seconds: 1));
  return n * n;
}

// 4) Combinar await i funció síncrona
int _doble(int x) => x * 2;
Future<int> b3_4_combinar(int x) async {
  final a = await b3_3_cuadrado(x); // futur
  final b = _doble(x);              // síncrona
  return a + b; // n^2 + 2n
}

// 5) Processar llista amb pausa
Future<void> b3_5_procesaAmbPausa(List<Object?> xs) async {
  for (final e in xs) {
    await Future.delayed(const Duration(seconds: 1));
    stdout.writeln("Processat: $e");
  }
}

// 6) Esperar tres futures seqüencialment
Future<List<int>> b3_6_tresSeq(int a) async {
  final r1 = await b3_3_cuadrado(a);
  final r2 = await b3_3_cuadrado(a + 1);
  final r3 = await b3_3_cuadrado(a + 2);
  return [r1, r2, r3];
}

// 7) Àrea de cercle després d'una pausa
Future<double> b3_7_areaCercle(double radi) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return math.pi * radi * radi;
}

// 8) Validació login
Future<String> b3_8_login(String usuari, String pass) async {
  await Future.delayed(const Duration(milliseconds: 500));
  if (usuari == "admin" && pass == "1234") {
    return "Acceso permitido";
  } else {
    return "Denegado";
  }
}

// 9) Cridar una async dins d'un bucle for, mostrant progrés
Future<void> b3_9_progres(int n) async {
  for (int i = 1; i <= n; i++) {
    final q = await b3_3_cuadrado(i);
    stdout.writeln("Pas $i/$n → quadrat: $q");
  }
}

// 10) Coordinador principal d'async
Future<void> b3_10_coordinador() async {
  stdout.writeln(await b3_1_msg2s());
  await b3_2_descarga();
  final r = await b3_4_combinar(5);
  stdout.writeln("Resultat combinar(5): $r");
}

// ======================================================
// BLOC 4 — Maneig d'errors amb try/catch
// ======================================================

// 1) Dividir amb captura d'error
void b4_1_dividirImprimir(num a, num b) {
  try {
    final r = a / b;
    stdout.writeln("Resultat: $r");
  } catch (e) {
    stdout.writeln("Error en dividir: $e");
  }
}

// 2) Funció divideix amb retorn nullable
double? b4_2_divideix(num a, num b) {
  try {
    if (b == 0) throw Exception("Divisió per zero");
    return a / b;
  } catch (_) {
    return null;
  }
}

// 3) Convertir text a número amb captura
void b4_3_parsejaIImprimeix(String text) {
  try {
    final v = int.parse(text);
    stdout.writeln("Valor: $v");
  } catch (e) {
    stdout.writeln("Text invàlid: $e");
  }
}

// 4) Llegir número des de teclat amb maneig d'error
int? b4_4_llegirNumero() {
  try {
    final t = _prompt("Introdueix un número: ");
    return int.parse(t);
  } catch (e) {
    stdout.writeln("Entrada no numèrica: $e");
    return null;
  }
}

// 5) Índex fora de rang capturat
void b4_5_indexFora(List<int> xs, int i) {
  try {
    stdout.writeln("Element: ${xs[i]}");
  } catch (e) {
    stdout.writeln("Error d'índex: $e");
  }
}

// 6) Simular llegir arxiu
void b4_6_llegirArxiu() {
  try {
    throw Exception("Arxiu no trobat");
  } catch (e) {
    stdout.writeln("Error al obrir: $e");
  }
}

// 7) Arrel quadrada amb error si negatiu
double? b4_7_arrelPositiva(num n) {
  try {
    if (n < 0) throw Exception("Número negatiu");
    return math.sqrt(n.toDouble());
  } catch (e) {
    stdout.writeln("Error: $e");
    return null;
  }
}

// 8) Future que falla i captura
Future<void> b4_8_futureFalla() async {
  try {
    await Future.delayed(const Duration(milliseconds: 300));
    throw Exception("Error simulat");
  } catch (e) {
    stdout.writeln("Capturat async: $e");
  }
}

// 9) Capturar per tipus diferent
void b4_9_varisErrors(String text, List<int> xs, int idx) {
  try {
    final v = int.parse(text);
    stdout.writeln("Parsed: $v");
    stdout.writeln("Elem idx: ${xs[idx]}");
  } on FormatException catch (e) {
    stdout.writeln("Format invàlid: $e");
  } on RangeError catch (e) {
    stdout.writeln("Índex fora de rang: $e");
  } catch (e) {
    stdout.writeln("Altres errors: $e");
  }
}

// 10) try/catch amb missatges segons causa
void b4_10_programaAmbCriteri(String text, int idx) {
  try {
    final v = int.parse(text);
    final xs = [1,2,3];
    stdout.writeln("Valor * element[$idx] = ${v * xs[idx]}");
  } catch (e) {
    if (e is FormatException) {
      stdout.writeln("No és un número vàlid.");
    } else if (e is RangeError) {
      stdout.writeln("L'índex està fora del rang.");
    } else {
      stdout.writeln("Error desconegut: $e");
    }
  }
}

// ======================================================
// DEMO — sense entrades, mostra sortides base
// ======================================================
Future<void> runDemo() async {
  printHeader("BLOC 1 — Bàsiques");
  b1_1_holaMundo();
  b1_2_saludaNom("Eloi");
  printItem(3, b1_3_suma(3, 4));
  printItem(4, b1_4_promigTres(5, 6, 7));
  printItem(5, b1_5_esParell(8));
  printItem(6, b1_6_longitud("Dart"));
  printItem(7, b1_7_factorial(10));
  printItem(8, b1_8_major(10, 12));
  printItem(9, b1_9_totalPreus([10.5, 2.0, 3.5]));
  printItem(10, b1_10_majuscules("hola"));

  printHeader("BLOC 2 — Arguments");
  b2_1_salutacioOpcional();
  b2_2_mostraNomEdat(nombre: "Anna", edad: 20);
  b2_3_msgOpcional();
  b2_4_infoPersona(nombre: "Pau", edad: 30);
  printItem(5, b2_5_contiene([1,2,3], 2));
  b2_6_repetir("Hola!", 2);
  printItem(7, b2_7_mediaOpcional(10, 20));
  printItem(8, b2_8_elemento(["a","b","c"], 1));
  printItem(9, b2_9_resumen(nombre: "Marta", edad: 22, activo: true));
  b2_10_mostrar("Joan", edad: 40);

  printHeader("BLOC 3 — Async/Await");
  printItem(1, await b3_1_msg2s());
  await b3_2_descarga();
  printItem(3, await b3_3_cuadrado(6));
  printItem(4, await b3_4_combinar(4));
  await b3_5_procesaAmbPausa([1, "dos", 3]);
  printItem(6, await b3_6_tresSeq(2));
  printItem(7, (await b3_7_areaCercle(3)).toStringAsFixed(2));
  printItem(8, await b3_8_login("admin", "1234"));
  await b3_9_progres(3);
  await b3_10_coordinador();

  printHeader("BLOC 4 — Errors");
  b4_1_dividirImprimir(10, 0);
  printItem(2, b4_2_divideix(10, 0));
  b4_3_parsejaIImprimeix("abc");
  b4_4_llegirNumero(); // mostrarà error si no numèric
  b4_5_indexFora([1,2,3], 5);
  b4_6_llegirArxiu();
  printItem(7, b4_7_arrelPositiva(-9));
  await b4_8_futureFalla();
  b4_9_varisErrors("12x", [1,2,3], 1);
  b4_10_programaAmbCriteri("xyz", 10);

  stdout.writeln("\n(Demo feta)");
}

// ======================================================
// INTERACTIU — menú per blocs
// ======================================================
Future<void> runInteractive() async {
  while (true) {
    printHeader("MENÚ — Ejercicios 10-Oct-2025");
    stdout.writeln(
"1) Bloc 1: Funcions bàsiques\n"
"2) Bloc 2: Tipus d'arguments\n"
"3) Bloc 3: Async/Await/Futures\n"
"4) Bloc 4: Errors try/catch\n"
"0) Sortir\n");
    final op = _readInt("Escull una opció: ", min: 0, max: 4);
    if (op == 0) {
      stdout.writeln("Adéu! 👋");
      break;
    }
    if (op == 1) {
      await _menuBloc1();
    } else if (op == 2) {
      await _menuBloc2();
    } else if (op == 3) {
      await _menuBloc3();
    } else if (op == 4) {
      await _menuBloc4();
    }
  }
}

Future<void> _menuBloc1() async {
  printHeader("Bloc 1 — Bàsiques");
  b1_1_holaMundo();
  final nom = _readNonEmpty("Nom per saludar: ");
  b1_2_saludaNom(nom);
  final a = _readDouble("a: ");
  final b = _readDouble("b: ");
  printItem(3, b1_3_suma(a, b));
  final n1 = _readDouble("Nota 1: ");
  final n2 = _readDouble("Nota 2: ");
  final n3 = _readDouble("Nota 3: ");
  printItem(4, b1_4_promigTres(n1, n2, n3).toStringAsFixed(2));
  final ip = _readInt("Enter per saber si és parell: ");
  printItem(5, b1_5_esParell(ip));
  final txt = _readNonEmpty("Text: ");
  printItem(6, b1_6_longitud(txt));
  final nf = _readInt("Factorial de n (>=0): ", min: 0);
  printItem(7, b1_7_factorial(nf));
  final m1 = _readDouble("Major: a: ");
  final m2 = _readDouble("Major: b: ");
  printItem(8, b1_8_major(m1, m2));
  final quant = _readInt("Quants preus? ", min: 1);
  final preus = <double>[];
  for (int i = 1; i <= quant; i++) {
    preus.add(_readDouble(" preu $i: ", min: 0));
  }
  printItem(9, b1_9_totalPreus(preus).toStringAsFixed(2));
  final up = _readNonEmpty("Text a majúscules: ");
  printItem(10, b1_10_majuscules(up));
}

Future<void> _menuBloc2() async {
  printHeader("Bloc 2 — Arguments");
  b2_1_salutacioOpcional();
  b2_2_mostraNomEdat(nombre: _readNonEmpty("Nom: "), edad: _readInt("Edat: ", min: 0));
  b2_3_msgOpcional();
  b2_4_infoPersona(nombre: _readNonEmpty("Nom: "), edad: _readInt("Edat: ", min: 0));
  final l = [1,2,3,4,5];
  printItem(5, b2_5_contiene(l, _readInt("Número a buscar a [1..5]: ", min: 1, max: 5)));
  b2_6_repetir(_readNonEmpty("Text a repetir: "), _readInt("Repeticions: ", min: 1));
  printItem(7, b2_7_mediaOpcional( _readInt("a: "), _readInt("b (enter o buit per saltar): "), null));
  final idx = _readInt("Índex per a ['a','b','c'] (0..2): ", min: 0, max: 2);
  printItem(8, b2_8_elemento(["a","b","c"], idx));
  printItem(9, b2_9_resumen(nombre: "Eli", edad: 21, activo: true));
  b2_10_mostrar("Joan", edad: 33);
}

Future<void> _menuBloc3() async {
  printHeader("Bloc 3 — Async/Await");
  stdout.writeln("1) Missatge 2s…"); printItem(1, await b3_1_msg2s());
  stdout.writeln("2) Descàrrega…"); await b3_2_descarga();
  final x = _readInt("3) Quadrat: n: ");
  printItem(3, await b3_3_cuadrado(x));
  printItem(4, await b3_4_combinar(_readInt("4) Combinar amb n: ")));
  await b3_5_procesaAmbPausa(["A", "B", "C"]);
  printItem(6, await b3_6_tresSeq( _readInt("Base per seqüència: ") ));
  printItem(7, (await b3_7_areaCercle(_readDouble("Radi: ", min: 0))).toStringAsFixed(2));
  final u = _readNonEmpty("Usuari: "); final p = _readNonEmpty("Contrasenya: ");
  printItem(8, await b3_8_login(u, p));
  await b3_9_progres(_readInt("Passos per progrés: ", min: 1));
  await b3_10_coordinador();
}

Future<void> _menuBloc4() async {
  printHeader("Bloc 4 — Errors");
  b4_1_dividirImprimir(10, 0);
  printItem(2, b4_2_divideix(5, 0));
  b4_3_parsejaIImprimeix(_readNonEmpty("Text per parsejar a int: "));
  b4_4_llegirNumero();
  b4_5_indexFora([1,2,3], _readInt("Índex per [1,2,3]: "));
  b4_6_llegirArxiu();
  printItem(7, b4_7_arrelPositiva(_readDouble("Número per arrel: ")));
  await b4_8_futureFalla();
  b4_9_varisErrors(_readNonEmpty("Text per parsejar: "), [1,2,3], _readInt("Índex: "));
  b4_10_programaAmbCriteri(_readNonEmpty("Número (text): "), _readInt("Índex per [1,2,3]: "));
}

// ======================================================
// main — async per poder await a demo/interactiu
// ======================================================
Future<void> main(List<String> args) async {
  if (args.contains("--demo")) {
    await runDemo();
  } else {
    await runInteractive();
  }
}
