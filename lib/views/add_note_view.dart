import 'package:flutter/material.dart';
import 'package:flutter_sqflite_note/controllers/note_controller.dart';
import 'package:flutter_sqflite_note/utils/styles.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNoteView extends GetView<NoteController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Note',
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
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 18),
                  decoration:
                      styleTextInputDecoration.copyWith(hintText: 'Title'),
                  validator: (value) => value.trim().isNotEmpty
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
                  validator: (value) => value.trim().isNotEmpty
                      ? null
                      : 'Please give discription to note',
                ),
                SizedBox(
                  height: 16,
                ),
                RaisedButton(
                  color: Color(0xFF1A0551),
                  shape: StadiumBorder(),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await controller.addNote();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      'Add Note',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
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
