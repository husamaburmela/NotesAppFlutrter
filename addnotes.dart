import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_api_php_wael/component.dart';
import 'package:flutter_frontend_api_php_wael/main.dart';
import 'package:image_picker/image_picker.dart';

import 'crud.dart';
import 'linkapi.dart';

class addnotes extends StatefulWidget {
  const addnotes({super.key});

  @override
  State<addnotes> createState() => _addnotesState();
}

class _addnotesState extends State<addnotes> {
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  Crud curd = Crud();
  bool isloading = false;
  AddNotesFun() async {
    if (myfile == null)
      return AwesomeDialog(
          context: context,
          title: "هام",
          body: Text("الرجاء اضافة الصورة الخاصة بالملاحظة"))
        ..show();
    if (formstate.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await curd.PostRequestwithfile(
          linkAdd,
          {
            "title": title.text,
            "content": content.text,
            "id": sharedPreferences!.getString("id"),
          },
          myfile!);
      isloading = false;
      setState(() {});
      if (response['status'] == 'success') {
        Navigator.of(context).pushReplacementNamed("home");
      }
    }
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
                        return validInput(val!, 4, 50);
                      }),
                  CustomTextField1(
                      hint: "content",
                      mycontroller: content,
                      valid: (val) {
                        return validInput(val!, 4, 500);
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
                      await AddNotesFun();
                    },
                    child: Text("Add"),
                    style: Button_style_2,
                  )
                ]),
              ),
            ),
    );
  }
}
