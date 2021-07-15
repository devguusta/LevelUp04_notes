import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notas/src/shared/constants/app_colors.dart';
import 'package:notas/src/shared/models/note_model.dart';

final _lightColors = [
  AppColors.amarelo,
  AppColors.verde,
  AppColors.rosa,
  AppColors.ciano,
  AppColors.roxo,
];

class NoteCardWidget extends StatelessWidget {
  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(note.createdTime);
    final minHeight = getMinHeight(index);

    return Card(
      color: Colors.grey.shade100,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Card(
              color: color,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  left: 4,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      note.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              "note.description",
              maxLines: null,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.15,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Criado em $time",
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontFamily: 'Roboto',
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
