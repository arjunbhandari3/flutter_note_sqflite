import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_sqflite_note/views/widgets/noteCard.dart';
import 'package:flutter_sqflite_note/controllers/note_controller.dart';
import 'package:flutter_sqflite_note/models/note_model.dart';

class SearchBar extends SearchDelegate {
  final NoteController controller = Get.find();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.black,
        ),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        color: Colors.black,
        progress: transitionAnimation,
      ),
      onPressed: () {
        Get.back();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? controller.notes
        : controller.notes.where(
            (p) {
              return p.title.toLowerCase().contains(query.toLowerCase()) ||
                  p.description.toLowerCase().contains(query.toLowerCase());
            },
          ).toList();

    return suggestionList.length > 0
        ? SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: suggestionList.length,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  NoteModel note = suggestionList[index];
                  return NoteCard(note);
                },
              ),
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: Center(
              child: Text(
                "No Results Found!",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          );
  }
}
