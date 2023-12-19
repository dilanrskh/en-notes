import 'package:ennotes/models/note.dart';
import 'package:ennotes/pages/detail_page.dart';
import 'package:ennotes/pages/form_page.dart';
import 'package:ennotes/pages/todo.dart';
import 'package:ennotes/utils/notes_database.dart';
import 'package:ennotes/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  int index = 0;
  final screen = [
    PageOne(),
    TODOPage(),
  ];
  List<Note> notes = [
    Note(
        id: 1,
        title: 'Enhypen Jay',
        description: 'Jay ikut berkontribusi di Sweet Venom',
        time: DateTime.now()),
    Note(
        id: 2,
        title: 'Paradoxx Invasion',
        description: 'Paradoxx invasion is my Favorit',
        time: DateTime.now()),
    Note(
        id: 3,
        title: 'Bias in Enhypen',
        description: 'Jay, Heeseung, Niki and Sunoo',
        time: DateTime.now()),
  ];

  bool isLoading = false;

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    refreshNotes();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    NotesDatabase.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return DetailPage(note: notes[index]);
                      }));
                      refreshNotes();
                    },
                    child: CardWidget(
                      index: index,
                      note: notes[index],
                    ),
                  );
                },
                itemCount: notes.length,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return const FormPage();
          }));
          refreshNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}