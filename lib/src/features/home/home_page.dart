import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notas/src/database/notes_database.dart';
import 'package:notas/src/features/home/home_empty_page.dart';
import 'package:notas/src/features/notes/newnote_page.dart';
import 'package:notas/src/features/notes/note_detail_page.dart';
import 'package:notas/src/shared/constants/app_colors.dart';
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
          ? Center(child: CircularProgressIndicator())
          : notes.isEmpty
              ? HomeEmpty()
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
              gradient: AppColors.blueGradientAppBar,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Image.asset(
                "assets/images/light_journal.png",
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  right: 50,
                  top: 18,
                  bottom: 26,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Pesquisar",
                    hintStyle: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.15,
                      color: Colors.black.withOpacity(0.54),
                    ),
                    suffixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.black.withOpacity(0.54),
                    ),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ),
              StaggeredGridView.countBuilder(
                shrinkWrap: true,
                padding: EdgeInsets.all(8),
                itemCount: notes.length,
                staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                crossAxisCount: 4,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NoteDetailPage(noteId: note.id!),
                      ));

                      refreshNotes();
                    },
                    child: Column(
                      children: [
                        NoteCardWidget(note: note, index: index),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
}
