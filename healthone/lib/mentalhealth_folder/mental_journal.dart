import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'NotePage.dart';

class JournalPage extends StatefulWidget {
  JournalPage({Key? key}) : super(key: key);
  
  @override
  _JournalPageState createState() => _JournalPageState();
}

  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);
  var newDate = DateTime.parse(date.toString());
  var formattedDate = "${newDate.day}-${newDate.month}-${newDate.year}";

class _JournalPageState extends State<JournalPage> {
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    notesDescriptionMaxLenth =
        notesDescriptionMaxLines * notesDescriptionMaxLines;
  }

  @override
  void dispose() {
    noteDescriptionController.dispose();
    noteHeadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: notesHeader(),
      ),
      body: noteHeading.length > 0
          ? buildNotes()
          : Center(child: Text("Add Entry")),
      floatingActionButton: FloatingActionButton(
        mini: false,
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          _settingModalBottomSheet(context);
        },
        child: Icon(Icons.create),
      ),
    );
  }

  Widget buildNotes() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: new ListView.builder(
        itemCount: noteHeading.length,
        itemBuilder: (context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.5),
            child: new Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                setState(() {
                  deletedNoteHeading = noteHeading[index];
                  deletedNoteDescription = noteDescription[index];
                  noteHeading.removeAt(index);
                  noteDescription.removeAt(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    new SnackBar(
                      backgroundColor: Colors.purple,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text(
                            "Entry Deleted",
                            style: TextStyle(),
                          ),
                          deletedNoteHeading != ""
                              ? GestureDetector(
                                  onTap: () {
                                    print("undo");
                                    setState(() {
                                      if (deletedNoteHeading != "") {
                                        noteHeading.add(deletedNoteHeading);
                                        noteDescription
                                            .add(deletedNoteDescription);
                                      }
                                      deletedNoteHeading = "";
                                      deletedNoteDescription = "";
                                    });
                                  },
                                  child: new Text(
                                    "Undo",
                                    style: TextStyle(),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  );
                });
              },
              background: ClipRRect(
                borderRadius: BorderRadius.circular(5.5),
                child: Container(
                  color: Colors.green,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              secondaryBackground: ClipRRect(
                borderRadius: BorderRadius.circular(5.5),
                child: Container(
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              child: noteList(index),
            ),
          );
        },
      ),
    );
  }

  Widget noteList(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: noteColor[(index % noteColor.length).floor()],
          borderRadius: BorderRadius.circular(5.5),
        ),
        height: 250,
        child: Center(
          child: Row(
            children: [
              new Container(
                color:
                    noteMarginColor[(index % noteMarginColor.length).floor()],
                width: 3.5,
                height: double.infinity,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Text(
                          noteHeading[index],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20.00,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Flexible(
                        child: Container(
                          height: double.infinity,
                          child: AutoSizeText(
                            formattedDate.toString() + ": ${(noteDescription[index])}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.00,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 50,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext bc) {
        return Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: (MediaQuery.of(context).size.height),
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 250, top: 50),
                  child: new Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "New Entry",
                            style: TextStyle(
                              fontSize: 20.00,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  noteHeading.add(noteHeadingController.text);
                                  noteDescription
                                      .add(noteDescriptionController.text);
                                  noteHeadingController.clear();
                                  noteDescriptionController.clear();
                                });
                                Navigator.pop(context);
                              }
                              print("Notes.dart LineNo:239");
                              print(noteHeadingController.text);
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Save",
                                    style: TextStyle(
                                      fontSize: 20.00,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.blueAccent,
                        thickness: 2.5,
                      ),
                      TextFormField(
                        maxLength: notesHeaderMaxLenth,
                        controller: noteHeadingController,
                        decoration: InputDecoration(
                          hintText: "Journal Heading",
                          hintStyle: TextStyle(
                            fontSize: 15.00,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: Icon(Icons.text_fields),
                        ),
                        validator: (String? noteHeading) {
                          if (noteHeading!.isEmpty) {
                            return "Please enter Journal Heading";
                          } else if (noteHeading!.startsWith(" ")) {
                            return "Please avoid whitespaces";
                          }
                        },
                        onFieldSubmitted: (String value) {
                          FocusScope.of(context)
                              .requestFocus(textSecondFocusNode);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          margin: EdgeInsets.all(1),
                          height: 5 * 24.0,
                          child: TextFormField(
                            focusNode: textSecondFocusNode,
                            maxLines: notesDescriptionMaxLines,
                            maxLength: notesDescriptionMaxLenth,
                            controller: noteDescriptionController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Description',
                              hintStyle: TextStyle(
                                fontSize: 15.00,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            validator: (String? noteDescription) {
                              if (noteDescription!.isEmpty) {
                                return "Please enter Journal Description";
                              } else if (noteDescription!.startsWith(" ")) {
                                return "Please avoid whitespaces";
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget notesHeader() {
  return Padding(
    padding: const EdgeInsets.only(
      top: 10,
      left: 2.5,
      right: 2.5,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Journal",
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 25.00,
            fontWeight: FontWeight.w500,
          ),
        ),
        Divider(
          color: Colors.blueAccent,
          thickness: 2.5,
        ),
      ],
    ),
  );
}