import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'component.dart';
import 'crud.dart';
import 'linkapi.dart';

class editnotes extends StatefulWidget {
  final notes;
  editnotes({super.key, this.notes});

  @override
  State<editnotes> createState() => _editnotesState();
}

class _editnotesState extends State<editnotes> with Crud {
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isloading = false;
  editNotesFun() async {
    if (formstate.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response;
      if (myfile == null) {
        //without file
        response = await PostRequest(linkEdit, {
          "title": title.text,
          "content": content.text,
          "id": widget.notes['notes_id'].toString(),
          "imagename": widget.notes['notes_image'].toString(),
        });
      } else {
        //with file
        response = await PostRequestwithfile(
            linkEdit,
            {
              "title": title.text,
              "content": content.text,
              "id": widget.notes['notes_id'].toString(),
              "imagename": widget.notes['notes_image'].toString(),
            },
            myfile!);
      }
      isloading = false;
      setState(() {});
      if (response['status'] == 'success') {
        Navigator.of(context).pushReplacementNamed("home");
      }
    }
  }

  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('addnotes'),
      ),
      body: isloading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              color: Colors.amber,
              child: Form(
                key: formstate,
                child: ListView(children: [
                  CustomTextField1(
                      hint: "title",
                      mycontroller: title,
                      valid: (val) {
                        validInput(val!, 4, 50);
                        return null;
                      }),
                  CustomTextField1(
                      hint: "content",
                      mycontroller: content,
                      valid: (val) {
                        validInput(val!, 4, 500);
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                                height: 120,
                                child: Column(
                                  children: [
                                    Text("Please Choose Image"),
                                    //IIIIIIIIIIIIIIIIIIIII
                                    //inkwell one -Gallery
                                    InkWell(
                                      onTap: () async {
                                        var xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        Navigator.of(context).pop();
                                        if (xfile != null) {
                                          myfile = File(xfile.path);
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "From Gallery",
                                        ),
                                      ),
                                    ),
                                    //IIIIIIIIIIIIIIIIIII
                                    //inkwell tow -Camera
                                    InkWell(
                                      onTap: () async {
                                        var xfile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        Navigator.of(context).pop();

                                        if (xfile != null) {
                                          myfile = File(xfile.path);
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "From Camera",
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ));
                    },
                    child: Text("Choose Image"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          myfile == null ? Colors.blue : Colors.red,
                    ),
                    // style: Button_style_2,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await editNotesFun();
                    },
                    child: Text("save"),
                    style: Button_style_2,
                  )
                ]),
              ),
            ),
    );
  }
}
