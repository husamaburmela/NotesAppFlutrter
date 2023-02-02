import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend_api_php_wael/component.dart';
import 'package:flutter_frontend_api_php_wael/crud.dart';
import 'package:flutter_frontend_api_php_wael/linkapi.dart';
import 'package:flutter_frontend_api_php_wael/main.dart';

class login extends StatefulWidget {
  login({super.key});
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud crud = Crud();
  bool isloading = false;
  login() async {
    if (formstate.currentState!.validate()) // for validations
    {
      isloading = true;
      setState(() {});
      var response = await crud.PostRequest(linkLogin, {
        "email": email.text,
        "password": password.text,
      });
      isloading = false;
      setState(() {});
      if (response['status'] == "success") {
        sharedPreferences!.setString("id", response["data"]["id"].toString());
        sharedPreferences!.setString("username", response["data"]["username"]);
        sharedPreferences!.setString("email", response["data"]["email"]);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(
            context: context,
            title: "alert",
            body: Text("email or password is wrong"))
          ..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
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
                            return validInput(val!, 4, 20);
                          },
                        ),
                        CustomTextField1(
                          hint: "password",
                          mycontroller: password,
                          valid: (val) {
                            return validInput(val!, 4, 10);
                          },
                        ),
                        ElevatedButton(
                          style: Button_style_2,
                          onPressed: () async {
                            await login();
                          },
                          child: Text("login"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("signup");
                          },
                          child: Text("SignUp"),
                        )
                      ],
                    ))
              ]),
            ),
    );
  }
}
