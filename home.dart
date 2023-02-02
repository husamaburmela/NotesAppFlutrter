import 'package:flutter/material.dart';
import 'package:flutter_frontend_api_php_wael/NotesModelPage.dart';
import 'package:flutter_frontend_api_php_wael/cardnote.dart';
import 'package:flutter_frontend_api_php_wael/crud.dart';
import 'package:flutter_frontend_api_php_wael/editnotes.dart';
import 'package:flutter_frontend_api_php_wael/linkapi.dart';
import 'package:flutter_frontend_api_php_wael/main.dart';

class home extends StatefulWidget {
  const home({super.key});
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with Crud {
  getNotes() async {
    var response =
        await PostRequest(linkView, {"id": sharedPreferences!.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
        actions: [
          IconButton(
              onPressed: () {
                sharedPreferences!.clear();
                Navigator.of(context).pushNamed("login");
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("addnotes");
          },
          child: Icon(Icons.add)),
      body: Container(
        color: Colors.amber,
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == 'fail')
                      return Center(
                          child: Text(
                        "لا يوجد ملاحظات",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ));
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return cardnote(
                            ondeletenote: () async {
                              var response = await PostRequest(linkDelete, {
                                "id": snapshot.data['data'][i]['notes_id']
                                    .toString(),
                                "imagename": snapshot.data['data'][i]
                                        ['notes_image']
                                    .toString(),
                              });
                              if (response['status'] == 'success') {
                                Navigator.of(context)
                                    .pushReplacementNamed("home");
                              }
                            },
                            ontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => editnotes(
                                        notes: snapshot.data['data'][i],
                                      )));
                            },
                            notesModel:
                                NotesModel.fromJson(snapshot.data['data'][i]),
                          );
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading..."),
                    );
                  }
                  return Center(
                    child: Text("Loading..."),
                  );
                })
          ],
        ),
      ),
    );
  }
}
