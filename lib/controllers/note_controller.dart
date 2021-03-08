import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite_note/helpers/db_helper.dart';
import 'package:flutter_sqflite_note/models/note_model.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class NoteController extends GetxController {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  final notes = List<NoteModel>().obs;

  @override
  void onInit() {
    getNotes();
    super.onInit();
  }

  Future<void> addNote() async {
    await DBHelper.insert(NoteModel(
      description: descriptionTextController.text,
      title: titleTextController.text,
      dateTimeEdited:
          DateFormat("EEE, MMM dd, yyyy hh:mm a").format(DateTime.now()),
      dateTimeCreated:
          DateFormat("EEE, MMM dd, yyyy hh:mm a").format(DateTime.now()),
    ));
    getNotes();
    Get.back();
  }

  void getNotes() async {
    titleTextController.text = '';
    descriptionTextController.text = '';

    List<Map<String, dynamic>> noteList = await DBHelper.query();
    notes.assignAll(
        noteList.map((data) => new NoteModel.fromJson(data)).toList());
  }

  void updateNote(id, String dTCreated) async {
    NoteModel note = NoteModel(
      id: id,
      title: titleTextController.text,
      description: descriptionTextController.text,
      dateTimeEdited:
          DateFormat("EEE, MMM dd, yyyy hh:mm a").format(DateTime.now()),
      dateTimeCreated: dTCreated,
    );
    await DBHelper.update(note);
    getNotes();
    Get.back();
  }

  void deleteNote(NoteModel noteModel) async {
    await DBHelper.delete(noteModel);
    getNotes();
  }

  void deleteAllNotes() async {
    await DBHelper.deleteAllNotes();
    getNotes();
  }

  void shareNote(String title, String content, String dateTimeEdited) {
    Share.share("$title \n$dateTimeEdited\n\n$content");
  }
}
