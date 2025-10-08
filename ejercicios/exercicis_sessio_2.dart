// ======================================================
// Ejercicios 2-Oct-2025 — Clean Code con entrada por consola
// ======================================================

import 'dart:math';
import 'dart:io';

// -----------------------------
// Helpers de entrada
// -----------------------------
int readInt(String prompt) {
  while (true) {
    stdout.write("$prompt: ");
    final line = stdin.readLineSync();
    final value = int.tryParse((line ?? "").trim());
    if (value != null) return value;
    stdout.writeln("46Valor no válido. Introduce un entero.");
  }
}

double readDouble(String prompt) {
  while (true) {
    stdout.write("$prompt: ");
    final line = stdin.readLineSync();
    final value = double.tryParse((line ?? "").trim());
    if (value != null) return value;
    stdout.writeln("Valor no válido. Introduce un número decimal.");
  }
}

String readString(String prompt) {
  stdout.write("$prompt: ");
  return (stdin.readLineSync() ?? "").trim();
}

// -----------------------------
// Utils
// -----------------------------
bool isEven(int n) => n % 2 == 0;
bool isLeapYear(int year) =>
    (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

String minutesAndSecondsFrom(int totalSeconds) {
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  return "$minutes min $seconds s";
}

String multiplicationTable(int n) {
  final lines = <String>[];
  for (var i = 1; i <= 10; i++) {
    lines.add("$n x $i = ${n * i}");
  }
  return lines.join(" | ");
}

double truncateToPlaces(double value, int places) {
  final mod = pow(10, places);
  return (value * mod ~/ 1) / mod; // truncar sense arrodonir
}

String reversedString(String s) => s.split('').reversed.join();
int countChar(String s, String ch) =>
    s.split('').where((c) => c == ch).length;

bool startsWithVowel(String s) {
  if (s.isEmpty) return false;
  final first = s[0].toLowerCase();
  return "aeiouáéíóúàèìòù".contains(first);
}

double celsiusToFahrenheit(double c) => (c * 9 / 5) + 32;
double circleArea(double r) => pi * r * r;
double withIva(double price, double percent) => price + price * percent / 100;
double kmToMiles(double km) => km * 0.621371;
double bmi(double weightKg, double heightM) => weightKg / (heightM * heightM);
bool inNormalBmiRange(double bmiValue) => bmiValue >= 18.5 && bmiValue <= 24.9;

// -----------------------------
// Ejercicios (funciones puras)
// -----------------------------
// Enteros
String s1e1_age(int age) => "$age";
String s1e2_doubleOf(int n) => "${n * 2}";
String s1e3_squareOf(int n) => "${n * n}";
String s1e4_basicOpsInt(int a, int b) =>
    "suma:${a + b} resta:${a - b} mult:${a * b} divEntera:${a ~/ b}";
String s1e5_remainder25div4() => "${25 % 4}";
String s1e6_daysToHours(int days) => "${days * 24}";
String s1e7_dozenCount(int items) => "${items ~/ 12}";
String s1e8_secondsToMinSec(int totalSeconds) =>
    minutesAndSecondsFrom(totalSeconds);
String s1e9_evenOdd(int n) => isEven(n) ? "par" : "impar";
String s1e10_table(int n) => multiplicationTable(n);

// Decimales
String s2e1_weight(double weight) => "$weight";
String s2e2_circleArea(double r) => "${circleArea(r)}";
String s2e3_priceWithIva(double price, double percent) =>
    "${withIva(price, percent)}";
String s2e4_cToF(double c) => "${celsiusToFahrenheit(c)}";
String s2e5_avg3(double a, double b, double c) => "${(a + b + c) / 3}";
String s2e6_truncate2(double x) => "${truncateToPlaces(x, 2)}";
String s2e7_roundToUnit(double x) => "${x.round()}";
String s2e8_kmToMi(double km) => "${kmToMiles(km)}";
String s2e9_bmi(double weight, double height) => "${bmi(weight, height)}";
String s2e10_splitBill(double total, int people) => "${total / people}";

// Cadenas
String s3e1_greet(String name) => "Hola $name";
String s3e2_lengthOf(String text) => "${text.length}";
String s3e3_upperLower(String name) =>
    "${name.toUpperCase()} | ${name.toLowerCase()}";
String s3e4_fullName(String name, String surname) => "$name $surname";
String s3e5_firstLetter(String name) =>
    name.isEmpty ? "" : name.substring(0, 1);
String s3e6_containsDart(String text) => text.contains("Dart").toString();
String s3e7_replaceBad(String text) => text.replaceAll("malo", "bueno");
String s3e8_reverse(String text) => reversedString(text);
String s3e9_countLetterA(String text) =>
    "${countChar(text.toLowerCase(), 'a')}";
String s3e10_welcome(String name) => "Hola, $name! Bienvenido a Dart";

// Booleanos
String s4e1_havePet(bool havePet) => "$havePet";
String s4e2_greaterThan100(int n) => "${n > 100}";
String s4e3_positiveOrNegative(int n) => n >= 0 ? "positivo" : "negativo";
String s4e4_boolOps(bool a, bool b) =>
    "&&:${a && b} ||:${a || b} !a:${!a} !b:${!b}";
String s4e5_adult(int age) => "${age >= 18}";
String s4e6_divisibleBy5and2(int n) => "${n % 5 == 0 && n % 2 == 0}";
String s4e7_passwordOk(String pwd) => "${pwd == "1234"}";
String s4e8_isLeap(int year) => "${isLeapYear(year)}";
String s4e9_passedMessage(bool passed) =>
    passed ? "Has aprobado" : "Has suspendido";
String s4e10_startsWithVowel(String word) => "${startsWithVowel(word)}";

// Combinados
String s5e1_nextYear(String name, int age) =>
    "Hola $name, el año que viene tendrás ${age + 1} años.";
String s5e2_avgPass(double a, double b, double c) {
  final avg = (a + b + c) / 3;
  final pass = avg >= 5 ? "aprueba" : "suspende";
  return "promedio:${avg.toStringAsFixed(2)} → $pass";
}
String s5e3_evenAndGreater10(int n) => "${n % 2 == 0 && n > 10}";
String s5e4_bmiReport(String name, double weight, double height) {
  final value = bmi(weight, height);
  return "Nombre: $name | IMC: ${value.toStringAsFixed(2)} | rangoNormal: ${inNormalBmiRange(value)}";
}
String s5e5_squareRootAndMultipleOf3(int n) =>
    "cuadrado:${n * n} | raiz:${sqrt(n)} | multiploDe3:${n % 3 == 0}";
String s5e6_containsName(List<String> names, String target) =>
    "${names.contains(target)}";
String s5e7_basicCalculator(num a, String op, num b) {
  switch (op) {
    case '+':
      return "${a + b}";
    case '-':
      return "${a - b}";
    case '*':
      return "${a * b}";
    case '/':
      return "${a / b}";
    case '~/':
      return "${a ~/ b}";
    default:
      return "operador no soportado";
  }
}
String s5e8_eurToUsd(double eur, double rate) => "${eur * rate}";
String s5e9_textStats(String text) {
  final length = text.length;
  final startsUpper = text.isNotEmpty && text[0] == text[0].toUpperCase();
  return "caracteres:$length | empiezaMayúscula:$startsUpper";
}
String s5e10_truncateAndRound(double x) =>
    "truncado:${x.truncateToDouble()} | redondeado:${x.roundToDouble()}";

// -----------------------------
// MAIN — prints y lecturas
// -----------------------------
void main() {
  print("**********  Ejercicios 2-Oct-2025 **********");

  // Sección 1
  print("Sección 1: Enteros (int)");
  final age = readInt("Introduce tu edad");
  print("1. ${s1e1_age(age)}");
  final nForDouble = readInt("Número para doblar");
  print("2. ${s1e2_doubleOf(nForDouble)}");
  final nForSquare = readInt("Número para cuadrado");
  print("3. ${s1e3_squareOf(nForSquare)}");
  final opA = readInt("Entero A");
  final opB = readInt("Entero B");
  print("4. ${s1e4_basicOpsInt(opA, opB)}");
  print("5. ${s1e5_remainder25div4()}");
  final days = readInt("Número de días");
  print("6. ${s1e6_daysToHours(days)}");
  print("7. ${s1e7_dozenCount(38)}");
  final secs = readInt("Número de segundos");
  print("8. ${s1e8_secondsToMinSec(secs)}");
  final nEvenOdd = readInt("Número para par/impar");
  print("9. ${s1e9_evenOdd(nEvenOdd)}");
  final tableN = readInt("Número para tabla de multiplicar");
  print("10. ${s1e10_table(tableN)}");

  // Sección 2
  print("\nSección 2: Decimales (double)");
  final weight = readDouble("Introduce tu peso (kg)");
  print("1. ${s2e1_weight(weight)}");
  final radius = readDouble("Radio del círculo");
  print("2. ${s2e2_circleArea(radius)}");
  final price = readDouble("Precio base");
  final iva = readDouble("IVA %");
  print("3. ${s2e3_priceWithIva(price, iva)}");
  final celsius = readDouble("Grados Celsius");
  print("4. ${s2e4_cToF(celsius)}");
  final g1 = readDouble("Nota 1");
  final g2 = readDouble("Nota 2");
  final g3 = readDouble("Nota 3");
  print("5. ${s2e5_avg3(g1, g2, g3)}");
  final toTruncate = readDouble("Número decimal para truncar");
  print("6. ${s2e6_truncate2(toTruncate)}");
  final toRound = readDouble("Número decimal para redondear");
  print("7. ${s2e7_roundToUnit(toRound)}");
  final km = readDouble("Kilómetros a convertir");
  print("8. ${s2e8_kmToMi(km)}");
  final h = readDouble("Altura en metros");
  print("9. ${s2e9_bmi(weight, h)}");
  final bill = readDouble("Cuenta del restaurante");
  final people = readInt("Número de personas");
  print("10. ${s2e10_splitBill(bill, people)}");

  // Sección 3
  print("\nSección 3: Cadenas (String)");
  final name = readString("Tu nombre");
  print("1. ${s3e1_greet(name)}");
  print("2. ${s3e2_lengthOf(name)}");
  print("3. ${s3e3_upperLower(name)}");
  final surname = readString("Tu apellido");
  print("4. ${s3e4_fullName(name, surname)}");
  print("5. ${s3e5_firstLetter(name)}");
  final textDart = readString("Frase para comprobar 'Dart'");
  print("6. ${s3e6_containsDart(textDart)}");
  final phrase = readString("Frase para reemplazar 'malo' por 'bueno'");
  print("7. ${s3e7_replaceBad(phrase)}");
  final toReverse = readString("Texto para invertir");
  print("8. ${s3e8_reverse(toReverse)}");
  final textCount = readString("Palabra para contar 'a'");
  print("9. ${s3e9_countLetterA(textCount)}");
  final student = readString("Nombre del alumno");
  print("10. ${s3e10_welcome(student)}");

  // Sección 4
  print("\nSección 4: Booleanos (bool)");
  final havePet = readString("¿Tienes mascota? (s/n)") == 's';
  print("1. ${s4e1_havePet(havePet)}");
  final nGT100 = readInt("Número para comprobar >100");
  print("2. ${s4e2_greaterThan100(nGT100)}");
  final posNeg = readInt("Número positivo/negativo");
  print("3. ${s4e3_positiveOrNegative(posNeg)}");
  print("4. ${s4e4_boolOps(true,false)}");
  final ageCheck = readInt("Edad para comprobar >=18");
  print("5. ${s4e5_adult(ageCheck)}");
  final nDiv = readInt("Número para divisible por 5 y 2");
  print("6. ${s4e6_divisibleBy5and2(nDiv)}");
  final pwd = readString("Introduce contraseña");
  print("7. ${s4e7_passwordOk(pwd)}");
  final year = readInt("Año para comprobar bisiesto");
  print("8. ${s4e8_isLeap(year)}");
  final passed = readString("¿Aprobado? (s/n)") == 's';
  print("9. ${s4e9_passedMessage(passed)}");
  final vowelWord = readString("Palabra para comprobar vocal inicial");
  print("10. ${s4e10_startsWithVowel(vowelWord)}");

  // Sección 5
  print("\nSección 5: Combinados");
  final n5Name = readString("Nombre alumno");
  final n5Age = readInt("Edad alumno");
  print("1. ${s5e1_nextYear(n5Name, n5Age)}");
  final nn1 = readDouble("Nota1");
  final nn2 = readDouble("Nota2");
  final nn3 = readDouble("Nota3");
  print("2. ${s5e2_avgPass(nn1, nn2, nn3)}");
  final nCheck = readInt("Número par y >10");
  print("3. ${s5e3_evenAndGreater10(nCheck)}");
  final bmiName = readString("Nombre para IMC");
  final bmiWeight = readDouble("Peso (kg)");
  final bmiHeight = readDouble("Altura (m)");
  print("4. ${s5e4_bmiReport(bmiName, bmiWeight, bmiHeight)}");
  final intForOps = readInt("Número entero");
  print("5. ${s5e5_squareRootAndMultipleOf3(intForOps)}");
  print("6. ${s5e6_containsName(['Eloi','Ana','María'],'Ana')}");
  final calcA = readDouble("Calc A");
  final op = readString("Operador (+,-,*,/,~/)");
  final calcB = readDouble("Calc B");
  print("7. ${s5e7_basicCalculator(calcA, op, calcB)}");
  final eur = readDouble("Cantidad en EUR");
  final rate = readDouble("Tasa cambio");
  print("8. ${s5e8_eurToUsd(eur, rate)}");
  final textStats = readString("Texto");
  print("9. ${s5e9_textStats(textStats)}");
  final dec = readDouble("Número decimal");
  print("10. ${s5e10_truncateAndRound(dec)}");
}
