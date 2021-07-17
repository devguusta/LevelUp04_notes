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
    // final minHeight = getMinHeight(index);

    return Card(
      color: Colors.grey.shade100,
      child: Container(
        constraints: BoxConstraints(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Card(
              color: color,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 0.0,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, bottom: 8, left: 10),
                    child: Text(
                      "Não esquecer de",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.15,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Stack(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                padding: EdgeInsets.only(left: 75.0),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.attach_file_outlined,
                                  color: Colors.black.withOpacity(0.54),
                                  size: 15,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                padding: EdgeInsets.only(right: 20.0),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.black.withOpacity(0.54),
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consecter adipiscin elit, sed incididunt ut labore et dolore aliqua.",
                    maxLines: null,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.54),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.15,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 145),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Criado em $time",
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                    fontFamily: 'Roboto',
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }

//   double getMinHeight(int index) {
//     switch (index % 4) {
//       case 0:
//         return 145;
//       case 1:
//         return 200;
//       case 2:
//         return 145;
//       case 3:
//         return 200;
//       default:
//         return 145;
//     }
//   }
}
