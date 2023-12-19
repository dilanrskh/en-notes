// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ennotes/pages/form_page.dart';
import 'package:ennotes/utils/notes_database.dart';
import 'package:flutter/material.dart';

import 'package:ennotes/models/note.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final Note note;
  const DetailPage({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Note note;

  Future refreshNote() async {
    note = await NotesDatabase.instance.readNote(widget.note.id!);
    setState(() {});
  }

  @override
  void initState() {
    note = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(note.title),
          actions: [
            InkWell(
                onTap: () async {
                  await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return FormPage(
                      note: widget.note,
                    );
                  }));
                  refreshNote();
                },
                child: Icon(Icons.edit)),
            SizedBox(
              width: 12,
            ),
            InkWell(
                onTap: () async {
                  await NotesDatabase.instance.delete(widget.note.id!);
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.delete)),
            SizedBox(
              width: 16,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: ListView(
            children: [
              Text(
                DateFormat.yMMMMEEEEd().format(note.time),
                style: const TextStyle(
                    color: const Color.fromARGB(255, 75, 74, 74),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 24,
              ),
              Text(
                note.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                note.description,
                style: const TextStyle(
                    color: Color.fromARGB(255, 58, 58, 58),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
