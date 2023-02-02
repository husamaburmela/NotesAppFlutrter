import 'package:flutter/material.dart';
import 'package:flutter_frontend_api_php_wael/NotesModelPage.dart';

import 'linkapi.dart';

class cardnote extends StatelessWidget {
  final void Function()? ontap;
  final NotesModel notesModel;
  final void Function()? ondeletenote;
  const cardnote(
      {super.key,
      required this.ontap,
      required this.ondeletenote,
      required this.notesModel});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Image.network("$linkImageroot/${notesModel.notesImage}",
                    width: 100, height: 100, fit: BoxFit.fill)),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${notesModel.notesTitle}"),
                  subtitle: Text("${notesModel.notesContent}"),
                  trailing: IconButton(
                      onPressed: ondeletenote, icon: Icon(Icons.delete)),
                )),
          ],
        ),
      ),
    );
  }
}
