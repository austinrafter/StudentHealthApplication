import 'package:flutter/material.dart';

final List<String> noteDescription = [];
final List<String> noteHeading = [];
TextEditingController noteHeadingController = new TextEditingController();
TextEditingController noteDescriptionController = new TextEditingController();
FocusNode textSecondFocusNode = new FocusNode();

int notesHeaderMaxLenth = 25;
int notesDescriptionMaxLines = 100;
int notesDescriptionMaxLenth = 0;
String deletedNoteHeading = "";
String deletedNoteDescription = "";


List<Color?> noteColor = [
  Colors.pink[50],
  Colors.green[50],
  Colors.blue[50],
  Colors.orange[50],
  Colors.indigo[50],
  Colors.red[50],
  Colors.yellow[50],
  Colors.brown[50],
  Colors.teal[50],
  Colors.purple[50],
];
List<Color?> noteMarginColor = [
  Colors.pink[300],
  Colors.green[300],
  Colors.blue[300],
  Colors.orange[300],
  Colors.indigo[300],
  Colors.red[300],
  Colors.yellow[300],
  Colors.brown[300],
  Colors.teal[300],
  Colors.purple[300],
];