import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/note_model.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;
  final _noteBox = Hive.box('notesBox');

  @override
  void onInit() {
    loadNotes();
    super.onInit();
  }

  void loadNotes() {
    notes.value = _noteBox.values.map((note) => note as Note).toList();
  }

  void addNote(Note note) {
    _noteBox.add(note);
    loadNotes();
  }

  void updateNote(int index, Note note) {
    _noteBox.putAt(index, note);
    loadNotes();
  }

  void deleteNote(int index) {
    _noteBox.deleteAt(index);
    loadNotes();
  }
}
