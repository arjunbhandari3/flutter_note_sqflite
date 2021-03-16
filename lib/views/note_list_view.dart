import 'package:flutter/material.dart';
import 'package:flutter_sqflite_note/controllers/note_controller.dart';
import 'package:flutter_sqflite_note/models/note_model.dart';
import 'package:flutter_sqflite_note/views/add_note_view.dart';
import 'package:flutter_sqflite_note/views/widgets/search_bar.dart';
import 'package:flutter_sqflite_note/views/widgets/noteCard.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteListView extends StatelessWidget {
  final controller = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notes',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBar());
            },
          ),
          PopupMenuButton(
            onSelected: (dynamic val) {
              if (val == 0) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                        "Are you sure you want to delete all notes?",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "No",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller!.deleteAllNotes();
                            Get.back();
                          },
                          child: Text(
                            "Yes",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  "Delete All Notes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: Obx(
        () => controller!.notes.isNotEmpty
            ? SingleChildScrollView(
                child: Container(
                  color: Colors.white70,
                  padding: EdgeInsets.all(16),
                  child: ListView.separated(
                    itemCount: controller!.notes.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, int) => SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      NoteModel note = controller!.notes[index];
                      return NoteCard(note);
                    },
                  ),
                ),
              )
            : Container(
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    "You don't have any Notes",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Get.to(AddNoteView());
        },
        backgroundColor: Color(0xff0A2662),
        label: Text(
          '+ Add Note',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
