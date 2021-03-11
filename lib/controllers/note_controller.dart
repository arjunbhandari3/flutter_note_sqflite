import 'package:flutter_sqflite_note/views/note_list_view.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite_note/helpers/db_helper.dart';
import 'package:flutter_sqflite_note/models/note_model.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class NoteController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final notes = List<NoteModel>().obs;

  @override
  void onInit() {
    getNotes();
    super.onInit();
  }

  Future<void> addNote() async {
    await DBHelper.insert(NoteModel(
      description: descriptionController.text,
      title: titleController.text,
      dateTimeEdited:
          DateFormat("EEE, MMM dd, yyyy hh:mm a").format(DateTime.now()),
      dateTimeCreated:
          DateFormat("EEE, MMM dd, yyyy hh:mm a").format(DateTime.now()),
    ));
    getNotes();
    Get.back();
  }

  void getNotes() async {
    titleController.text = '';
    descriptionController.text = '';

    List<Map<String, dynamic>> noteList = await DBHelper.query();
    notes.assignAll(
        noteList.map((data) => new NoteModel.fromJson(data)).toList());
  }

  void updateNote(id, String dTCreated) async {
    final title = titleController.text;
    final description = descriptionController.text;
    NoteModel note = NoteModel(
      id: id,
      title: title,
      description: description,
      dateTimeEdited:
          DateFormat("EEE, MMM dd, yyyy hh:mm a").format(DateTime.now()),
      dateTimeCreated: dTCreated,
    );
    await DBHelper.update(note);
    getNotes();
    Get.offAll(NoteListView());
  }

  void deleteNote(NoteModel noteModel) async {
    await DBHelper.delete(noteModel);
    getNotes();
  }

  void deleteAllNotes() async {
    await DBHelper.deleteAllNotes();
    getNotes();
  }

  void shareNote(String title, String description, String dateTimeEdited) {
    Share.share("$title \n$dateTimeEdited\n\n$description");
  }
}
