// ======================================================
// Ejercicios 3-Oct-2025 — List, Set i Map en Dart
// Segueix l'estil dels exercicis anteriors: funcions pures
// i sortides clares per consola. 
// ======================================================

import 'dart:io';

// -----------------------------
// Helpers d'impressió
// -----------------------------
void printHeader(String title) {
  stdout.writeln("\n================= $title =================");
}

void printItem(int n, String? description, Object? value) {
  stdout.writeln("Exercici $n) $description : $value");
}

// -----------------------------
// L I S T S
// -----------------------------

// 1. Crea una llista amb tres colors i imprimeix-la.
List<String> l1_createColors() => ["vermell", "verd", "blau"];

// 2. Accedeix al primer element de la llista i imprimeix-lo.
String l2_first(List<String> xs) => xs.first;

// 3. Accedeix a l'últim element de la llista i imprimeix-lo.
String l3_last(List<String> xs) => xs.last;

// 4. Modifica el segon element de la llista i canvia'l per un altre valor.
List<String> l4_updateSecond(List<String> xs, String nou) {
  // Nota: treballem sobre una còpia per mantenir puresa.
  final copy = List<String>.from(xs);
  if (copy.length >= 2) copy[1] = nou;
  return copy;
}

// 5. Afegeix un nou element al final de la llista.
List<T> l5_append<T>(List<T> xs, T nou) {
  final copy = List<T>.from(xs)..add(nou);
  return copy;
}

// 6. Elimina el primer element de la llista.
List<T> l6_removeFirst<T>(List<T> xs) {
  final copy = List<T>.from(xs);
  if (copy.isNotEmpty) copy.removeAt(0);
  return copy;
}

// 7. Imprimeix el nombre d'elements que conté la llista.
int l7_length<T>(List<T> xs) => xs.length;

// 8. Comprova amb un if si la llista és buida o no usant isEmpty.
String l8_isEmpty<T>(List<T> xs) {
  if (xs.isEmpty) {
    return "buida";
  } else {
    return "no buida";
  }
}

// 9. Crea una llista de números i mostra l'element a la posició 2.
int l9_atIndex2(List<int> xs) => xs.length > 2 ? xs[2] : throw RangeError("Cal almenys 3 elements");

// 10. Declara una llista buida i després afegeix dos elements amb add.
List<String> l10_emptyThenAdd2() {
  final xs = <String>[];
  xs.add("primer");
  xs.add("segon");
  return xs;
}

// -----------------------------
// S E T S
// -----------------------------

// 1. Crea un Set amb tres ciutats i imprimeix-lo.
Set<String> s1_createCities() => {"Mataró", "Barcelona", "Girona"};

// 2. Intenta afegir un valor repetit al Set i observa què passa.
Set<T> s2_addDuplicate<T>(Set<T> s, T dup) {
  final copy = <T>{...s}..add(dup); // afegir el duplicat no canvia el conjunt
  return copy;
}

// 3. Accedeix a la mida del Set amb .length.
int s3_length<T>(Set<T> s) => s.length;

// 4. Comprova amb un if si el Set conté un valor específic amb contains.
String s4_contains<T>(Set<T> s, T value) {
  if (s.contains(value)) {
    return "hi és";
  } else {
    return "no hi és";
  }
}

// 5. Elimina un valor del Set amb remove.
Set<T> s5_remove<T>(Set<T> s, T value) {
  final copy = <T>{...s}..remove(value);
  return copy;
}

// 6. Declara un Set buit i afegeix dos elements amb add.
Set<String> s6_emptyThenAdd2() {
  final s = <String>{};
  s.add("A");
  s.add("B");
  return s;
}

// 7. Crea un Set de números i imprimeix el resultat després d'intentar afegir un duplicat.
Set<int> s7_numbersAndDuplicate(Set<int> s, int dup) => s2_addDuplicate(s, dup);

// 8. Usa un if per comprovar si el Set és buit amb .isEmpty.
String s8_isEmpty<T>(Set<T> s) {
  if (s.isEmpty) {
    return "buit";
  } else {
    return "no buit";
  }
} 

// 9. Crea un Set i elimina tots els seus elements amb clear.
Set<T> s9_cleared<T>(Set<T> s) {
  final copy = <T>{...s}; // còpia per no modificar l'original
  copy.clear();           // elimina tots els elements
  return copy;
}

// 10. Crea un Set amb diversos elements i mostra el primer .first i l'últim .last.
String s10_firstLast<T extends Comparable>(Set<T> s) {
  // Els Sets no garanteixen ordre d'inserció (a Dart sí que és iteració per inserció),
  // però per a l'exercici, extraurem first/last de la iteració actual.
  if (s.isEmpty) return "set buit";
  final first = s.first;
  final last = s.last;
  return "cadena $s primer: $first | últim: $last";
}

// -----------------------------
// M A P S  (nivell bàsic)
// -----------------------------

// 1. Crea un Map que relacioni nom->edat i imprimeix-lo.
Map<String, int> m1_peopleAges() => {"Ana": 20, "Joan": 30, "Eloi": 46};

// 2. Accedeix al valor d'una clau específica (p.ex., l'edat d"Ana").
int? m2_getAge(Map<String, int> m, String name) => m[name];

// 3. Afegeix un nou parell clau-valor (p.ex., "Luis":25).
Map<String, int> m3_addEntry(Map<String, int> m, String key, int value) {
  final copy = Map<String, int>.from(m)..[key] = value;
  return copy;
}

// 4. Elimina una clau del Map i mostra el resultat.
Map<K, V> m4_removeKey<K, V>(Map<K, V> m, K key) {
  final copy = Map<K, V>.from(m)..remove(key);
  return copy;
}

