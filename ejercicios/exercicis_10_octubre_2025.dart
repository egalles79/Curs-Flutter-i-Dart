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