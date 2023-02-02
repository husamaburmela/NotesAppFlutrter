import 'package:flutter/material.dart';
import 'package:flutter_frontend_api_php_wael/component.dart';
import 'package:flutter_frontend_api_php_wael/crud.dart';

import 'linkapi.dart';

class signup extends StatefulWidget {
  signup({super.key});
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  Crud _crud = Crud();
  bool isloading = false;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  signup() async {
    if (formstate.currentState!.validate()) // for validations
    {
      isloading = true;
      setState(() {});
      var response = await _crud.PostRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });
      isloading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        print("signup fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('signup'),
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: ListView(children: [
                Form(
                    key: formstate,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/1.png",
                          width: 200,
                          height: 200,
                        ),
                        CustomTextField1(
                          hint: "email",
                          mycontroller: email,
                          valid: (val) {
                            return validInput(val!, 5, 40);
                          },
                        ),
                        CustomTextField1(
                          hint: "password",
                          mycontroller: password,
                          valid: (val) {
                            return validInput(val!, 6, 10);
                          },
                        ),
                        CustomTextField1(
                          hint: "username",
                          mycontroller: username,
                          valid: (val) {
                            return validInput(val!, 4, 20);
                          },
                        ),
                        ElevatedButton(
                          style: Button_style_2,
                          onPressed: () async {
                            signup();
                          },
                          child: Text("signup"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("login");
                          },
                          child: Text("login"),
                        )
                      ],
                    ))
              ]),
            ),
    );
  }
}
