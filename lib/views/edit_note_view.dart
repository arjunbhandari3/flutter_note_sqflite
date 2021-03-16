import 'package:flutter/material.dart';
import 'package:flutter_sqflite_note/controllers/note_controller.dart';
import 'package:flutter_sqflite_note/models/note_model.dart';
import 'package:flutter_sqflite_note/utils/styles.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditNoteView extends GetView<NoteController> {
  final NoteModel? note;
  final _formKey = GlobalKey<FormState>();

  EditNoteView({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.titleController.text = note!.title!;
    controller.descriptionController.text = note!.description!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Update Note',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: controller.titleController,
                  showCursor: true,
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 18),
                  decoration:
                      styleTextInputDecoration.copyWith(hintText: 'Title'),
                  validator: (value) => value!.trim().isNotEmpty
                      ? null
                      : 'Please give title to note',
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: controller.descriptionController,
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 18),
                  maxLines: 10,
                  decoration: styleTextInputDecoration.copyWith(
                      hintText: 'Description'),
                  validator: (value) => value!.trim().isNotEmpty
                      ? null
                      : 'Please give description to note',
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      controller.updateNote(note!.id, note!.dateTimeCreated);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF1A0551),
                    onPrimary: Color(0xFF330B99),
                    shape: StadiumBorder(),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      'Update Note',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
