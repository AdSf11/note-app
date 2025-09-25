import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';
import 'dart:convert';

class NoteService {
  static const String notesKey = 'notes';

  Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesString = prefs.getStringList(notesKey) ?? [];
    return notesString.map((e) => Note.fromJson(json.decode(e))).toList();
  }

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final notesString = notes.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(notesKey, notesString);
  }
}
