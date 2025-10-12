// ======================================================
// Ejercicios 10-Oct-2025 — Funcions, async/await i errors en Dart
// Mode demo (--demo) i mode interactiu (per defecte).
// ======================================================
import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

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