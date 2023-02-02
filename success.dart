import 'package:flutter/material.dart';

import 'component.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "تم انشاء الحساب بنجاح الان يمكنك تسجيل الدخول ",
              style: Font_style_1,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            child: Text(
              "تسجيل الدخول",
              style: Font_style_1,
            ),
            style: Button_style_2,
          ),
        ],
      ),
    );
  }
}
