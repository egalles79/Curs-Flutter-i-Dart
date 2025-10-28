import 'package:flutter/material.dart';

void main() => runApp(const WireframeApp());

/// ─────────────────────────────────────────────────────────────────────────
/// Llegenda de colors :
///   Scaffold   → Blau
///   AppBar     → Blau fosc
///   Container  → Vermell
///   Padding    → Ambre
///   ClipRRect  → Porpra
///   ListView   → Verd
///   Column     → Teal
///   Row        → Cian
///   Grid/Sliver→ Taronja
///   Miniplayer → Gris
/// ─────────────────────────────────────────────────────────────────────────

const kScaffoldColor = Colors.blue;
const kAppBarColor = Color(0xFF1E3A8A); // indigo-900
const kContainerColor = Colors.red;
const kPaddingColor = Colors.amber;
const kClipRRectColor = Colors.purple;
const kListViewColor = Colors.green;
const kColumnColor = Colors.teal;
const kRowColor = Colors.cyan;
const kGridColor = Colors.orange;
const kMiniColor = Colors.blueGrey;

/// Widget de suport: pinta una caixa amb color i una etiqueta al cantó superior esquerre.
class LabeledBox extends StatelessWidget {
  final String label;
  final Color color;
  final double minHeight;
  final Widget? child;
  final EdgeInsets padding;
  final BorderRadius? radius;

  const LabeledBox({
    super.key,
    required this.label,
    required this.color,
    this.minHeight = 60,
    this.child,
    this.padding = const EdgeInsets.all(8),
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final box = Container(
      constraints: BoxConstraints(minHeight: minHeight),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        border: Border.all(color: color, width: 2),
        borderRadius: radius,
      ),
      child: Stack(
        children: [
          Padding(
            padding: padding.copyWith(top: padding.top + 20),
            child: child,
          ),
          Positioned(
            left: 8,
            top: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return radius == null
        ? box
        : ClipRRect(borderRadius: radius!, child: box);
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bàsica: MaterialApp → Scaffold (blau) amb pàgina tipus YouTube Music
// però en forma de CAIXES etiquetades.
// ─────────────────────────────────────────────────────────────────────────
class WireframeApp extends StatelessWidget {
  const WireframeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wireframe Flutter (caixes)',
      theme: ThemeData.dark(useMaterial3: true),
      home: const WireframeScaffold(),
    );
  }
}

class WireframeScaffold extends StatelessWidget {
  const WireframeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold (blau)
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: const Text('YouTube Music – Wireframe'),
        // AppBar ja és prou clar; afegim una tira que el “marqui”
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(height: 4, color: kScaffoldColor),
        ),
      ),
      body: Stack(
        children: [
          // Cos principal: Column amb seccions encabides en CustomScrollView
          LabeledBox(
            label: 'Scaffold.body (Column)',
            color: kScaffoldColor,
            minHeight: 0,
            child: Column(
              children: [
                // Barra de pestanyes i categories (Row + Padding + Chips simulats)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LabeledBox(
                    label: 'Padding',
                    color: kPaddingColor,
                    child: LabeledBox(
                      label: 'Row (CategoryChips)',
                      color: kRowColor,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(
                          6,
                          (i) => LabeledBox(
                            label: 'Container (Chip)',
                            color: kContainerColor,
                            minHeight: 32,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: Text('Chip $i'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Llista horitzontal (ListView) com un carrusel
                SizedBox(
                  height: 160,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: LabeledBox(
                      label: 'ListView (Horizontal Carousel)',
                      color: kListViewColor,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (_, i) => AspectRatio(
                          aspectRatio: 1,
                          child: LabeledBox(
                            label: 'Container (Card $i)',
                            color: kContainerColor,
                            radius: BorderRadius.circular(12),
                            child: Center(child: Text('Playlist $i')),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Grid simulant àlbums
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LabeledBox(
                      label: 'GridView (Albums)',
                      color: kGridColor,
                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 96),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 1,
                            ),
                        itemCount: 8,
                        itemBuilder: (_, i) => LabeledBox(
                          label: 'ClipRRect',
                          color: kClipRRectColor,
                          radius: BorderRadius.circular(12),
                          child: Center(
                            child: LabeledBox(
                              label: 'Container (Album $i)',
                              color: kContainerColor,
                              child: const Center(child: Text('Portada')),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Miniplayer persistent (gris) enganxat a baix
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LabeledBox(
                label: 'Container (MiniPlayer)',
                color: kMiniColor,
                minHeight: 68,
                child: Row(
                  children: [
                    // Caràtula
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: LabeledBox(
                        label: 'ClipRRect',
                        color: kClipRRectColor,
                        radius: BorderRadius.circular(6),
                        child: const Center(child: Text('Cover')),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Títol + artista
                    Expanded(
                      child: LabeledBox(
                        label: 'Column (Text)',
                        color: kColumnColor,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Títol del tema'),
                            SizedBox(height: 4),
                            Text(
                              'Artista',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Botons
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 120,
                      child: LabeledBox(
                        label: 'Row (Buttons)',
                        color: kRowColor,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Icon(Icons.pause), Icon(Icons.skip_next)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Barra inferior de navegació (wireframe)
      bottomNavigationBar: LabeledBox(
        label: 'NavigationBar (Bottom)',
        color: kScaffoldColor,
        minHeight: 64,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.home_outlined),
            Icon(Icons.explore_outlined),
            Icon(Icons.library_music_outlined),
          ],
        ),
      ),
    );
  }
}
