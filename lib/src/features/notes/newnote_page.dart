import 'package:flutter/material.dart';

import 'package:notas/src/database/notes_database.dart';
import 'package:notas/src/shared/constants/app_colors.dart';
import 'package:notas/src/shared/models/note_model.dart';
import 'package:notas/src/shared/widgets/note_form.dart';

class NewNotePage extends StatefulWidget {
  final Note? note;
  const NewNotePage({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;
  // TextEditingController _titleInputController = TextEditingController();
  // TextEditingController _descriptionInputController = TextEditingController();

  late DropDownItemData _value = DropDownItemData(
    color: AppColors.rosa,
    value: "rosa",
  );

  final List<DropDownItemData> list = [
    DropDownItemData(
      color: AppColors.rosa,
      value: "rosa",
    ),
    DropDownItemData(
      color: AppColors.verde,
      value: "verde",
    ),
    DropDownItemData(
      color: AppColors.roxo,
      value: "roxo",
    ),
    DropDownItemData(
      color: AppColors.ciano,
      value: "ciano",
    ),
    DropDownItemData(
      color: AppColors.amarelo,
      value: "amarelo",
    ),
  ];

  @override
  void initState() {
    _value = list[0];
    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset("assets/images/journal_note.png"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: NoteFormWidget(
                            hintText: "Título",
                            title: title,
                            onChangedTitle: (title) => setState(() {
                              this.title = title;
                            }),
                          ),
                        ),
                        DropdownButton(
                          underline: Container(),
                          onChanged: (value) {
                            setState(() {
                              _value = value as DropDownItemData;
                            });
                          },
                          value: _value,
                          selectedItemBuilder: (BuildContext context) {
                            return list.map<Widget>((DropDownItemData item) {
                              return Center(
                                child: Container(
                                  height: 18.0,
                                  width: 18.0,
                                  decoration: BoxDecoration(
                                    color: _value.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          focusColor: Colors.transparent,
                          items: list
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Center(
                                    child: Container(
                                      height: 18.0,
                                      width: 18.0,
                                      decoration: BoxDecoration(
                                        color: e.color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    NoteFormWidget(
                      hintText: 'Digite algo',
                      description: description,
                      onChangedDescription: (description) => setState(() {
                        this.description = description;
                      }),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 88.0, right: 36),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: addOrUpdateNote,
                child: Text("Salvar",
                    style: TextStyle(
                        fontFamily: "Roboto", fontWeight: FontWeight.w500)),
              ),
            ),
          ),
          Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: 24.0,
                ),
                child: SafeArea(
                  bottom: true,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.date_range,
                            color: Colors.black.withOpacity(0.54),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.attach_file_outlined,
                            color: Colors.black.withOpacity(0.54),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.black.withOpacity(0.54),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            color: Colors.black.withOpacity(0.54),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black.withOpacity(0.54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}

class DropDownItemData {
  final Color color;
  final String value;

  DropDownItemData({
    required this.color,
    required this.value,
  });
}
