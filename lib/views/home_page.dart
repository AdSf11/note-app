import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/note_service.dart';
import 'note_tile.dart';
import 'edit_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NoteService _service = NoteService();
  List<Note> notes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() => isLoading = true);
    notes = await _service.loadNotes();
    setState(() => isLoading = false);
  }

  Future<void> _saveNotes() async {
    await _service.saveNotes(notes);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ملاحظاتي', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
              },
            ),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : notes.isEmpty
                ? const Center(child: Text('لا توجد ملاحظات بعد.', style: TextStyle(fontSize: 18)))
                : ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return NoteTile(
                        note: notes[index],
                        onTap: () async {
                          final edited = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditPage(note: notes[index]),
                            ),
                          );
                          if (edited != null && edited is Note) {
                            setState(() {
                              notes[index] = edited;
                            });
                            await _saveNotes();
                          }
                        },
                        onDelete: () async {
                          setState(() {
                            notes.removeAt(index);
                          });
                          await _saveNotes();
                        },
                      );
                    },
                  ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final newNote = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditPage()),
            );
            if (newNote != null && newNote is Note && newNote.content.trim().isNotEmpty) {
              setState(() {
                notes.add(newNote);
              });
              await _saveNotes();
            }
          },
          icon: const Icon(Icons.add),
          label: const Text('إضافة'),
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
