import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

//this tow line for set password and username in app to access api php
String _basicAuth = 'Basic ' + base64Encode(utf8.encode('wael:wael12345'));
Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  //for select or read
  //IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII  // Get Request
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url), headers: myheaders);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else
        print("Error${response.statusCode}");
    } catch (e) {
      print("Error catch $e");
    }
  }

//for update ,create,delete without file
  //IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII  // Post Request
  PostRequest(String url, Map data) async {
    // await Future.delayed( Duration(seconds: 2)); //this for test prograse ciricle in loading
    try {
      var response =
          await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else
        print("Error${response.statusCode}");
    } catch (e) {
      print("Error catch $e");
    }
  }

//for upload file
  //IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII  // Post Requestwith file
  PostRequestwithfile(String url, Map data, File file) async {
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var reqoust = http.MultipartRequest("POST", Uri.parse(url));
    var multipartfile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    reqoust.headers.addAll(myheaders);
    reqoust.files.add(multipartfile);
    data.forEach((key, value) {
      reqoust.fields[key] = value;
    });
    var myreques = await reqoust.send();
    var response = await http.Response.fromStream(myreques);
    if (myreques.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error ${myreques.statusCode}");
    }
  }
}
