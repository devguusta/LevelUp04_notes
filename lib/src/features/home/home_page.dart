import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notas/src/database/notes_database.dart';
import 'package:notas/src/features/notes/newnote_page.dart';
import 'package:notas/src/features/notes/note_detail_page.dart';
import 'package:notas/src/shared/constants/app_colors.dart';
import 'package:notas/src/shared/constants/text_styles.dart';
import 'package:notas/src/shared/models/note_model.dart';
import 'package:notas/src/shared/widgets/note_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    this.notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? CircularProgressIndicator()
          : notes.isEmpty
              ? Stack(
                  children: [
                    SafeArea(
                      top: true,
                      child: Image.asset(
                        "assets/images/empty_notes_background.png",
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Align(
                      alignment: Alignment(Alignment.center.x, -0.33),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Hero(
                            tag: "notes_logo",
                            child: Image.asset(
                              "assets/images/notes_logo.png",
                            ),
                          ),
                          Hero(
                            tag: "journal",
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                "journal",
                                style: TextStyles.white48w700Montserrat,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 24.0,
                              bottom: 140.0,
                              left: 40.0,
                              right: 40.0,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Não importa onde você\nesteja! Guarde suas ideias pra depois ;)",
                                    style: TextStyles.roxo24w400Roboto,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Comece agora a criar as suas notas!",
                                    style: TextStyles.ciano16w400Roboto,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : buildNotes(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        child: Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            gradient: AppColors.blueGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                offset: Offset(0.0, 1.0),
                blurRadius: 18.0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.14),
                offset: Offset(0.0, 6.0),
                blurRadius: 10.0,
              ),
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0.0, 3),
                  blurRadius: 5.0,
                  spreadRadius: -1.0),
            ],
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return NewNotePage();
                  }),
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNotes() => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(86),
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.blueGradient,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Image.asset(
                "assets/images/light_journal.png",
              ),
            ),
          ),
        ),
        body: StaggeredGridView.countBuilder(
          padding: EdgeInsets.all(8),
          itemCount: notes.length,
          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            final note = notes[index];

            return GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteDetailPage(noteId: note.id!),
                ));

                refreshNotes();
              },
              child: NoteCardWidget(note: note, index: index),
            );
          },
        ),
      );
}