// 5. Comprova si una clau existeix amb containsKey.
String m5_containsKey<K, V>(Map<K, V> m, K key) {
  if (m.containsKey(key)) {
    return "$key existeix";
  } else {
    return "$key no existeix";
  }
}
// 6. Comprova si un valor concret hi és amb containsValue.
String m6_containsValue<K, V>(Map<K, V> m, V value) {
  if (m.containsValue(value)) {
    return "$value existeix";
  } else {
    return "$value no existeix";
  }
}
// 7. Modifica el valor d'una clau existent.
Map<K, V> m7_updateValue<K, V>(Map<K, V> m, K key, V newValue) {
  final copy = Map<K, V>.from(m);
  if (copy.containsKey(key)) copy[key] = newValue;
  return copy;
}

// 8. Declara un Map buit i afegeix dos elements amb assignacions directes.
Map<String, String> m8_emptyThenAdd2() {
  final m = <String, String>{};
  m["usuari"] = "egalles";
  m["rol"] = "docent";
  return m;
}

// 9. Imprimeix el nombre total d'elements del Map amb .length.
int m9_length<K, V>(Map<K, V> m) => m.length;

// 10. Si un Map conté la clau "password", imprimeix “Accés restringit”, si no “Accés lliure”.
String m10_passwordGate<K, V>(Map<K, V> m) => m.containsKey("password") ? "Accés restringit" : "Accés lliure";

// -----------------------------
// M A I N  — Demo d'execució
// -----------------------------
void main() {
  printHeader("LIST");
  final colors = l1_createColors();
  printItem(1, 'Crea una lista con tres colores e imprímela',colors);
  printItem(2, 'Accede al primer elemento de la lista e imprímelo',l2_first(colors));
  printItem(3, 'Accede al último elemento de la lista e imprímelo',l3_last(colors));
  final colors2 = l4_updateSecond(colors, "groc");
  String antiguoColor = colors[1];
  printItem(4, "Modifica el segundo elemento de la lista ($antiguoColor) y cámbialo por otro valor (groc).",colors2);
  printItem(5, "Añade un nuevo elemento al final de la lista.",l5_append(colors2, "negre"));
  printItem(6, "Elimina el primer elemento de la lista",l6_removeFirst(colors2));
  printItem(7, "Imprime el número de elementos que contiene la lista",l7_length(colors));
  printItem(8, "Comprueba con un  if si la lista está vacía o no usando  isEmpty",l8_isEmpty(colors));
  printItem(9, "Crea una lista ([10, 20, 30, 40]) de números y muestra el elemento en la posición 2",l9_atIndex2([10, 20, 30, 40]));
  printItem(10, "Declara una lista vacía y luego añade dos elementos con  add",l10_emptyThenAdd2());

  printHeader("SET");
  final cities = s1_createCities();
  printItem(1, "Crea un  Set con tres ciudades e imprímelo", cities);
  printItem(2, "Intenta añadir un valor repetido en el  Set y observa qué ocurre. NO añade Mataró, el set sigue igual", s2_addDuplicate(cities, "Mataró"));
  printItem(3, "Accede al tamaño del  Set usando  .length", s3_length(cities));
  printItem(4, "Comprueba con un  if si el  Set contiene un valor específico usando  contains", s4_contains(cities, "Barcelona"));
  printItem(5, "Elimina un valor del  Set usando  remove", s5_remove(cities, "Girona"));
  printItem(6, "Declara un  Set vacío y añade dos elementos con  add", s6_emptyThenAdd2());
  printItem(7, "Crea un  Set de números ({1, 2, 3}) e imprime el resultado después de intentar añadir un  duplicado (2)", s7_numbersAndDuplicate({1, 2, 3}, 2));
  printItem(8, "Usa un  if para comprobar si el  Set está vacío con  .isEmpty", s8_isEmpty(cities));
  printItem(9, "Crea un  Set y elimina todos sus elementos con  clear", s9_cleared(cities));
  printItem(10, "Crea un  Set con varios elementos y muestra el primer elemento con  .first y el último con  .last", s10_firstLast({ "A", "B", "C" }));

  printHeader("MAP");
  final people = m1_peopleAges();
  printItem(1, "Crea un Map que relacione el nombre de una persona con su edad e imprímelo", people);
  printItem(2, "Accede al valor de una clave específica en un Map (por ejemplo, la edad de 'Ana')", m2_getAge(people, "Ana"));
  printItem(3, "Añade un nuevo par clave-valor al Map (ejemplo: 'Luis' 25", m3_addEntry(people, "Luis", 25));
  printItem(4, "Elimina una clave (Joan) del Map y muestra el resultado", m4_removeKey(people, "Joan"));
  printItem(5, "Comprueba con un  if si una clave existe en el Map usando  containsKey", m5_containsKey(people, "Eloi"));
  printItem(6, "Comprueba con un  if si un valor (30) concreto está en el Map usando  containsValue", m6_containsValue(people, 30));
  printItem(7, "Modifica el valor de una clave existente en el Map (Ana)", m7_updateValue(people, "Ana", 21));
  printItem(8, "Declara un Map vacío y añade dos elementos con asignaciones directas.", m8_emptyThenAdd2());
  printItem(9, "Imprime el número total de elementos que tiene el Map usando  .length", m9_length(people));
  printItem(10, "Si un Map contiene la clave  'password', imprime “Acceso restringidoˮ, si no, imprime 'Acceso libre'.Ejercicios 3Oct-20252", m10_passwordGate({"user":"root","password":"1234"}));

}
