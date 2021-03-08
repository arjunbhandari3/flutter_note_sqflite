import 'package:flutter/material.dart';
import 'package:flutter_sqflite_note/controllers/note_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_sqflite_note/views/edit_note_view.dart';
import 'package:flutter_sqflite_note/models/note_model.dart';

class NoteCard extends GetWidget<NoteController> {
  final NoteModel note;

  NoteCard(this.note);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    note.title,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.edit),
                      onPressed: () => Get.to(EditNoteView(note: note)),
                    ),
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () => Get.bottomSheet(
                        Container(
                          child: Wrap(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  controller.deleteNote(note);
                                  Get.back();
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  height: 55,
                                  width: Get.width * 0.9,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Delete Note',
                                      style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  height: 55,
                                  width: Get.width * 0.9,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: Colors.white,
                        isDismissible: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 2,
            ),
            Text(
              note.description,
              maxLines: 4,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              note.dateTimeEdited,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
