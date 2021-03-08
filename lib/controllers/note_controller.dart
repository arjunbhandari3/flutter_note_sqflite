import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite_note/helpers/db_helper.dart';
import 'package:flutter_sqflite_note/models/note_model.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  final notes = List<NoteModel>().obs;

  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  NoteController() {
    getNotes();
  }

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

    titleTextController.text = '';
    descriptionTextController.text = '';

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
}
