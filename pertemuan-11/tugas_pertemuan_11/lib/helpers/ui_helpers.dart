import 'package:flutter/material.dart';

void snack(BuildContext ctx, String msg, {Color color = Colors.blueAccent}) =>
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(msg, style: const TextStyle(fontWeight: FontWeight.w600)),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 1),
    ));

Future<void> popupAlert(
  BuildContext ctx, {
  required String judul,
  required String isi,
  IconData icon = Icons.info_outline,
  Color iconColor = Colors.blueAccent,
  String tombolOk = 'OK',
  String? tombolBatal,
  VoidCallback? onOk,
}) {
  return showDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titlePadding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      title: Column(children: [
        CircleAvatar(
            radius: 36,
            backgroundColor: iconColor.withOpacity(.15),
            child: Icon(icon, color: iconColor, size: 36)),
        const SizedBox(height: 16),
        Text(judul,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ]),
      content: Text(isi,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4)),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      actions: [
        if (tombolBatal != null)
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: iconColor, width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () => Navigator.pop(ctx),
            child: Text(tombolBatal, style: TextStyle(color: iconColor, fontWeight: FontWeight.bold)),
          ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: iconColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          onPressed: () {
            Navigator.pop(ctx);
            onOk?.call();
          },
          child: Text(tombolOk, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}