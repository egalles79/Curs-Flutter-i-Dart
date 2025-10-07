// -----------------------------
// Utils
// -----------------------------
int addInt(int x, int y) => x + y;
int subInt(int x, int y) => x - y;
int mulInt(int x, int y) => x * y;
int divInt(int numerator, int denominator) => numerator ~/ denominator;
int modInt(int numerator, int denominator) => numerator % denominator;

double addDouble(double x, double y) => x + y;
double subDouble(double x, double y) => x - y;
double mulDouble(double x, double y) => x * y;
double divDouble(double numerator, double denominator) => numerator / denominator;

String quotientAndRemainder(int numerator, int denominator) =>
    "Cociente: ${numerator ~/ denominator} Resto: ${numerator % denominator}";

String dozens(int number) => (number ~/ 12).toString();

String sumFromZeroTo(int limit) {
  var sum = 0;
  for (var i = 0; i <= limit; i++) sum += i;
  return "$sum";
}

double average(double x, double y) => (x + y) / 2;

// -----------------------------
// Exercises (cada exercici retorna String)
// -----------------------------

// Operacions amb int
String ex1()  => "${addInt(5, 3)}";
String ex2()  => "${subInt(10, 7)}";
String ex3()  => "${mulInt(4, 6)}";
String ex4()  => "${divInt(20, 4)}";
String ex5()  => "${divInt(17, 5)}";
String ex6()  => "${modInt(17, 5)}";
String ex7()  => "División: ${divInt(8, 3)} Resto: ${modInt(8, 3)}";
String ex8()  => "${addInt(2, 3) * 4}";
String ex9()  => "${subInt(50, 25) / 5}";
String ex10() => "${addInt(addInt(2, 7), 9)}";

// Operacions amb double
String ex11() => "${addDouble(2.5, 1.2)}";
String ex12() => "${subDouble(10.0, 3.5)}";
String ex13() => "${mulDouble(1.5, 4.0)}";
String ex14() => "${divDouble(7.5, 2.5)}";

// Tipus i conversions (el que abans estava dins main)
String ex15() => "${(5 / 2).runtimeType}";
String ex16() => "7 es:${7.toDouble().runtimeType}";
String ex17() => "${9.9.toInt()}";
String ex18() => "3.6 el redondeo es: ${3.6.round()}";
String ex19() => "2.1 el ceil es: ${2.1.ceil()}";
String ex20() => "2.9 el floor es: ${2.9.floor()}";

// Combinació int/double
String ex21() => "La suma de 5 + 2.5  es: ${addDouble(5, 2.5)}";
String ex22() => "La multiplicación de 5 * 2.5  es: ${mulDouble(5, 2.5)}";
String ex23() => "La división de 7 / 2.0  es: ${divDouble(7, 2.0)}";
String ex24() => "La división con 2 decimales es ${(5 / 2).toStringAsFixed(2)}";
String ex25() => "La división de 10 y 3 mas 0.5 es  ${divInt(10, 3) + 0.5}";

// Retos con enteros
String ex26() => "Las docenas de 28 son ${dozens(28)}";
String ex27() => "El resto de 45 entre 6 es ${modInt(45, 6)}";
String ex28() => "El cuadrado de 7  es ${mulInt(7, 7)}";
String ex29() => "La suma de 1+2+3+4+5  es ${sumFromZeroTo(5)}";
String ex30() => quotientAndRemainder(100, 8);

// Retos con decimales
String ex31() => "${average(4.5, 3.5)}";
String ex32() => "5.678 redondeado a 2 decimales: ${5.678.toStringAsFixed(2)}";
String ex33() => "${mulDouble(2.2, 2.2)}";
String ex34() => "10.0 / 3.0 = ${(10.0 / 3.0).toStringAsFixed(3)}";
String ex35() {
  final isAlmostEqual = ((0.1 + 0.2) - 0.3).abs() < 1e-10;
  return "0.1 + 0.2 = 0.3 verdad: $isAlmostEqual";
}

// Mixtos
String mix1() => "${divDouble(addInt(5, 3).toDouble(), 2)}";
String mix2() => "${mulInt(subInt(7, 2), addInt(3, 1))}";
String mix3() => "${2 * divDouble(4, 3)}";
String mix4() => "Real: ${divDouble(11, 2)} Entero: ${divInt(11, 2)}";
String mix5() => "${addDouble(1.5, divDouble(10, 4))}";

// -----------------------------
// Main (NOMÉS printatges)
// -----------------------------
void main() {
  print("********************* Operaciones básicas con  int ********************* ");
  print("Ejercicio 1: ${ex1()}");
  print("Ejercicio 2: ${ex2()}");
  print("Ejercicio 3: ${ex3()}");
  print("Ejercicio 4: ${ex4()}");
  print("Ejercicio 5: ${ex5()}");
  print("Ejercicio 6: ${ex6()}");
  print("Ejercicio 7: ${ex7()}");
  print("Ejercicio 8: ${ex8()}");
  print("Ejercicio 9: ${ex9()}");
  print("Ejercicio 10: ${ex10()}");

  print("********************* Operaciones básicas con  double ********************* ");
  print("Ejercicio 1: ${ex11()}");
  print("Ejercicio 2: ${ex12()}");
  print("Ejercicio 3: ${ex13()}");
  print("Ejercicio 4: ${ex14()}");
  print("Ejercicio 5: ${ex15()}");
  print("Ejercicio 6: ${ex16()}");
  print("Ejercicio 7: ${ex17()}");
  print("Ejercicio 8: ${ex18()}");
  print("Ejercicio 9: ${ex19()}");
  print("Ejercicio 10: ${ex20()}");

  print("********************* Combinando int y double ********************* ");
  print("Ejercicio 1: ${ex21()}");
  print("Ejercicio 2: ${ex22()}");
  print("Ejercicio 3: ${ex23()}");
  print("Ejercicio 4: ${ex24()}");
  print("Ejercicio 5: ${ex25()}");

  print("********************* pequeños retos con enteros ********************* ");
  print("Ejercicio 1: ${ex26()}");
  print("Ejercicio 2: ${ex27()}");
  print("Ejercicio 3: ${ex28()}");
  print("Ejercicio 4: ${ex29()}");
  print("Ejercicio 5: ${ex30()}");

  print("********************* Pequeños retos con decimales ********************* ");
  print("Ejercicio 1: ${ex31()}");
  print("Ejercicio 2: ${ex32()}");
  print("Ejercicio 3: ${ex33()}");
  print("Ejercicio 4: ${ex34()}");
  print("Ejercicio 5: ${ex35()}");

  print("********************* Ejercicios mixtos ********************* ");
  print("Ejercicio 1: ${mix1()}");
  print("Ejercicio 2: ${mix2()}");
  print("Ejercicio 3: ${mix3()}");
  print("Ejercicio 4: ${mix4()}");
  print("Ejercicio 5: ${mix5()}");
}
