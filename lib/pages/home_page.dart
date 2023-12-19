import 'package:ennotes/models/note.dart';
import 'package:ennotes/pages/page_one.dart';
import 'package:ennotes/pages/todo.dart';
import 'package:ennotes/utils/notes_database.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final screens = [
    const PageOne(),
    const TODOPage(),
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
      appBar: AppBar(
        title: const Text(
          'ENGENE NOTES',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            ) : screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Color.fromARGB(255, 246, 219, 251),
          selectedIndex: index,
          onDestinationSelected: (index) => 
          setState(() => this.index = index),
          destinations: const[
          NavigationDestination(icon: Icon(Icons.note_add_rounded), label: "Notes"),
          NavigationDestination(icon: Icon(Icons.done_rounded), label: "To Do")
        ]),
        ),
    );
  }
}