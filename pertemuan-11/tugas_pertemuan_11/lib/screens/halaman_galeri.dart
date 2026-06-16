import 'package:flutter/material.dart';
import '../helpers/ui_helpers.dart';

class HalamanGaleri extends StatelessWidget {
  const HalamanGaleri({super.key});

  static const _items = [
    [Icons.landscape,       'Alam',       Colors.green],
    [Icons.directions_car,  'Otomotif',   Colors.red],
    [Icons.food_bank,       'Kuliner',    Colors.orange],
    [Icons.sports_soccer,   'Olahraga',   Colors.blue],
    [Icons.music_note,      'Musik',      Colors.pink],
    [Icons.computer,        'Teknologi',  Colors.indigo],
    [Icons.travel_explore,  'Travel',     Colors.teal],
    [Icons.palette,         'Seni',       Colors.purple],
    [Icons.architecture,    'Arsitektur', Colors.brown],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeri'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final r = _items[index];
          final color = r[2] as Color;
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => popupAlert(context,
              judul: r[1] as String,
              isi: 'Kamu membuka kategori "${r[1]}".\nFitur galeri lengkap segera hadir!',
              icon: r[0] as IconData, iconColor: color,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: color.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))
                  ],
                  border: Border.all(color: color.withOpacity(0.15))),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle
                  ),
                  child: Icon(r[0] as IconData, color: color, size: 36)
                ),
                const SizedBox(height: 12),
                Text(r[1] as String,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
              ]),
            ),
          );
        },
      ),
    );
  }
}